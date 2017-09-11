import QtQuick 2.9
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.0

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

    header: HeaderPage {}
    StackView {
        id: stackview
        anchors.fill: parent
        initialItem: HomePage {}
    }
}
