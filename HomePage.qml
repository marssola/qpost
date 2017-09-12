import QtQuick 2.9
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./styles"
import "./dialogs"

ScrollablePage {
    id: homePage

    property var getJson: []
    property var parameters: [
        /*{'parameter': 'parametro 1', 'value': 'valor'},
        {'parameter': 'parametro 2', 'value': 'valor'},
        {'parameter': 'parametro 3', 'value': 'valor'},
        {'parameter': 'parametro 4', 'value': 'valor'},
        {'parameter': 'parametro 5', 'value': 'valor'},
        {'parameter': 'parametro 6', 'value': 'valor'}*/
    ];

    contentItem: Item {
        anchors.fill: parent

        Column {
            anchors.fill: parent

            Item {
                width: parent.width
                height: 20
            }

            Rectangle {
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

            Item {
                id: item_result
                visible: (sendRequest.state == "ready")
                width: parent.width
                height: text_request.height + 30

                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.right: parent.right
                anchors.rightMargin: 5

                Rectangle {
                    anchors.fill: parent
                    border.color: "#ddd"
                    radius: 3

                    Item {
                        width: parent.width
                        height: text_request.height
                        anchors.margins: 20

                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        anchors.right: parent.right
                        anchors.rightMargin: 15
                        anchors.top: parent.top
                        anchors.topMargin: 15
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 15

                        Text {
                            id: text_request
                            text: String(JSON.stringify(sendRequest.json, null, 4))
                            wrapMode: Text.WordWrap
                        }
                    }

                    //http://www.dinnerforfriends.com.br/api/usuario/register
                }
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
                        sendRequest.requestParams = JSON.stringify(parameters)
                        sendRequest.load()
                    }
                }
            }

            Connections {
                target: sendRequest
                onStateChanged: {
                    if (state == "ready") {
                        webview_content.loadHtml("<pre>Teste: "+String(JSON.stringify(sendRequest.json))+"</pre>")
                        //webview_content.html = "<h1>Teste</h1>";
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        window.header.title_page = "QPost"
    }
}
