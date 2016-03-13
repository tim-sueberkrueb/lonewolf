import QtQuick 2.4
import Ubuntu.Components 1.3

TextField {
    property var you
    property string prop
    Binding {
        target: you
        property: prop
        value: text
    }
}

