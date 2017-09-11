import QtQuick 2.9
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

Item {
    property color colorButton: "#fff"
    property var iconButton: ""
    property var textButton: ""

    width: parent.width
    height: parent.height

    RowLayout {
        anchors.fill: parent
        Text {
            font.family: material_icon.name
            text: iconButton;
            color: colorButton
            visible: iconButton.length > 0
        }

        Text {
            text: qsTr(textButton)
            color: colorButton
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            font.capitalization: Font.AllUppercase
        }
    }
}
