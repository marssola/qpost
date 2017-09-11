import QtQuick 2.9
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "./styles"

ScrollablePage {
    id: homePage

    property var parameters: []
        /*{'parameter': 'parametro 1', 'value': 'valor'},
        {'parameter': 'parametro 2', 'value': 'valor'},
        {'parameter': 'parametro 3', 'value': 'valor'},
        {'parameter': 'parametro 3', 'value': 'valor'},
        {'parameter': 'parametro 3', 'value': 'valor'},
        {'parameter': 'parametro 3', 'value': 'valor'}*/

    Column {
        anchors.fill: parent

        Item {
            width: parent.width
            height: 20
        }

        Rectangle {
            width: parent.width
            height: rowlayout_url.height + rowlayout_parameters.height + 20
            border.color: "#ccc"

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
                    Button {
                        Layout.minimumWidth: 100
                        Material.background: Material.Green
                        Material.foreground: "#fff"

                        contentItem: ButtonStyle {
                            iconButton: "\uE163"
                            textButton: "Enviar"
                            colorButton: "#fff"
                        }
                    }
                }
                Rectangle {
                    width: parent.width
                    height: 1
                    color: "#ddd"
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
                        text: homePage.parameters.length
                        Layout.fillWidth: true
                        wrapMode: Text.WordWrap
                    }
                    Button {
                        Layout.minimumWidth: 100
                        Material.background: Material.Blue
                        Material.foreground: "#fff"

                        contentItem: ButtonStyle {
                            iconButton: "\uE254"
                            textButton: "Editar"
                            colorButton: "#fff"
                        }

                        onClicked: {
                            dialog_parameters.open();
                        }
                    }

                }
            }
        }

        Dialog {
            id: dialog_parameters
            title: qsTr("Editar parâmetros")
            modal: true

            x: Math.round((window.width - width) /2)
            width: (window.width > 1000)? 1000 : parent.width
            height: window.height - window.header.height
        }
    }

    Component.onCompleted: {
        window.header.title_page = "QPost"
    }
}
