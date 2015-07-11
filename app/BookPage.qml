import QtQuick 2.4
import Ubuntu.Components 1.2
import Ubuntu.Components.Popups 1.0
import Ubuntu.Web 0.2
import Lonewolf 1.0

Page {
    id: root
    title: book.pageTitle

    property var you

    head.actions: [
        Action {
            id: actionChart
            iconName: "note"
            text: i18n.tr("Action Chart")
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
            pageView.loadHtml(content, Qt.resolvedUrl("."));
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
}
