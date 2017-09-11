import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0

Rectangle {
    id: root
    property string title_page: ""

    width: parent.width
    height: 50
    color: Material.accent

    Text {
        id: header_title
        width: parent.width
        height: parent.height

        text: qsTr(title_page)
        color: "#FFF"
        font.pixelSize: 25
        font.weight: Font.Light
        anchors.left: parent.left
        anchors.leftMargin: 10
        verticalAlignment: Qt.AlignVCenter
    }
}
