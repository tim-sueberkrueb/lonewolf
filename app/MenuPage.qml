import QtQuick 2.4
import Ubuntu.Components 1.2
import Lonewolf 1.0

Page {
    id: root
    title: "Lone Wolf"

    head.actions: [
        nightMode
    ]

    function startBook(book, pageId) {
        gameState.book = book;
        gameState.pageId = pageId;
        goToBookTab(true);
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
                text: gameState.book == "" && gameState.pageId == "title" ? "Start Book 1" : "Continue"
                onClicked: goToBookTab(false)
                color: UbuntuColors.green
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Load Quick Save"
                enabled: quickSaveState.pageId != ""
                onClicked: {
                    quickSaveState.copyTo(gameState);
                    goToBookTab(true);
                }
                color: UbuntuColors.red
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
            Button {
                text: "Start The Plague Lords of Ruel (Book 13)"
                onClicked: startBook("13tplor", "")
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Start The Captives of Kaag (Book 14)"
                onClicked: startBook("14tcok", "")
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Start The Darke Crusade (Book 15)"
                onClicked: startBook("15tdc", "")
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Start The Legacy of Vashna (Book 16)"
                onClicked: startBook("16tlov", "")
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Start The Deathlord of Ixia (Book 17)"
                onClicked: startBook("17tdoi", "")
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Start Dawn of the Dragons (Book 18)"
                onClicked: startBook("18dotd", "")
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Start Wolf's Bane (Book 19)"
                onClicked: startBook("19wb", "")
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Start The Curse of Naar (Book 20)"
                onClicked: startBook("20tcon", "")
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}

