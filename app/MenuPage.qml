import QtQuick 2.4
import Ubuntu.Components 1.2
import Lonewolf 1.0

Page {
    id: root
    title: "Lone Wolf"

    function startBook(book, pageId) {
        gameState.book = book;
        gameState.pageId = pageId;
        pageStack.push(Qt.resolvedUrl("BookPage.qml"), {you: gameState})
    }

    Flickable {
        id: flicker
        anchors.fill: parent
        anchors.margins: units.gu(1)
        contentHeight: column.height
        contentWidth: root.width - units.gu(2)

        Column {
            id: column
            spacing: units.gu(1)

            Label {
                text: "Lone Wolf is a role-playing book series from the 80s.  This app lets you play the old adventures, but the text is not updated.  It may refer to things like pencils that assume you are playing with an actual book.  And it relies on the honor system a bit.  Just roll with it."
                wrapMode: Text.Wrap
                width: flicker.width
            }

            Button {
                text: "Continue"
                enabled: gameState.book != ""
                onClicked: startBook(gameState.book, gameState.pageId)
                color: UbuntuColors.green
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Load Quick Save"
                enabled: quickSaveState.book != ""
                onClicked: {
                    quickSaveState.copyTo(gameState);
                    startBook(gameState.book, gameState.pageId);
                }
                color: UbuntuColors.green
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Start Flight From the Dark (Book 1)"
                onClicked: startBook("01fftd", "")
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Start Fire on the Water (Book 2)"
                onClicked: startBook("02fotw", "")
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Start The Caverns of Kalte (Book 3)"
                onClicked: startBook("03tcok", "")
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Start The Chasm of Doom (Book 4)"
                onClicked: startBook("04tcod", "")
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Start Shadows on the Sand (Book 5)"
                onClicked: startBook("05sots", "")
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Start The Kingdoms of Terror (Book 6)"
                onClicked: startBook("06tkot", "")
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Start Castle Death (Book 7)"
                onClicked: startBook("07cd", "")
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Start The Jungle of Horrors (Book 8)"
                onClicked: startBook("08tjoh", "")
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Start The Cauldron of Fear (Book 9)"
                onClicked: startBook("09tcof", "")
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Start The Dungeons of Torgar (Book 10)"
                onClicked: startBook("10tdot", "")
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Start The Prisoners of Time (Book 11)"
                onClicked: startBook("11tpot", "")
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Start The Masters of Darkness (Book 12)"
                onClicked: startBook("12tmod", "")
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}

