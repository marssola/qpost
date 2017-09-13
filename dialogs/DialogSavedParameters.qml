import QtQuick 2.9
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.LocalStorage 2.0

import "../js/Database.js" as Db
import "../styles"

Dialog {
    id: dialog_saved_parameters

    property var list: []

    title: qsTr("Parâmetros salvos");
    modal: true

    x: Math.round((window.width - width) /2)
    y: 50
    width: (window.width > 1000)? 1000 : parent.width
    height: window.height - window.header.height
    padding: 0

    standardButtons: Dialog.Close

    contentItem: Item {
        width: parent.width
        height: parent.height

        Rectangle {
            anchors.fill: parent
            border.color: "#ccc"

            ListView {
                width: parent.width
                height: parent.height

                ScrollIndicator.vertical: ScrollIndicator {}
                clip: true

                model: list
                delegate: ItemDelegate {
                    width: parent.width
                    height: column_result.implicitHeight

                    Rectangle {
                        id: button_remove_parameter
                        width: 40
                        height: 40
                        color: "transparent"

                        anchors.right: parent.right
                        anchors.top: parent.top

                        Text {
                            text: "\uE15C"
                            font.family: material_icon.name
                            font.pixelSize: 30
                            anchors.centerIn: parent
                            color: Material.color(Material.Red)
                        }

                        MouseArea {
                            id: mousearea_remove_parameter
                            anchors.fill: parent

                            onClicked: {
                                Db.dbDeletePost(modelData.id);
                                if (String(modelData.id) === String(object.id)) {
                                    object.id = "";
                                    object.url = "";
                                    object.parameters.slice(0, object.parameters.length);
                                    object.parameters = object.parameters;
                                }

                                getPostsList();
                            }
                        }
                    }

                    Column {
                        id: column_result
                        width: parent.width
                        height: label_url.height + text_url.height + label_parameters.height + text_parameters.height

                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10

                        Text {
                            id: label_url
                            text: qsTr("URL")
                            font.bold: true
                        }
                        Text {
                            id: text_url
                            width: parent.width
                            text: modelData.url
                            wrapMode: Text.WrapAnywhere
                        }

                        Item {
                            width: parent.width
                            height: 5
                        }
                        Rectangle {
                            width: parent.width
                            height: 1
                            color: "#eee"
                        }
                        Item {
                            width: parent.width
                            height: 5
                        }

                        Text {
                            id: label_parameters
                            text: qsTr("Parâmetros")
                            font.bold: true
                        }
                        Text {
                            id: text_parameters
                            width: parent.width
                            height: implicitHeight + 10
                            text: String(JSON.stringify(JSON.parse(modelData.parameters), null, 4))
                            wrapMode: Text.WrapAnywhere
                        }
                        Item {
                            width: parent.width
                            height: 10
                        }
                    }
                    Rectangle {
                        width: parent.width
                        height: 1
                        anchors.top: parent.bottom
                        color: "#ccc"
                    }

                    onClicked: {
                        object.id = modelData.id;
                        object.url = modelData.url;
                        object.parameters = JSON.parse(modelData.parameters);
                        dialog_saved_parameters.close();
                    }
                }
            }
        }
    }
    function getPostsList()
    {
        list.splice(0, list.length);
        list = Db.dbSelectPosts();
    }
}
