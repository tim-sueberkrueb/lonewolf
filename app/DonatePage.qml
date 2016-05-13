import QtQuick 2.4
import QtPurchasing 1.0
import Ubuntu.Components 1.3
import Lonewolf 1.0

Page {
    id: root
    flickable: null

    header: PageHeader {
        title: "Donate"
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
            spacing: units.gu(6)
            x: anchors.margins
            y: anchors.margins
            anchors.margins: units.gu(2)
            width: (flicker.contentWidth > units.gu(60) ? units.gu(60) : flicker.contentWidth) - anchors.margins * 2
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                text: "This app is a labor of love.  But it's still labor.  If you've enjoyed the app and want to say thank you, consider donating.\n\nAs a bonus, donating will unlock Night Mode to help your eyes when reading in the dark."
                wrapMode: Text.Wrap
                width: parent.width
            }

            Button {
                enabled: !settings.donated && !donationProduct.purchasing && donationProduct.status === Product.Registered
                text: settings.donated ? "Thank you!" : "Donate " + donationProduct.price
                color: theme.palette.normal.positive
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    donationProduct.purchasing = true;
                    donationProduct.purchase();
                }
            }

            Label {
                text: "The text and images used in this app are from Project Aon's adaptations of Joe Dever's original books.  They also <a href=\"https://www.projectaon.org/en/Main/HelpUs#donations\">accept donations</a>."
                linkColor: Theme.palette.selected.backgroundText
                onLinkActivated: Qt.openUrlExternally(link)
                wrapMode: Text.Wrap
                width: parent.width
            }
        }
    }

    Scrollbar {
        id: scrollbar
        flickableItem: flicker
    }
}

