import QtQuick 2.9
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.0

import StatusBar 0.1

import "./styles"

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("QPost")

    Material.accent: Material.color(Material.Green)
    Material.background: "#eee"

    FontLoader {
        id: material_icon
        source: "qrc:/fonts/MaterialIcons.ttf"
    }

    property bool busy: false

    header: HeaderPage {}

    StackView {
        id: stackview
        anchors.fill: parent
        initialItem: HomePage {}
    }

    Rectangle {
        visible: sendRequest.state == "loading"
        anchors.fill: parent
        color: Qt.rgba(0, 0, 0, 0.8)

        BusyIndicator {
            id: busy_indicator
            anchors.centerIn: parent
        }
        Text {
            width: parent.width
            anchors.top: busy_indicator.bottom
            horizontalAlignment: Text.AlignHCenter

            color: "#fff"
            text: qsTr("aguarde...")
        }
        z: 2
    }

    ToolTip {
        id: message
        timeout: 1000
        topMargin: parent.height
        z: 3
    }

    QJSON {
        id: sendRequest
        onStateChanged: {
            if (state != "null") {
                message.text = "State: " + state
                message.visible = true;
            }
        }
    }

    StatusBar {
        id: statusBar
        color: Material.color(Material.Green)
    }

    Component.onCompleted: {
        statusBar.color = Material.color(Material.Green);
    }
}
