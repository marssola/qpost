import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.0

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("QPost")

    Material.accent: Material.color(Material.Indigo)

    header: HeaderPage {}
    StackView {
        id: stackview
        anchors.fill: parent
        initialItem: HomePage {}
    }
}
