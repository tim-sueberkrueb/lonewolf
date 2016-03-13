import QtQuick 2.4
import Ubuntu.Components 1.3
import Lonewolf 1.0

Page {
    id: root
    flickable: null

    header: PageHeader {
        title: "Lone Wolf"
        trailingActionBar.actions: [
            nightMode
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
            width: flicker.contentWidth - anchors.margins * 2

            Label {
                text: "<p>Lone Wolf is a role-playing book series from the 80s.</p><br>" +
                      "<p>This app lets you play the old adventures, but the text is not updated.  It may refer to things like pencils that assume you are playing with an actual book.  And it relies on the honor system a bit.  Just roll with it.</p><br>" +
                      "<p>If you have any rules questions or encounter an ambiguity, try the <a href='http://www.projectaon.org/en/ReadersHandbook/Home'>Reader's Handbook</a>.</p>"
                linkColor: Theme.palette.selected.backgroundText
                onLinkActivated: Qt.openUrlExternally(link)
                wrapMode: Text.Wrap
                width: parent.width > units.gu(60) ? units.gu(60) : parent.width
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Button {
                text: gameState.book == "" && gameState.pageId == "title" ? "Start Book 1" : "Continue"
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
                id: bookModel
                ListElement { book: "01fftd"; series: "kai" }
                ListElement { book: "02fotw"; series: "kai" }
                ListElement { book: "03tcok"; series: "kai" }
                ListElement { book: "04tcod"; series: "kai" }
                ListElement { book: "05sots"; series: "kai" }
                ListElement { book: "06tkot"; series: "magnakai" }
                ListElement { book: "07cd"; series: "magnakai" }
                ListElement { book: "08tjoh"; series: "magnakai" }
                ListElement { book: "09tcof"; series: "magnakai" }
                ListElement { book: "10tdot"; series: "magnakai" }
                ListElement { book: "11tpot"; series: "magnakai" }
                ListElement { book: "12tmod"; series: "magnakai" }
                ListElement { book: "13tplor"; series: "grandmaster" }
                ListElement { book: "14tcok"; series: "grandmaster" }
                ListElement { book: "15tdc"; series: "grandmaster" }
                ListElement { book: "16tlov"; series: "grandmaster" }
                ListElement { book: "17tdoi"; series: "grandmaster" }
                ListElement { book: "18dotd"; series: "grandmaster" }
                ListElement { book: "19wb"; series: "grandmaster" }
                ListElement { book: "20tcon"; series: "grandmaster" }
                ListElement { book: "21votm"; series: "neworder" }
                ListElement { book: "22tbos"; series: "neworder" }
                ListElement { book: "23mh"; series: "neworder" }
                ListElement { book: "24rw"; series: "neworder" }
                ListElement { book: "25totw"; series: "neworder" }
                ListElement { book: "26tfobm"; series: "neworder" }
                ListElement { book: "27v"; series: "neworder" }
                ListElement { book: "28thos"; series: "neworder" }
            }

            Item {
                height: 1
                width: 1
            }
            Label {
                text: "All Books"
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
            }
            Flow {
                id: buttonFlow
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - marginWidth * 2
                spacing: units.gu(3)
                property real buttonWidth: units.gu(6)
                property real marginWidth: (parent.width - buttonWidth) % (buttonWidth + spacing) / 2
                Repeater {
                    model: bookModel
                    delegate: Button {
                        text: index + 1
                        onClicked: startBook(book, "")
                        width: buttonFlow.buttonWidth
                        height: width
                        color: series == "kai" ? "#203432" :
                               series == "magnakai" ? "#425654" :
                               series == "grandmaster" ? "#647865" : "#869a87"
                    }
                }
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

