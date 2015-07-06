import QtQuick 2.4
import Ubuntu.Components 1.2
import Lonewolf 1.0

Page {
    id: root
    title: "Action Chart"

    property var you

    Flickable {
        id: flicker
        anchors.fill: parent
        anchors.margins: units.gu(1)
        contentHeight: units.gu(170) //childrenRect.height
        contentWidth: root.width - units.gu(2)

        Column {
            spacing: units.gu(1)

            Grid {
                columns: 3
                verticalItemAlignment: Grid.AlignVCenter
                columnSpacing: units.gu(2)
                rowSpacing: units.gu(1)

                Label {
                    text: "Combat Skill"
                }
                ChartItem {
                    id: combatSkillBox
                    inputMethodHints: Qt.ImhDigitsOnly
                    hasClearButton: false
                    text: you.combatskill
                    you: root.you
                    prop: "combatskill"
                    width: units.gu(6)
                }
                Item {height: 1; width: 1}

                Label {
                    text: "Endurance"
                }
                ChartItem {
                    inputMethodHints: Qt.ImhDigitsOnly
                    hasClearButton: false
                    text: you.endurance
                    you: root.you
                    prop: "endurance"
                    width: combatSkillBox.width
                }
                Item {height: 1; width: 1}

                Label {
                    text: "Max Endurance"
                }
                ChartItem {
                    inputMethodHints: Qt.ImhDigitsOnly
                    hasClearButton: false
                    text: you.maxendurance
                    you: root.you
                    prop: "maxendurance"
                    width: combatSkillBox.width
                }
                Item {height: 1; width: 1}

                Label {
                    text: "Belt Pouch"
                }
                ChartItem {
                    inputMethodHints: Qt.ImhDigitsOnly
                    hasClearButton: false
                    text: you.gold
                    you: root.you
                    prop: "gold"
                    width: units.gu(6)
                }
                Label {
                    text: "Max 50"
                    font.italic: true
                    wrapMode: Text.Wrap
                    width: units.gu(8)
                }

                Label {
                    text: "Meals"
                }
                ChartItem {
                    inputMethodHints: Qt.ImhDigitsOnly
                    hasClearButton: false
                    text: you.meals
                    you: root.you
                    prop: "meals"
                    width: units.gu(6)
                }
                Label {
                    text: "-3 endurance if no meals when instructed to eat"
                    font.italic: true
                    wrapMode: Text.Wrap
                    width: units.gu(15)
                }
            }

            Item {
                width: 1
                height: units.gu(1)
            }
            Label {
                text: "Weapons"
            }
            Grid {
                id: weapons
                columns: 2
                rows: 1
                flow: Grid.TopToBottom
                spacing: units.gu(1)
                property real itemWidth: (flicker.width - spacing) / 2

                ChartItem {
                    hasClearButton: false
                    text: you.weapon1
                    you: root.you
                    prop: "weapon1"
                    width: weapons.itemWidth
                }
                ChartItem {
                    hasClearButton: false
                    text: you.weapon2
                    you: root.you
                    prop: "weapon2"
                    width: weapons.itemWidth
                }
            }
            Label {
                text: "If holding a weapon with the appropriate Weaponskill: +2CS"
                font.italic: true
                wrapMode: Text.Wrap
                width: flicker.width
            }
            Label {
                text: "If you have no weapon during combat: -4CS"
                font.italic: true
                wrapMode: Text.Wrap
                width: flicker.width
            }

            Item {
                width: 1
                height: units.gu(1)
            }
            Label {
                text: "Backpack Items"
            }
            Grid {
                id: backpack
                columns: 2
                rows: 4
                flow: Grid.TopToBottom
                spacing: units.gu(1)
                property real itemWidth: (flicker.width - spacing) / 2

                ChartItem {
                    text: you.backpack1
                    you: root.you
                    prop: "backpack1"
                    width: backpack.itemWidth
                }
                ChartItem {
                    text: you.backpack2
                    you: root.you
                    prop: "backpack2"
                    width: backpack.itemWidth
                }
                ChartItem {
                    text: you.backpack3
                    you: root.you
                    prop: "backpack3"
                    width: backpack.itemWidth
                }
                ChartItem {
                    text: you.backpack4
                    you: root.you
                    prop: "backpack4"
                    width: backpack.itemWidth
                }
                ChartItem {
                    text: you.backpack5
                    you: root.you
                    prop: "backpack5"
                    width: backpack.itemWidth
                }
                ChartItem {
                    text: you.backpack6
                    you: root.you
                    prop: "backpack6"
                    width: backpack.itemWidth
                }
                ChartItem {
                    text: you.backpack7
                    you: root.you
                    prop: "backpack7"
                    width: backpack.itemWidth
                }
                ChartItem {
                    text: you.backpack8
                    you: root.you
                    prop: "backpack8"
                    width: backpack.itemWidth
                }
            }
            Label {
                text: "Can be discarded when not in combat"
                font.italic: true
                wrapMode: Text.Wrap
                width: flicker.width
            }

            Item {
                width: 1
                height: units.gu(1)
            }
            Label {
                text: "Special Items"
            }
            Grid {
                id: specials
                columns: 1
                rows: 12
                flow: Grid.TopToBottom
                spacing: units.gu(1)
                property real itemWidth: flicker.width

                ChartItem {
                    text: you.special1
                    you: root.you
                    prop: "special1"
                    width: specials.itemWidth
                }
                ChartItem {
                    text: you.special2
                    you: root.you
                    prop: "special2"
                    width: specials.itemWidth
                }
                ChartItem {
                    text: you.special3
                    you: root.you
                    prop: "special3"
                    width: specials.itemWidth
                }
                ChartItem {
                    text: you.special4
                    you: root.you
                    prop: "special4"
                    width: specials.itemWidth
                }
                ChartItem {
                    text: you.special5
                    you: root.you
                    prop: "special5"
                    width: specials.itemWidth
                }
                ChartItem {
                    text: you.special6
                    you: root.you
                    prop: "special6"
                    width: specials.itemWidth
                }
                ChartItem {
                    text: you.special7
                    you: root.you
                    prop: "special7"
                    width: specials.itemWidth
                }
                ChartItem {
                    text: you.special8
                    you: root.you
                    prop: "special8"
                    width: specials.itemWidth
                }
                ChartItem {
                    text: you.special9
                    you: root.you
                    prop: "special9"
                    width: specials.itemWidth
                }
                ChartItem {
                    text: you.special10
                    you: root.you
                    prop: "special10"
                    width: specials.itemWidth
                }
                ChartItem {
                    text: you.special11
                    you: root.you
                    prop: "special11"
                    width: specials.itemWidth
                }
                ChartItem {
                    text: you.special12
                    you: root.you
                    prop: "special12"
                    width: specials.itemWidth
                }
            }

            Item {
                width: 1
                height: units.gu(1)
            }
            Label {
                text: "Kai Disciplines"
            }
            Grid {
                id: disciplines
                columns: 2
                rows: 5
                flow: Grid.TopToBottom
                spacing: units.gu(1)
                property real itemWidth: (flicker.width - spacing) / 2

                ChartItem {
                    hasClearButton: false
                    text: you.kaiskill1
                    you: root.you
                    prop: "kaiskill1"
                    width: disciplines.itemWidth
                }
                ChartItem {
                    hasClearButton: false
                    text: you.kaiskill2
                    you: root.you
                    prop: "kaiskill2"
                    width: disciplines.itemWidth
                }
                ChartItem {
                    hasClearButton: false
                    text: you.kaiskill3
                    you: root.you
                    prop: "kaiskill3"
                    width: disciplines.itemWidth
                }
                ChartItem {
                    hasClearButton: false
                    text: you.kaiskill4
                    you: root.you
                    prop: "kaiskill4"
                    width: disciplines.itemWidth
                }
                ChartItem {
                    hasClearButton: false
                    text: you.kaiskill5
                    you: root.you
                    prop: "kaiskill5"
                    width: disciplines.itemWidth
                }
                ChartItem {
                    hasClearButton: false
                    text: you.kaiskill6
                    you: root.you
                    prop: "kaiskill6"
                    width: disciplines.itemWidth
                }
                ChartItem {
                    hasClearButton: false
                    text: you.kaiskill7
                    you: root.you
                    prop: "kaiskill7"
                    width: disciplines.itemWidth
                }
                ChartItem {
                    hasClearButton: false
                    text: you.kaiskill8
                    you: root.you
                    prop: "kaiskill8"
                    width: disciplines.itemWidth
                }
                ChartItem {
                    hasClearButton: false
                    text: you.kaiskill9
                    you: root.you
                    prop: "kaiskill9"
                    width: disciplines.itemWidth
                }
                ChartItem {
                    hasClearButton: false
                    text: you.kaiskill10
                    you: root.you
                    prop: "kaiskill10"
                    width: disciplines.itemWidth
                }
            }
        }
    }
}

