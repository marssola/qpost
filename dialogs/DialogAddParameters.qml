import QtQuick 2.9
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

import "../styles"

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
