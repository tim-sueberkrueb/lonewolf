import QtQuick 2.4
import Ubuntu.Components 1.2
import Ubuntu.Components.Popups 1.0
import Ubuntu.Web 0.2
import Lonewolf 1.0

Page {
    id: root
    title: book.pageTitle
    flickable: null

    property var you

    Component {
        id: saveDialog
        Dialog {
            id: dialog
            title: "Quick Save"
            text: "This will save your current game state in case you want to load it later.  You can only load from the most recent time you saved."
            Button {
                text: "Got it"
                onClicked: PopupUtils.close(dialog)
            }
        }
    }

    head.actions: [
        actionChart, quickSave, mapAction, nightMode
    ]

    Action {
        id: actionChart
        iconName: "note"
        text: i18n.tr("Action Chart")
        visible: book.progress == 100
        onTriggered: goToChartTab()
    }

    Action {
        id: quickSave
        iconName: "save"
        text: i18n.tr("Quick Save")
        visible: book.progress == 100
        enabled: !book.inBackMatter && you.endurance > 0
        onTriggered: {
            if (quickSaveState.pageId == "") {
                PopupUtils.open(saveDialog);
            }
            you.copyTo(quickSaveState);
        }
    }

    Action {
        id: mapAction
        iconName: "location"
        text: i18n.tr("Map")
        visible: book.progress == 100
        onTriggered: pageView.pageId = "map"
    }

    head.contents: Rectangle {
        color: Theme.palette.normal.background
        Label {
            id: headTitle
            text: root.title
            fontSize: "x-large"
            font.weight: Font.Light
            elide: Text.ElideRight
            anchors.left: parent.left
            anchors.right: headEndurance.left
            anchors.verticalCenter: parent.verticalCenter
        }
        Item {
            id: headEndurance
            visible: Number(root.title) > 0
            width: visible ? childrenRect.width : 0
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            Label {
                id: youenduranceLabel
                text: you.endurance + " <span style='font-variant: small-caps'>EP</span>"
                fontSize: "large"
                textFormat: Text.RichText
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.rightMargin: units.gu(2)
                anchors.right: parent.right
                verticalAlignment: Text.AlignVCenter
                Label {
                    anchors.left: parent.right
                    anchors.leftMargin: units.gu(1)
                    anchors.verticalCenter: parent.verticalCenter
                    text: "+"
                    opacity: you.endurance < you.maxendurance ? 1 : 0.5
                }
                Label {
                    anchors.right: parent.left
                    anchors.rightMargin: units.gu(1)
                    anchors.verticalCenter: parent.verticalCenter
                    text: "-"
                    opacity: you.endurance > 0 ? 1 : 0.5
                }
                MouseArea {
                    anchors.left: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    width: parent.width / 2 + units.gu(4)
                    enabled: you.endurance < you.maxendurance
                    onClicked: {
                        Haptics.play();
                        you.endurance += 1;
                    }
                }
                MouseArea {
                    anchors.right: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    width: parent.width / 2 + units.gu(4)
                    enabled: you.endurance > 0
                    onClicked: {
                        Haptics.play();
                        you.endurance -= 1;
                    }
                }
            }
        }
        height: parent ? parent.height - units.gu(2) : undefined
        width: parent ? parent.width - units.gu(2) : undefined
    }

    Book {
        id: book
        dir: Qt.resolvedUrl(".")
        filename: you.book ? you.book : "01fftd"
        pageId: pageView.pageId

        // Only respect theme in night mode because in "normal" day mode,
        // we want our background to blend with illustrations.
        bgColor: settings.nightMode ? Theme.palette.normal.field : "white"
        textColor: settings.nightMode ? Theme.palette.normal.fieldText : "black"
        linkColor: settings.nightMode ? Theme.palette.selected.selection : "blue"

        property bool inBackMatter: false

        onPageContentChanged: {
            if (pageId == "" && pageView.pageId != "")
                return; // on startup we get this fake-out...
            var content = pageContent;
            if (pageType == "backmatter") {
                inBackMatter = true;
            } else if (!inBackMatter) {
                you.pageId = pageId; // save place
            }
            //console.log("MIKE page:", content);
            pageView.loadHtml(content, Qt.resolvedUrl(book.cacheDir) + "/");
        }
    }

    WebView {
        id: pageView
        property string pageId: you.pageId
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: navigation.top
        alertDialog: Item {
            anchors.fill: parent

            Component.onCompleted: {
                if (model.message == "random") {
                    random.visible = true;
                } else if (model.message == "action") {
                    Haptics.play();
                    actionChart.trigger();
                    model.accept();
                } else if (model.message == "dead") {
                    root.you.endurance = 0;
                    model.accept();
                } else if (model.message.indexOf("combat,") == 0) {
                    combat.props = model.message;
                    combat.visible = true;
                } else if (model.message.indexOf("external,") == 0) {
                    Qt.openUrlExternally(model.message.split(',')[1]);
                    model.accept();
                } else if (model.message.indexOf("puzzle-page,") == 0) {
                    puzzle.answers = model.message.split(',')[1];
                    puzzle.visible = true;
                } else if (model.message.indexOf("book,") == 0) {
                    if (model.message.split(',')[2] != "21votm") {
                        Haptics.play();
                        you.book = model.message.split(',')[2];
                        pageView.pageId = "";
                    }
                    model.accept();
                } else {
                    Haptics.play();
                    pageView.pageId = model.message;
                    model.accept();
                }
            }

            MouseArea {
                anchors.fill: parent
                // eat events that fall through
            }

            Combat {
                id: combat
                anchors.fill: parent
                visible: false
                you: root.you
                onClose: model.accept()
            }

            Puzzle {
                id: puzzle
                anchors.fill: parent
                visible: false
                you: root.you
                onClose: model.accept()
                onGoTo: {
                    pageView.pageId = page;
                    model.accept();
                }
            }

            Rectangle {
                id: random
                anchors.fill: parent
                color: "black"
                opacity: 0.95
                visible: false
                Column {
                    spacing: units.gu(1)
                    anchors.centerIn: parent
                    Label {
                        text: "Your random number is:"
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        wrapMode: Text.Wrap
                    }
                    Label {
                        text: Util.getRandom()
                        fontSize: "x-large"
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: model.accept()
                }
            }
        }
    }

    Rectangle {
        id: navigation
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: (previous.visible || next.visible || licenseButton.visible) ? units.gu(6) : 0
        color: Theme.palette.normal.background

        Button {
            id: previous
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: units.gu(0.5)
            height: parent.height - units.gu(1)
            width: height
            iconName: "go-previous"
            visible: book.prevPageId != "" || book.inBackMatter
            onClicked: {
                if (book.inBackMatter) {
                    pageView.pageId = you.pageId; // go back to saved place
                    book.inBackMatter = false;
                } else {
                    pageView.pageId = book.prevPageId;
                }
            }
        }
        Button {
            id: next
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: units.gu(0.5)
            height: parent.height - units.gu(1)
            width: height
            iconName: "go-next"
            visible: book.nextPageId != ""
            onClicked: pageView.pageId = book.nextPageId
        }

        Button {
            id: licenseButton
            text: "Accept"
            color: UbuntuColors.green
            visible: book.progress < 100
            anchors.centerIn: parent
            onClicked: {
                cancelDownloadButton.visible = true; // can't actually cancel before this (we download xml synchronously)
                downloadCover.visible = true;
                pageView.pageId = "";
                book.downloadImages();
            }
        }
    }

    Rectangle {
        id: downloadCover
        color: Theme.palette.normal.background
        anchors.fill: parent
        opacity: book.progress == 100 ? 0 : 1
        Behavior on opacity { UbuntuNumberAnimation {} }
        MouseArea {
            anchors.fill: parent
            enabled: parent.opacity == 1
        }
        Item {
            id: downloadPage
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: units.gu(2)
            anchors.rightMargin: units.gu(2)
            height: childrenRect.height
            Label {
                id: downloadLabel
                text: "Downloading..."
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
            }
            ProgressBar {
                id: progressBar
                minimumValue: 0
                maximumValue: 100
                value: book.progress
                anchors.top: downloadLabel.bottom
                anchors.topMargin: units.gu(1)
                anchors.left: parent.left
                anchors.right: parent.right
            }
            Button {
                id: cancelDownloadButton
                text: "Cancel"
                visible: false
                color: UbuntuColors.red
                anchors.top: progressBar.bottom
                anchors.topMargin: units.gu(1)
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: pageStack.pop()
            }
        }

        // Download book once we're idle
        Timer {
            interval: 1000
            running: true
            onTriggered: {
                if (book.progress < 100) {
                    book.downloadBook();
                    pageView.pageId = "license";
                    book.inBackMatter = false;
                    downloadCover.visible = false;
                }
            }
        }
    }
}
