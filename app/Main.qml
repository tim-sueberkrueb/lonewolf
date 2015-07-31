import QtQuick 2.4
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
        pageStack.push(actionPage);
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

        ChartPage {
            id: actionPage
            title: "Action Chart"
            visible: false
            you: gameState
        }
    }
}

