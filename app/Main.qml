import QtQuick 2.4
import Qt.labs.settings 1.0
import Ubuntu.Components 1.2
import Lonewolf 1.0

MainView {
    id: mainView
    objectName: "mainView"
    applicationName: "lonewolf.mterry"
    automaticOrientation: true
    anchorToKeyboard: true
    focus: true

    width: units.gu(40)
    height: units.gu(60)

    Keys.onPressed: {
        if (event.matches(StandardKey.Quit)) {
            actionManager.quit();
        }
    }

    Binding {
        target: Theme
        property: "name"
        value: settings.nightMode ? "Ubuntu.Components.Themes.SuruDark" : "Ubuntu.Components.Themes.Ambiance"
    }

    Action {
        id: nightMode
        iconName: "display-brightness-symbolic"
        text: settings.nightMode ? "Day Mode" : "Night Mode"
        onTriggered: settings.nightMode = !settings.nightMode
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

    function goToBookTab(reset)
    {
        if (reset) {
            bookLoader.active = false;
            bookLoader.active = true;
        }
        tabs.selectedTabIndex = 1;
    }

    function goToChartTab()
    {
        pageStack.push(chartLoader.item);
    }

    function loadQuickSave()
    {
        quickSaveState.copyTo(gameState);
        chartLoader.active = false;
        chartLoader.active = true;
        goToBookTab(true);
    }

    PageStack {
        id: pageStack

        Component.onCompleted: push(tabs)

        Tabs {
            id: tabs

            StateSaver.properties: "selectedTabIndex"

            Tab {
                title: "Main Menu"
                page: Loader {
                    sourceComponent: MenuPage {
                    }
                }
            }
            Tab {
                title: "Book"
                page: Loader {
                    id: bookLoader
                    sourceComponent: BookPage {
                        you: gameState
                    }
                }
            }
        }

        Loader {
            id: chartLoader
            sourceComponent: ChartPage {
                title: "Action Chart"
                visible: false
                you: gameState
            }
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
