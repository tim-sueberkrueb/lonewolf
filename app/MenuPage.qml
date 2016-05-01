import QtQuick 2.4
import Ubuntu.Components 1.3
import Lonewolf 1.0

Page {
    id: root
    flickable: null

    header: PageHeader {
        title: "Lone Wolf"
        trailingActionBar.actions: [
            Action {
                iconName: "display-brightness-symbolic"
                text: nightModeText
                onTriggered: triggerNightMode(root)
            }
        ]
    }

    function startBook(book, pageId) {
        gameState.book = book;
        gameState.pageId = pageId;
        goToBookTab();
    }

    Flickable {
        id: flicker
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        contentHeight: column.height + column.anchors.margins * 2
        contentWidth: width

        Column {
            id: column
            spacing: units.gu(2)
            x: anchors.margins
            y: anchors.margins
            anchors.margins: units.gu(2)
            width: (flicker.contentWidth > units.gu(60) ? units.gu(60) : flicker.contentWidth) - anchors.margins * 2
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                text: "<p>Lone Wolf is a role-playing book series from the 80s.</p><br>" +
                      "<p>This app lets you play the old adventures, but the text is not updated.  It may refer to things like pencils that assume you are playing with an actual book.  And it relies on the honor system a bit.  Just roll with it.</p><br>" +
                      "<p>If you have any rules questions or encounter an ambiguity, try the <a href='http://www.projectaon.org/en/ReadersHandbook/Home'>Reader's Handbook</a>.</p>"
                linkColor: Theme.palette.selected.backgroundText
                onLinkActivated: Qt.openUrlExternally(link)
                wrapMode: Text.Wrap
                width: parent.width
            }

            Button {
                text: gameState.book == "" && gameState.pageId == "" ? "Start Book 1" : "Continue"
                onClicked: goToBookTab()
                color: UbuntuColors.green
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Load Quick Save"
                enabled: quickSaveState.pageId != ""
                onClicked: loadQuickSave()
                color: UbuntuColors.red
                anchors.horizontalCenter: parent.horizontalCenter
            }

            ListModel {
                id: kaiModel
                ListElement { book: "01fftd" }
                ListElement { book: "02fotw" }
                ListElement { book: "03tcok" }
                ListElement { book: "04tcod" }
                ListElement { book: "05sots" }
            }
            ListModel {
                id: magnakaiModel
                ListElement { book: "06tkot" }
                ListElement { book: "07cd" }
                ListElement { book: "08tjoh" }
                ListElement { book: "09tcof" }
                ListElement { book: "10tdot" }
                ListElement { book: "11tpot" }
                ListElement { book: "12tmod" }
            }
            ListModel {
                id: grandmasterModel
                ListElement { book: "13tplor" }
                ListElement { book: "14tcok" }
                ListElement { book: "15tdc" }
                ListElement { book: "16tlov" }
                ListElement { book: "17tdoi" }
                ListElement { book: "18dotd" }
                ListElement { book: "19wb" }
                ListElement { book: "20tcon" }
            }
            ListModel {
                id: neworderModel
                ListElement { book: "21votm" }
                ListElement { book: "22tbos" }
                ListElement { book: "23mh" }
                ListElement { book: "24rw" }
                ListElement { book: "25totw" }
                ListElement { book: "26tfobm" }
                ListElement { book: "27v" }
                ListElement { book: "28thos" }
            }

            Item {
                height: 1
                width: 1
            }
            BookList {
                model: kaiModel
                title: "Kai Series"
                description: "Save your country from a looming threat.\nStart here if you've never played before."
                onStartBook: root.startBook(book, "")
                width: parent.width
            }
            Item {
                height: 1
                width: 1
            }
            BookList {
                model: magnakaiModel
                title: "Magnakai Series"
                description: "Save the realm from the Darklords by collecting the Lorestones of Varetta."
                onStartBook: root.startBook(book, "")
                width: parent.width
                //product: magnakaiProduct
            }
            Item {
                height: 1
                width: 1
            }
            BookList {
                model: grandmasterModel
                title: "Grandmaster Series"
                description: "Save the world from the Dark God Naar and his minions."
                onStartBook: root.startBook(book, "")
                width: parent.width
                //product: grandmasterProduct
            }
            Item {
                height: 1
                width: 1
            }
            BookList {
                model: neworderModel
                title: "New Order Series"
                description: "Continue thwarting the forces of evil as one of Lone Wolf's disciples."
                onStartBook: root.startBook(book, "")
                width: parent.width
                //product: neworderProduct
            }
            Item {
                height: 1
                width: 1
            }
        }
    }

    Scrollbar {
        id: scrollbar
        flickableItem: flicker
    }
}

