import QtQuick 2.4
import Ubuntu.Components 1.2

TextField {
    property var you
    property string prop
    Binding {
        target: you
        property: prop
        value: text
    }
}

