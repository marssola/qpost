import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.1
import QtQuick.LocalStorage 2.0

import "./js/Database.js" as Db
import "./dialogs"

Rectangle {
    id: root
    property string title_page: ""

    width: parent.width
    height: 50
    color: Material.accent

    RowLayout {
        width: parent.width
        height: parent.height

        Text {
            id: header_title
            width: parent.width
            height: parent.height
            Layout.fillWidth: true

            text: qsTr(title_page)
            color: "#FFF"
            font.pixelSize: 25
            font.weight: Font.Light
            anchors.left: parent.left
            anchors.leftMargin: 10
            verticalAlignment: Qt.AlignVCenter
        }

        RowLayout {
            ToolButton {
                Text {
                    width: parent.width
                    height: parent.height
                    text: "\uE161"
                    font.family: material_icon.name
                    font.pixelSize: 24
                    color: "#fff"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                onClicked: {
                    dialog_saved_parameters.getPostsList();
                    dialog_saved_parameters.open();
                }

                Shortcut {
                    sequence: "Ctrl+O"
                    onActivated: {
                        dialog_saved_parameters.getPostsList();
                        dialog_saved_parameters.open();
                    }
                }
            }

            ToolButton {
                Text {
                    width: parent.width
                    height: parent.height
                    text: "\uE887"
                    font.family: material_icon.name
                    font.pixelSize: 24
                    color: "#fff"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                onClicked: {
                    dialog_help.open();
                }

                Shortcut {
                    sequence: "F1"
                    onActivated: {
                        dialog_help.open();
                    }
                }
            }
        }
    }

    DialogSavedParameters {
        id: dialog_saved_parameters
    }
}
