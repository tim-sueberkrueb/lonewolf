import QtQuick 2.4
import Ubuntu.Components 1.2
import Lonewolf 1.0

MainView {
    id: mainView
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

    GameState {
        category: "current"
        id: gameState
    }

    PageStack {
        id: pageStack
        Component.onCompleted: push(Qt.resolvedUrl("MenuPage.qml"))
    }
}

