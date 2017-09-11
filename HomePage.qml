import QtQuick 2.9
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./styles"

ScrollablePage {
    id: homePage

    property var parameters: [
        /*{'parameter': 'parametro 1', 'value': 'valor'},
        {'parameter': 'parametro 2', 'value': 'valor'},
        {'parameter': 'parametro 3', 'value': 'valor'},
        {'parameter': 'parametro 4', 'value': 'valor'},
        {'parameter': 'parametro 5', 'value': 'valor'},
        {'parameter': 'parametro 6', 'value': 'valor'}*/
    ];

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
                        placeholderText: qsTr("URL")
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
                        Material.background: Material.Amber

                        contentItem: ButtonStyle {
                            id: bs_edit
                            iconButton: "\uE254"
                            textButton: "Editar"
                            colorButton: "#fff"
                        }

                        onClicked: {
                            dialog_parameters.open();
                        }
                    }
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

        Dialog {
            id: dialog_parameters
            title: qsTr("Parâmetros")
            modal: true

            //x: Math.round((window.width - width) /2)
            width: (window.width > 1000)? 1000 : parent.width
            height: window.height - window.header.height

            standardButtons: Dialog.Ok

            contentItem: Item {
                width: parent.width
                height: parent.height

                Column {
                    anchors.fill: parent

                    Item {
                        width: parent.width
                        height: 50

                        Button {
                            width: bs_addparameter.contentWidth
                            Material.background: Material.Green
                            anchors.right: parent.right

                            contentItem: ButtonStyle {
                                id: bs_addparameter
                                iconButton: "\uE145"
                                colorButton: "#fff"
                                textButton: "Adicionar"
                            }

                            onClicked: dialog_add_parameters.open()
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: 30
                        color: Material.color(Material.Green)

                        Item {
                            anchors.fill: parent

                            Text {
                                id: table_column1
                                width: (parent.width /2) -(table_column3.width /2) -(table_column4.width)
                                height: parent.height

                                text: qsTr("Parâmetro")
                                color: "#fff"
                                font.bold: true
                                font.pixelSize: 14

                                verticalAlignment: Text.AlignVCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 5
                            }
                            Text {
                                id: table_column2
                                width: (parent.width /2) -(table_column4.width)
                                height: parent.height

                                text: qsTr("Valor")
                                color: "#fff"
                                font.bold: true
                                font.pixelSize: 14

                                verticalAlignment: Text.AlignVCenter
                                anchors.left: table_column1.right
                            }
                            Item {
                                id: table_column3
                                width: 25
                                height: parent.height
                                anchors.left: table_column2.right
                            }
                            Item {
                                id: table_column4
                                width: 25
                                height: parent.height
                                anchors.left: table_column3.right
                            }
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: parameters.length > 0 ? listview.height + 60 : 30
                        border.color: "#ddd"

                        Text {
                            visible: parameters.length == 0
                            text: qsTr("Nenhum parâmetro adicionado...")
                            anchors.centerIn: parent
                            color: "#999"
                        }

                        ListView {
                            id: listview
                            visible: parameters.length > 0
                            width: parent.width
                            height: (parameters.length > 3)? (30 * 3) : (30 * parameters.length)
                            anchors.top: parent.top
                            anchors.topMargin: 30

                            model: parameters
                            delegate: Item {
                                id: listview_item
                                width: parent.width
                                height: 30

                                Column {
                                    width: parent.width
                                    height: parent.height

                                    Item {
                                        width: parent.width
                                        height: 29

                                        Text {
                                            id: item_parameter
                                            width: (parent.width /2) -(button_edit_parameter.width /2) -(button_remove_parameter.width)
                                            height: parent.height
                                            anchors.left: parent.left
                                            anchors.leftMargin: 5

                                            text: modelData.parameter
                                            verticalAlignment: Text.AlignVCenter
                                            elide: Text.ElideRight
                                        }
                                        Text {
                                            id: item_value
                                            width: (parent.width /2) -(button_remove_parameter.width)
                                            height: parent.height
                                            anchors.left: item_parameter.right

                                            text: modelData.value
                                            verticalAlignment: Text.AlignVCenter
                                            elide: Text.ElideRight
                                        }

                                        Rectangle {
                                            id: button_edit_parameter
                                            width: 25
                                            height: parent.height
                                            color: "transparent"

                                            Text {
                                                text: "\uE254"
                                                font.family: material_icon.name
                                                font.pixelSize: 20
                                                anchors.centerIn: parent
                                            }
                                            anchors.left: item_value.right

                                            MouseArea {
                                                id: mousearea_edit_parameter
                                                anchors.fill: parent

                                                onClicked: {

                                                }
                                            }
                                        }

                                        Rectangle {
                                            id: button_remove_parameter
                                            width: 25
                                            height: parent.height
                                            color: "transparent"

                                            Text {
                                                text: "\uE15C"
                                                font.family: material_icon.name
                                                font.pixelSize: 20
                                                anchors.centerIn: parent
                                                color: Material.color(Material.Red)
                                            }
                                            anchors.left: button_edit_parameter.right

                                            MouseArea {
                                                id: mousearea_remove_parameter
                                                anchors.fill: parent

                                                onClicked: {
                                                    parameters.splice(index, 1);
                                                    parameters = parameters;
                                                }
                                            }
                                        }
                                    }

                                    Rectangle {
                                        width: parent.width
                                        height: 1
                                        color: "#ddd"
                                    }
                                }
                            }
                        }
                    }
                }
            }
            onAccepted: console.log("Ok");
        }

        Dialog {
            id: dialog_add_parameters
            title: qsTr("Adicionar Parâmetro")
            modal: true

            x: Math.round((window.width - width) /2)
            width: (window.width > 300)? 300 : parent.width
            height: 300

            standardButtons: Dialog.Close

            contentItem: Item {
                width: parent.width
                height: parent.height

                Column {
                    anchors.fill: parent

                    Label {
                        text: qsTr("Parâmetro")
                    }
                    TextField {
                        id: textfield_parameter
                        width: parent.width
                        placeholderText: qsTr("parâmetro")
                    }

                    Label {
                        text: qsTr("Valor")
                    }
                    TextField {
                        id: textfield_value
                        width: parent.width
                        placeholderText: qsTr("valor")
                    }

                    Item {
                        width: parent.width
                        height: 5

                        Button {
                            width: parent.width
                            Material.background: Material.Green

                            contentItem: ButtonStyle {
                                colorButton: "#fff"
                                textButton: "Adicionar"
                                iconButton: "\uE145"
                            }

                            onClicked: {
                                if (textfield_parameter.text != "" && textfield_value.text != "") {
                                    parameters.push({'parameter': textfield_parameter.text, 'value': textfield_value.text});
                                    parameters = parameters;
                                    textfield_parameter.text = "";
                                    textfield_value.text = "";
                                    dialog_add_parameters.close();
                                } else {
                                    tooltip_validate.visible = true
                                    tooltip_validate.text = qsTr("Preencha todos os campos")
                                }
                            }
                        }
                    }
                }

                ToolTip {
                    id: tooltip_validate
                    timeout: 5000
                    topMargin: parent.height /2
                }
            }
        }
    }

    Component.onCompleted: {
        window.header.title_page = "QPost"
    }
}
