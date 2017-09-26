import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

import "../styles"

Dialog {
    id: dialog_parametersJSON

    property bool fullscreen: false

    title: qsTr("Parâmetros")
    modal: true

    x: Math.round((window.width - width) /2)
    width: fullscreen? ((window.width > 1000)? 1000 : parent.width) : ((window.width > 400)? 400 : parent.width)
    height: fullscreen? (window.height - window.header.height) : 400

    header: Rectangle {
        width: parent.width
        height: 30
        color: "transparent"

        ToolButton {
            flat: true
            text: fullscreen? "\uE5D1" : "\uE5D0"
            font.family: material_icon.name
            font.pixelSize: 22
            anchors.right: parent.right

            onClicked: fullscreen = !fullscreen
        }
    }

    standardButtons: Dialog.Ok | Dialog.Cancel

    contentItem: Item {
        width: parent.width
        height: parent.height

        ColumnLayout {
            anchors.fill: parent

            Text {
                text: qsTr("Formato JSON")
                font.bold: true
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true

                ScrollView {
                    anchors.fill: parent
                    clip: true

                    TextArea {
                        id: textarea_parameters
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        text: object.parameters.length > 0? JSON.stringify(object.parameters, null, 2) : ""

                        selectByMouse: true
                        selectByKeyboard: true
                        wrapMode: TextField.WrapAnywhere
                        placeholderText: '[\n {"parameter":"param1","value":"value1"},\n {"parameter":"param2","value":"value2"},\n {"parameter":"param3","value":"value3"}\n]'
                    }
                }
            }
        }
    }
    onAccepted: {
        if (textarea_parameters.text.length == 0)
            return;
        try {
            var parse = JSON.parse(textarea_parameters.text);
            object.parameters = parse;
        } catch (e) {
            message.text = qsTr("Formato JSON inválido");
            message.visible = true;
        }
    }
}
