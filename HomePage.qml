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
                border.color: "#eee"

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
                            text: object.url

                            selectByMouse: true
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
                            text: object.parameters.length
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

                            Shortcut {
                                sequence: "Ctrl+E"
                                onActivated: dialog_parameters.open();
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
                                textButton: (object.id !== "")? "Atualizar" : "Salvar"
                                colorButton: "#fff"
                            }

                            Shortcut {
                                sequence: "Ctrl+S"
                                onActivated: savePost();
                            }
                            onClicked: savePost();
                        }

                        Button {
                            Layout.minimumWidth: bs_clean.contentWidth
                            Material.background: Material.Red

                            contentItem: ButtonStyle {
                                id: bs_clean
                                iconButton: "\uE5C9"
                                textButton: "Limpar"
                                colorButton: "#fff"
                            }

                            onClicked: clearPost();

                            Shortcut {
                                sequence: "Ctrl+Backspace"
                                onActivated: clearPost();
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

                            onClicked: sendPost();

                            Shortcut {
                                sequence: "Ctrl+Shift+S"
                                onActivated: sendPost();
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
                border.color: "#eee"

                Column {
                    anchors.fill: parent
                    anchors.margins: 20

                    TextArea {
                        id: text_request
                        visible: sendRequest.json !== undefined
                        width: parent.width
                        wrapMode: TextArea.WrapAnywhere
                        text: String(JSON.stringify(sendRequest.json, null, 4))
                        readOnly: true
                        selectByMouse: true
                        selectByKeyboard: true
                    }

                    TextArea {
                        id: text_error
                        visible: sendRequest.errorString !== ""
                        width: parent.width
                        wrapMode: TextArea.WrapAnywhere
                        text: sendRequest.errorString
                        readOnly: true
                        selectByMouse: true
                        selectByKeyboard: true
                    }
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

            DialogAddParameters {
                id: dialog_edit_parameters
            }

            DialogAddJSON {
                id: dialog_add_parametersJSON
            }
        }
    }

    function sendPost()
    {
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

    function prepareRequestParams()
    {
        var data = [];
        for (var it in object.parameters) {
            data.push(object.parameters[it].parameter + "=" + object.parameters[it].value);
        }
        return data.join("&");
    }

    function savePost()
    {
        if (textfield_url.text == "") {
            tooltip_validate_url.text = qsTr("É necessário definir uma URL para salvar");
            tooltip_validate_url.visible = true
            textfield_url.focus = true
            return;
        }
        if (object.id !== "") {
            var result = Db.dbUpdatePost(object.id, textfield_url.text, object.parameters);
            if (result.id) {
                message.text = qsTr("Atualizado");
                message.visible = true;
            } else if (result.error) {
                message.text = qsTr("Erro: %1").arg(result.error);
                message.visible = true;
            }
        } else {
            var result = Db.dbInsertPost(textfield_url.text, object.parameters);
            if (result.id) {
                object.id = result.id;
                message.text = qsTr("Salvo");
                message.visible = true;
            } else if (result.error) {
                message.text = qsTr("Erro: %1").arg(result.error);
                message.visible = true;
            }
        }
    }

    function clearPost()
    {
        object.id = "";
        object.url = "";
        object.url = object.url;
        object.parameters.splice(0, object.parameters.length)
        object.parameters = object.parameters
    }

    Component.onCompleted: {
        window.header.title_page = "QPost"
    }
}
