import QtQuick 2.4
import Qt.labs.settings 1.0
import Ubuntu.Components 1.3
import Lonewolf 1.0

MainView {
    id: mainView
    objectName: "mainView"
    applicationName: "lonewolf.mterry"
    automaticOrientation: true
    anchorToKeyboard: true
    focus: true

    width: units.gu(100)
    height: units.gu(60)

    Keys.onPressed: {
        if (event.matches(StandardKey.Quit)) {
            actionManager.quit();
        }
    }

    property bool nightModeEnabled: settings.nightMode

    Binding {
        target: Theme
        property: "name"
        value: nightModeEnabled ? "Ubuntu.Components.Themes.SuruDark" : "Ubuntu.Components.Themes.Ambiance"
    }

    property string nightModeIcon: nightModeEnabled ? "display-brightness-symbolic" : "night-mode"
    property string nightModeText: nightModeEnabled ? "Day Mode" : "Night Mode"

    function triggerNightMode(page) {
        settings.nightMode = !settings.nightMode;
    }

    Settings {
        id: settings
        property bool nightMode
    }

    GameState {
        category: "quicksave"
        id: quickSaveState
    }

    GameState {
        category: "current"
        id: gameState
    }

    property bool twoColumnView: width > units.gu(80) && !menuPage.visible

    function goToBookTab()
    {
        pageLayout.primaryPage.enabled = false;
        pageLayout.removePages(pageLayout.primaryPage);
        pageLayout.addPageToCurrentColumn(pageLayout.primaryPage, bookComponent);
    }

    function popBookTab()
    {
        pageLayout.primaryPage.enabled = true;
        pageLayout.removePages(pageLayout.primaryPage);
    }

    function loadQuickSave()
    {
        quickSaveState.copyTo(gameState);
        goToBookTab();
    }

    AdaptivePageLayout {
        id: pageLayout
        anchors.fill: parent
        primaryPage: menuPage

        layouts: PageColumnsLayout {
            when: twoColumnView
            PageColumn {
                fillWidth: true
            }
            PageColumn {
                minimumWidth: units.gu(40)
                maximumWidth: units.gu(40)
                preferredWidth: units.gu(40)
            }
        }

        MenuPage {
            id: menuPage
        }

        Component {
            id: bookComponent
            BookPage {
                you: gameState
            }
        }
    }

    readonly property int endurance: inneworder ? gameState.neworder_endurance : gameState.endurance
    readonly property int maxendurance: inneworder ? gameState.neworder_maxendurance : gameState.maxendurance
    readonly property int combatskill: inneworder ? gameState.neworder_combatskill : gameState.combatskill

    function adjustEndurance(amount) {
        if (inneworder) {
            gameState.neworder_endurance += amount;
        } else {
            gameState.endurance += amount;
        }
    }

    readonly property bool inkai: gameState.book == "" ||
                                  gameState.book == "01fftd" ||
                                  gameState.book == "02fotw" ||
                                  gameState.book == "03tcok" ||
                                  gameState.book == "04tcod" ||
                                  gameState.book == "05sots"
    readonly property bool inmagnakai: gameState.book == "06tkot" ||
                                       gameState.book == "07cd" ||
                                       gameState.book == "08tjoh" ||
                                       gameState.book == "09tcof" ||
                                       gameState.book == "10tdot" ||
                                       gameState.book == "11tpot" ||
                                       gameState.book == "12tmod"
    readonly property bool ingrandmaster: gameState.book == "13tplor" ||
                                          gameState.book == "14tcok" ||
                                          gameState.book == "15tdc" ||
                                          gameState.book == "16tlov" ||
                                          gameState.book == "17tdoi" ||
                                          gameState.book == "18dotd" ||
                                          gameState.book == "19wb" ||
                                          gameState.book == "20tcon"
    readonly property bool inneworder: gameState.book == "21votm" ||
                                       gameState.book == "22tbos" ||
                                       gameState.book == "23mh" ||
                                       gameState.book == "24rw" ||
                                       gameState.book == "25totw" ||
                                       gameState.book == "26tfobm" ||
                                       gameState.book == "27v" ||
                                       gameState.book == "28thos"
}
