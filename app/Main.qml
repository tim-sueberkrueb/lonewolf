import QtQuick 2.4
import QtQuick.XmlListModel 2.0
import Ubuntu.Components 1.2
import Ubuntu.Components.Popups 1.0
import Ubuntu.Web 0.2
import Lonewolf 1.0

MainView {
    objectName: "mainView"
    applicationName: "lonewolf.mterry"
    automaticOrientation: true
    focus: true

    width: units.gu(40)
    height: units.gu(60)

    Keys.onPressed: {
        if (event.matches(StandardKey.Quit)) {
            actionManager.quit();
        }
    }

    Book {
        id: book
        filename: Qt.resolvedUrl("01fftd.xml")
        onFilenameChanged: book.pageId = "sect17" //book.firstPageId
        onPageIdChanged: {
            var content = book.pageContent;
            console.log(content);
            pageView.loadHtml(content, Qt.resolvedUrl("."));
        }
    }

    Item {
        id: you
        property var endurance: 24
        property var combatskill: 15
    }

    Component {
        id: alertDialog
        Rectangle {
            id: dialog
            anchors.fill: parent
            color: "black"
            opacity: 0.7
            Label {
                text: Math.random(1) * 10
                color: "white"
                fontSize: "x-large"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {}
            }
        }
    }

    function getRandom() {
        return Math.floor(Math.random(0.99999999999999) * 10)
    }

    Page {
        title: book.pageTitle

        WebView {
            id: pageView
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: navigation.top
            alertDialog: Item {
                anchors.fill: parent

                Component.onCompleted: {
                    console.log(model.message);
                    if (model.message == "random") {
                        random.visible = true;
                    } else if (model.message == "combat enemy=\"Kraan\" combatskill=16 endurance=24") {
                        console.log("Combat")
                        combat.visible = true;
                    } else {
                        book.pageId = model.message;
                        model.accept();
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    // eat events that fall through
                }

                Rectangle {
                    id: combat
                    anchors.fill: parent
                    color: "black"
                    opacity: 0.95
                    visible: false
                    property bool hasFought: false
                    property string enemy: "Kraan"
                    property int combatskill: 16
                    property int endurance: 24
                    property int youcombatskill: 0
                    Component.onCompleted: youcombatskill = you.combatskill // Make copy
                    Item {
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: fleeButton.top
                        Column {
                            anchors.verticalCenter: parent.verticalCenter
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
                                text: combat.youcombatskill
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
                                    onClicked: combat.youcombatskill += 1
                                    color: "transparent"
                                }
                                Button {
                                    anchors.right: youcombatskillLabel.left
                                    anchors.rightMargin: units.gu(1)
                                    anchors.verticalCenter: youcombatskillLabel.verticalCenter
                                    width: units.gu(3)
                                    text: "-"
                                    onClicked: combat.youcombatskill -= 1
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
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.horizontalCenter
                            anchors.right: parent.right
                            Label {
                                text: combat.enemy
                                color: "white"
                                horizontalAlignment: Text.AlignHCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Item { height: units.gu(3); width: units.gu(1); }
                            Label {
                                text: combat.endurance > 0 ? combat.endurance : "DEAD"
                                color: combat.endurance > 0 ? "white" : UbuntuColors.red
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
                                text: combat.combatskill
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
                                    onClicked: combat.combatskill += 1
                                    color: "transparent"
                                }
                                Button {
                                    anchors.right: combatskillLabel.left
                                    anchors.rightMargin: units.gu(1)
                                    anchors.verticalCenter: combatskillLabel.verticalCenter
                                    width: units.gu(3)
                                    text: "-"
                                    onClicked: combat.combatskill -= 1
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
                        id: fleeButton
                        text: combat.hasFought ? "Flee" : "Cancel"
                        color: combat.hasFought ? UbuntuColors.red : UbuntuColors.lightGrey
                        Behavior on color { ColorAnimation {} }
                        anchors.left: parent.left
                        anchors.right: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.margins: units.gu(1)
                    }
                    Button {
                        text: "Fight"
                        color: UbuntuColors.green
                        anchors.right: parent.right
                        anchors.left: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.margins: units.gu(1)
                        onClicked: {
                            combat.hasFought = true;

                            var rand = getRandom();
                            var delta = combat.youcombatskill - combat.combatskill;

                            var damageToYou = book.getDamageToYou(delta, rand);
                            if (damageToYou < 0) {
                                you.endurance = 0;
                            } else {
                                you.endurance = Math.max(you.endurance - damageToYou, 0);
                            }

                            var damageToEnemy = book.getDamageToEnemy(delta, rand);
                            if (damageToEnemy < 0) {
                                combat.endurance = 0;
                            } else {
                                combat.endurance = Math.max(combat.endurance - damageToEnemy, 0);
                            }

                            console.log(rand, delta, damageToEnemy, damageToYou)
                        }
                    }
                }

                Rectangle {
                    id: random
                    anchors.fill: parent
                    color: "black"
                    opacity: 0.95
                    visible: false
                    Column {
                        spacing: units.gu(1)
                        anchors.centerIn: parent
                        Label {
                            text: "Your random number is:"
                            color: "white"
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            wrapMode: Text.Wrap
                        }
                        Label {
                            text: getRandom()
                            fontSize: "x-large"
                            color: "white"
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: model.accept()
                    }
                }
            }
        }

        Rectangle {
            id: navigation
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: units.gu(4)

            Button {
                id: previous
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                height: parent.height
                width: height
                iconName: "go-previous"
                visible: book.prevPageId != ""
                onClicked: book.pageId = book.prevPageId
            }
            Button {
                id: next
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: parent.height
                width: height
                iconName: "go-next"
                visible: book.nextPageId != ""
                onClicked: book.pageId = book.nextPageId
            }
        }
    }
}

