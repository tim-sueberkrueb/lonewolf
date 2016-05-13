import QtQuick 2.4
import Ubuntu.Components 1.3

Item {
    id: root

    property var model
    property string title
    property string description
    property var product: null
    property bool buying
    signal startBook(string book)

    height: column.height

    Column {
        id: column
        spacing: units.gu(2)
        width: parent.width

        Item {
            width: parent.width
            height: title.height //Math.max(title.height, buyButton.height)
            Label {
                id: title
                text: root.title
                fontSize: "large"
                font.bold: true
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.right: parent.right //buyButton.left
                verticalAlignment: Text.AlignBottom
            }
            /*Button {
                id: buyButton
                visible: root.product && !root.product.bought
                enabled: !root.buying
                text: "$2.99"
                color: theme.palette.normal.positive
                anchors.right: parent.right
                anchors.top: parent.top
            }*/
        }
        Label {
            text: root.description
            width: parent.width
            wrapMode: Text.Wrap
        }
        Flow {
            id: buttonFlow
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - marginWidth * 2
            spacing: units.gu(3)
            property real buttonWidth: units.gu(6)
            property real marginWidth: (parent.width - buttonWidth) % (buttonWidth + spacing) / 2
            Repeater {
                model: root.model
                delegate: Button {
                    iconName: (root.product && !root.product.bought) ? "locked" : ""
                    text: (root.product && !root.product.bought) ? "" : index + 1
                    onClicked: root.startBook(book)
                    width: buttonFlow.buttonWidth
                    height: width
                    color: "#203432"
                    //enabled: !root.product || root.product.bought
                }
            }
        }
    }
}

