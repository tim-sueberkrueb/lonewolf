import QtQuick 2.4
import Ubuntu.Components 1.2
import Lonewolf 1.0

Rectangle {
    id: root
    color: "black"
    opacity: 0.95

    property string props
    property var you
    signal close()

    QtObject {
        id: d
        property int round: 1
        property string enemy
        property int combatskill
        property int endurance
        property int youcombatskill
        property bool done: you.endurance <= 0 || endurance <= 0
    }

    Component.onCompleted: {
        var elements = props.split(',');
        for (var i = 0; i < elements.length; i++) {
            var keyvalue = elements[i].split('=');
            if (keyvalue[0] == 'enemy') {
                d.enemy = keyvalue[1];
            } else if (keyvalue[0] == 'combatskill') {
                d.combatskill = keyvalue[1];
            } else if (keyvalue[0] == 'endurance') {
                d.endurance = keyvalue[1];
            }
        }

        d.youcombatskill = root.you.combatskill; // Make copy
    }

    Label {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: units.gu(1)
        horizontalAlignment: Text.AlignHCenter
        text: "Round " + d.round
        color: "white"
    }

    Item {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: fleeButton.top
        anchors.topMargin: units.gu(6)
        Column {
            anchors.right: parent.horizontalCenter
            anchors.left: parent.left
            Label {
                text: "You"
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Item { height: units.gu(3); width: units.gu(1); }
            Label {
                text: you.endurance > 0 ? you.endurance : "DEAD"
                color: you.endurance > 0 ? "white" : UbuntuColors.red
                fontSize: "x-large"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Label {
                text: "ENDURANCE"
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Item { height: units.gu(3); width: units.gu(1); }
            Label {
                id: youcombatskillLabel
                text: d.youcombatskill
                color: "white"
                fontSize: "x-large"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                Button {
                    anchors.left: youcombatskillLabel.right
                    anchors.leftMargin: units.gu(1)
                    anchors.verticalCenter: youcombatskillLabel.verticalCenter
                    width: units.gu(3)
                    text: "+"
                    enabled: !d.done
                    onClicked: d.youcombatskill += 1
                    color: "transparent"
                }
                Button {
                    anchors.right: youcombatskillLabel.left
                    anchors.rightMargin: units.gu(1)
                    anchors.verticalCenter: youcombatskillLabel.verticalCenter
                    width: units.gu(3)
                    text: "-"
                    enabled: !d.done
                    onClicked: d.youcombatskill -= 1
                    color: "transparent"
                }
            }
            Label {
                text: "COMBAT SKILL"
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
        Column {
            anchors.left: parent.horizontalCenter
            anchors.right: parent.right
            Label {
                text: d.enemy
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Item { height: units.gu(3); width: units.gu(1); }
            Label {
                text: d.endurance > 0 ? d.endurance : "DEAD"
                color: d.endurance > 0 ? "white" : UbuntuColors.red
                fontSize: "x-large"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Label {
                text: "ENDURANCE"
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Item { height: units.gu(3); width: units.gu(1); }
            Label {
                id: combatskillLabel
                text: d.combatskill
                color: "white"
                fontSize: "x-large"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                Button {
                    anchors.left: combatskillLabel.right
                    anchors.leftMargin: units.gu(1)
                    anchors.verticalCenter: combatskillLabel.verticalCenter
                    width: units.gu(3)
                    text: "+"
                    enabled: !d.done
                    onClicked: d.combatskill += 1
                    color: "transparent"
                }
                Button {
                    anchors.right: combatskillLabel.left
                    anchors.rightMargin: units.gu(1)
                    anchors.verticalCenter: combatskillLabel.verticalCenter
                    width: units.gu(3)
                    text: "-"
                    enabled: !d.done
                    onClicked: d.combatskill -= 1
                    color: "transparent"
                }
            }
            Label {
                text: "COMBAT SKILL"
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    Button {
        id: cancelButton
        text: "Back to Page"
        color: UbuntuColors.lightGrey
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: fleeButton.top
        anchors.bottomMargin: units.gu(1)
        visible: d.round == 1 || d.done
        onClicked: {
            root.close();
        }
    }
    Button {
        id: fleeButton
        text: "Evade"
        color: UbuntuColors.red
        anchors.left: parent.left
        anchors.right: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.topMargin: units.gu(1)
        anchors.bottomMargin: units.gu(1)
        anchors.leftMargin: units.gu(1)
        anchors.rightMargin: units.gu(0.5)
        enabled: !d.done
        onClicked: {
            var rand = Util.getRandom();
            var delta = d.youcombatskill - d.combatskill;

            var damageToYou = Util.getDamageToYou(delta, rand);
            if (damageToYou < 0) {
                you.endurance = 0;
            } else {
                you.endurance = Math.max(you.endurance - damageToYou, 0);
            }

            d.done = true;
        }
    }
    Button {
        text: "Fight"
        color: UbuntuColors.green
        anchors.right: parent.right
        anchors.left: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.topMargin: units.gu(1)
        anchors.bottomMargin: units.gu(1)
        anchors.rightMargin: units.gu(1)
        anchors.leftMargin: units.gu(0.5)
        enabled: !d.done
        onClicked: {
            d.round++;

            var rand = Util.getRandom();
            var delta = d.youcombatskill - d.combatskill;

            var damageToYou = Util.getDamageToYou(delta, rand);
            if (damageToYou < 0) {
                you.endurance = 0;
            } else {
                you.endurance = Math.max(you.endurance - damageToYou, 0);
            }

            var damageToEnemy = Util.getDamageToEnemy(delta, rand);
            if (damageToEnemy < 0) {
                d.endurance = 0;
            } else {
                d.endurance = Math.max(d.endurance - damageToEnemy, 0);
            }
        }
    }
}
