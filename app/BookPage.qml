import QtQuick 2.4
import Ubuntu.Components 1.2
import Ubuntu.Components.Popups 1.0
import Ubuntu.Web 0.2
import Lonewolf 1.0

Page {
    id: root
    title: book.pageTitle

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
        Action {
            id: quickSave
            iconName: "save"
            text: i18n.tr("Quick Save")
            visible: book.progress == 100
            onTriggered: {
                if (quickSaveState.pageId == "") {
                    PopupUtils.open(saveDialog);
                }
                you.copyTo(quickSaveState);
            }
        },
        Action {
            id: actionChart
            iconName: "note"
            text: i18n.tr("Action Chart")
            visible: book.progress == 100
            onTriggered: pageStack.push(Qt.resolvedUrl("ChartPage.qml"), {you: root.you})
        }
    ]

    Book {
        id: book
        dir: Qt.resolvedUrl(".")
        filename: you.book
        pageId: you.pageId == "" ? firstPageId : you.pageId
        onPageIdChanged: {
            var content = pageContent;
            console.log(filename, pageId, content);
            pageView.loadHtml(content, Qt.resolvedUrl(book.cacheDir) + "/");
        }
    }

    WebView {
        id: pageView
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
                    actionChart.trigger();
                    model.accept();
                } else if (model.message == "dead") {
                    root.you.endurance = 0;
                } else if (model.message.indexOf("combat,") == 0) {
                    combat.props = model.message;
                    combat.visible = true;
                } else {
                    you.pageId = model.message;
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
        height: (previous.visible || next.visible) ? units.gu(6) : 0

        Button {
            id: previous
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: units.gu(0.5)
            height: parent.height - units.gu(1)
            width: height
            iconName: "go-previous"
            visible: book.prevPageId != ""
            onClicked: you.pageId = book.prevPageId
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
            onClicked: you.pageId = book.nextPageId
        }
    }

    Rectangle {
        color: "white"
        anchors.fill: parent
        opacity: book.progress == 100 ? 0 : 1
        Behavior on opacity { UbuntuNumberAnimation {} }
        MouseArea {
            anchors.fill: parent
            enabled: parent.opacity == 1
        }
        Item {
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
                minimumValue: 0
                maximumValue: 100
                value: book.progress
                anchors.top: downloadLabel.bottom
                anchors.topMargin: units.gu(1)
                anchors.left: parent.left
                anchors.right: parent.right
            }
        }
    }

    // Download book once we're idle
    Timer {
        interval: 1000
        running: true
        onTriggered: book.downloadBook()
    }
}
