import QtQuick 2.9
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.0

import "./js/Database.js" as Db
import "./styles"
import "./dialogs"

ScrollablePage {
    id: homePage

    property var getJson: []
    property var parameters: [
        {'parameter': 'accessToken', 'value': 'EAAHgV7KmBZA0BAGF20fWdi8bSZBdPFY2j0w0zUd3poZCXwSNMZC3AU2NVIpd03UEuJq49TTZBHmmDLoAjQIxG5OUx8WYdGZBZCkqK88CZBvEv3V0hSPnWu06DzNWlXjYQ96lgA4uHM6x5NapJ9r3xzCm34HsAe7Jecu38BcquEqZCp4hTd1DZAaqAk3agiMhaqQ3wDlzaUX7anWmrLWb296jyG0uIEVpjfd7cZD'}
    ];

    Item {
        width: parent.width
        height: homePage.height

        Column {
            anchors.fill: parent

            Item {
                width: parent.width
                height: 20
            }

            Rectangle {
                id: rectangle_form
                width: parent.width
                height: rowlayout_url.height + rowlayout_parameters.height + rowlayout_buttons.height + 20
                border.color: "#ddd"

                Column {
                    anchors.fill: parent
                    anchors.margins: 10

                    RowLayout {
                        id: rowlayout_url
                        width: parent.width
                        spacing: 10

                        Text {
                            text: qsTr("URL:")
                            font.bold: true
                        }

                        TextField {
                            id: textfield_url
                            placeholderText: qsTr("http://localhost:8213")
                            Layout.fillWidth: true
                            text: "http://www.dinnerforfriends.com.br/api/usuario/fblogin"
                        }

                        ComboBox {
                            id: method
                            Layout.minimumWidth: 80
                            model: ['POST', 'GET']

                            Material.background: "#fff"
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: 1
                        color: "#eee"
                    }

                    RowLayout {
                        id: rowlayout_parameters
                        width: parent.width
                        anchors.margins: 20
                        spacing: 10

                        Text {
                            text: qsTr("Parâmetros:")
                            font.bold: true
                        }
                        Text {
                            id: count_parameters
                            text: parameters.length
                            Layout.fillWidth: true
                            wrapMode: Text.WordWrap
                        }

                        Button {
                            Layout.minimumWidth: bs_edit.contentWidth

                            contentItem: ButtonStyle {
                                id: bs_edit
                                iconButton: "\uE254"
                                textButton: "Editar"
                                colorButton: "#333"
                            }

                            onClicked: {
                                dialog_parameters.open();
                            }
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: 1
                        color: "#eee"
                    }

                    RowLayout {
                        id: rowlayout_buttons
                        width: parent.width
                        anchors.margins: 20
                        spacing: 10

                        Button {
                            Layout.minimumWidth: bs_save.contentWidth
                            Material.background: Material.Orange

                            contentItem: ButtonStyle {
                                id: bs_save
                                iconButton: "\uE161"
                                textButton: "Salvar"
                                colorButton: "#fff"
                            }

                            onClicked: {
                                Db.dbInsertPost(textfield_url.text, parameters);
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        Button {
                            id: button_sendrequest
                            Layout.minimumWidth: bs_send.contentWidth
                            Material.background: Material.Green

                            contentItem: ButtonStyle {
                                id: bs_send
                                iconButton: "\uE163"
                                textButton: "Enviar"
                                colorButton: "#fff"
                            }
                        }
                    }
                }
            }

            Item {
                width: parent.width
                height: 20
            }

            Rectangle {
                id: rectangle_text
                visible: (sendRequest.state !== "null" && sendRequest.state !== "loading")
                width: parent.width
                height: text_request.height + text_error.height + 30
                border.color: "#ddd"

                Column {
                    anchors.fill: parent
                    anchors.margins: 20

                    Text {
                        id: text_request
                        visible: sendRequest.json !== undefined
                        width: parent.width
                        wrapMode: Text.WrapAnywhere
                        text: String(JSON.stringify(sendRequest.json, null, 4))
                    }

                    Text {
                        id: text_error
                        visible: sendRequest.errorString !== ""
                        width: parent.width
                        wrapMode: Text.WrapAnywhere
                        text: sendRequest.errorString
                    }
                }
                //http://localhost.dinner4friends.com.br/api/usuario/
            }

            ToolTip {
                id: tooltip_validate_url
                timeout: 5000
                topMargin: parent.height /2
            }

            DialogParameters {
                id: dialog_parameters
            }

            DialogAddParameters {
                id: dialog_add_parameters
            }

            DialogAddParameters {
                id: dialog_edit_parameters
            }

            Connections {
                target: button_sendrequest

                onClicked: {
                    if (textfield_url.text == "") {
                        tooltip_validate_url.text = qsTr("É necessário definir uma URL para enviar a requisição");
                        tooltip_validate_url.visible = true;
                        textfield_url.focus = true;
                    } else {
                        busy = true;
                        sendRequest.source = textfield_url.text
                        sendRequest.requestMethod = method.currentText
                        sendRequest.requestParams = prepareRequestParams();
                        sendRequest.load()
                    }
                }
            }
        }
    }

    function prepareRequestParams()
    {
        var data = [];
        for (var it in parameters) {
            data.push(parameters[it].parameter + "=" + parameters[it].value);
        }
        return data.join("&");
    }

    Component.onCompleted: {
        window.header.title_page = "QPost"
    }
}
