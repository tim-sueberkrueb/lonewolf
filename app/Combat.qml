import QtQuick 2.4
import Ubuntu.Components 1.3
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
        property bool enduranceIsYours: false // true if we want to write endurance back to game state
        property int round: 1
        property string enemy
        property int combatskill
        property int endurance
        property int youcombatskill
        property int youendurance
        property bool done: youendurance <= 0 || endurance <= 0
    }

    Component.onCompleted: {
        // Make copies
        d.youendurance = mainView.endurance;
        d.youcombatskill = mainView.combatskill;

        var elements = props.split(',');
        for (var i = 0; i < elements.length; i++) {
            var keyvalue = elements[i].split('=');
            if (keyvalue[0] == 'enemy') {
                d.enemy = keyvalue[1];
            } else if (keyvalue[0] == 'combatskill') {
                d.combatskill = keyvalue[1];
            } else if (keyvalue[0] == 'endurance') {
                d.endurance = keyvalue[1];
                d.enduranceIsYours = true;
            } else if (keyvalue[0] == 'resistance') {
                enduranceTitle.text = "RESISTANCE";
                d.endurance = keyvalue[1];
                d.enduranceIsYours = true;
            } else if (keyvalue[0] == 'target') {
                enduranceTitle.text = "TARGET";
                d.endurance = keyvalue[1];
                youenduranceTitle.text = "TARGET";
                d.youendurance = keyvalue[1];
            } else if (keyvalue[0] == 'duel') {
                d.combatskill = d.youcombatskill - keyvalue[1];
                d.endurance = d.youendurance;
            }
        }
    }

    Binding {
        target: you
        property: inneworder ? "neworder_endurance" : "endurance"
        value: d.youendurance
        when: d.enduranceIsYours
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
                id: youenduranceLabel
                text: d.youendurance > 0 || youenduranceTitle.text != "ENDURANCE"  ? d.youendurance : "DEAD"
                color: d.youendurance > 0 ? "white" : theme.palette.normal.negative
                fontSize: "x-large"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                Button {
                    anchors.left: youenduranceLabel.right
                    anchors.leftMargin: units.gu(1)
                    anchors.verticalCenter: youenduranceLabel.verticalCenter
                    width: units.gu(3)
                    text: "+"
                    onClicked: d.youendurance += 1
                    color: "transparent"
                }
                Button {
                    anchors.right: youenduranceLabel.left
                    anchors.rightMargin: units.gu(1)
                    anchors.verticalCenter: youenduranceLabel.verticalCenter
                    width: units.gu(3)
                    text: "-"
                    onClicked: d.youendurance -= 1
                    color: "transparent"
                }
            }
            Label {
                id: youenduranceTitle
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
            Item { height: units.gu(3); width: units.gu(1); }
            Row {
                CheckBox {
                    id: youDoubleDamage
                }
                Label {
                    text: "weak (×2 damage)"
                    color: "white"
                    anchors.verticalCenter: parent.verticalCenter
                }
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Label {
                text: "(only enable if instructed)"
                color: "white"
                font.italic: true
                fontSize: "small"
                width: root.width / 2
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
                id: enduranceLabel
                text: d.endurance > 0 || enduranceTitle.text != "ENDURANCE" ? d.endurance : "DEAD"
                color: d.endurance > 0 ? "white" : theme.palette.normal.negative
                fontSize: "x-large"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                Button {
                    anchors.left: enduranceLabel.right
                    anchors.leftMargin: units.gu(1)
                    anchors.verticalCenter: enduranceLabel.verticalCenter
                    width: units.gu(3)
                    text: "+"
                    onClicked: d.endurance += 1
                    color: "transparent"
                }
                Button {
                    anchors.right: enduranceLabel.left
                    anchors.rightMargin: units.gu(1)
                    anchors.verticalCenter: enduranceLabel.verticalCenter
                    width: units.gu(3)
                    text: "-"
                    onClicked: d.endurance -= 1
                    color: "transparent"
                }
            }
            Label {
                id: enduranceTitle
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
            }
            Label {
                text: "COMBAT SKILL"
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Item { height: units.gu(3); width: units.gu(1); }
            Row {
                CheckBox {
                    id: doubleDamage
                }
                Label {
                    text: "weak (×2 damage)"
                    color: "white"
                    anchors.verticalCenter: parent.verticalCenter
                }
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Label {
                text: "(only enable if instructed)"
                color: "white"
                font.italic: true
                fontSize: "small"
                width: root.width / 2
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
        color: theme.palette.normal.negative
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
                d.youendurance = 0;
            } else {
                if (youDoubleDamage.checked)
                    damageToYou = damageToYou * 2;
                d.youendurance = Math.max(d.youendurance - damageToYou, 0);
            }

            d.done = true;
        }
    }
    Button {
        text: "Fight"
        color: theme.palette.normal.positive
        anchors.right: parent.right
        anchors.left: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.topMargin: units.gu(1)
        anchors.bottomMargin: units.gu(1)
        anchors.rightMargin: units.gu(1)
        anchors.leftMargin: units.gu(0.5)
        enabled: !d.done
        onClicked: {
            var rand = Util.getRandom();
            var delta = d.youcombatskill - d.combatskill;

            var damageToYou = Util.getDamageToYou(delta, rand);
            if (damageToYou < 0) {
                d.youendurance = 0;
            } else {
                if (youDoubleDamage.checked)
                    damageToYou = damageToYou * 2
                d.youendurance = Math.max(d.youendurance - damageToYou, 0);
            }

            var damageToEnemy = Util.getDamageToEnemy(delta, rand);
            if (damageToEnemy < 0) {
                d.endurance = 0;
            } else {
                if (doubleDamage.checked)
                    damageToEnemy = damageToEnemy * 2;
                d.endurance = Math.max(d.endurance - damageToEnemy, 0);
            }

            if (!d.done)
                d.round++;
        }
    }
}
