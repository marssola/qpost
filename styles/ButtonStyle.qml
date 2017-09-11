import QtQuick 2.9
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

Item {
    property color colorButton: "#fff"
    property var iconButton: ""
    property var textButton: ""
    property int contentWidth: content.width + 25

    height: parent.height

    Item {
        id: content
        width: (icon.width + label.width)
        height: parent.height
        anchors.centerIn: parent

        Text {
            id: icon
            visible: iconButton.length > 0
            font.family: material_icon.name
            text: iconButton;
            color: colorButton
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: label
            text: qsTr(textButton)
            color: colorButton
            horizontalAlignment: Text.AlignHCenter
            font.capitalization: Font.AllUppercase
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: icon.right
            anchors.leftMargin: 5
        }
    }
}
