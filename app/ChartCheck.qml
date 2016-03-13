import QtQuick 2.4
import Ubuntu.Components 1.3

Row {
    property var you
    property string prop
    property alias checked: box.checked
    property alias text: label.text
    spacing: units.gu(0.5)
    Binding {
        target: you
        property: prop
        value: box.checked
    }
    CheckBox {
        id: box
        anchors.verticalCenter: parent.verticalCenter
    }
    Label {
        id: label
        anchors.verticalCenter: parent.verticalCenter
    }
}

