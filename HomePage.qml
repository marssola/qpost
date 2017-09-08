import QtQuick 2.9
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

ScrollablePage {
    id: homePage

    property var parameters: []
        /*{'parameter': 'parametro 1', 'value': 'valor'},
        {'parameter': 'parametro 2', 'value': 'valor'},
        {'parameter': 'parametro 3', 'value': 'valor'},
        {'parameter': 'parametro 3', 'value': 'valor'},
        {'parameter': 'parametro 3', 'value': 'valor'},
        {'parameter': 'parametro 3', 'value': 'valor'}*/

    ColumnLayout {
        Item {
            id: item_options
            width: parent.width

            Rectangle {
                id: rectangle_options
                width: parent.width
                height: 210
                border.color: "#ddd"

                Column {
                    anchors.fill: parent
                    anchors.margins: 5
                    spacing: 10

                    // Field URL
                    Rectangle {
                        width: parent.width
                        height: 20
                        color: "#eee"

                        Text {
                            width: parent.width
                            height: parent.height
                            wrapMode: Text.Wrap
                            text: qsTr("URL")
                            font.bold: true
                            verticalAlignment: Text.AlignVCenter
                            anchors.leftMargin: 5
                            anchors.left: parent.left
                        }
                    }

                    TextField {
                        id: field_url
                        width: parent.width
                        placeholderText: qsTr("URL")

                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                    }

                    // Row Title "Table" Parameters
                    Rectangle {
                        width: parent.width
                        height: 25
                        color: "#eee"

                        Row {
                            anchors.fill: parent
                            anchors.margins: 5
                            Text {
                                width: (parent.width /2)
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                font.bold: true
                                text: qsTr("Parametro")
                            }
                            Text {
                                width: (parent.width /2)
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                font.bold: true
                                text: qsTr("Valor")
                            }
                        }
                    }

                    Item {
                        width: parent.width
                        height: 5
                    }

                    // List parameters

                    /*Item {
                        width: parent.width
                        height: 50
                        visible: (homePage.parameters.length == 0)? true : false

                        Label {
                            text: qsTr("Nenhum parametro adicionado")
                            anchors.centerIn: parent
                        }
                    }*/

                    ListView {
                        id: listview
                        width: parent.width
                        height: 50
                        ScrollIndicator.vertical: ScrollIndicator { }

                        model: parameters
                        delegate: ItemDelegate {
                            width: parent.width
                            height: 35

                            Row {
                                anchors.fill: parent
                                anchors.margins: 5
                                Text {
                                    width: (parent.width /2)
                                    height: parent.height
                                    verticalAlignment: Text.AlignVCenter
                                    text: modelData.parameter
                                }
                                Text {
                                    width: (parent.width /2)
                                    height: parent.height
                                    verticalAlignment: Text.AlignVCenter
                                    text: modelData.value
                                }
                            }
                            Rectangle {
                                width: parent.width
                                height: 1
                                color: "#ccc"
                                anchors.bottom: parent.bottom
                            }
                        }
                    }
                }

                // Button add parameter
                Button {
                    width: 30
                    height: 30
                    anchors.top: rectangle_options.bottom
                    anchors.topMargin: -15
                    anchors.right: parent.right
                    anchors.rightMargin: -5

                    background: Rectangle {
                        anchors.fill: parent
                        radius: parent.width /2
                        color: Material.accent

                        Text {
                            text: "\uE145"
                            font.family: material_icon.name
                            font.pixelSize: Math.round(parent.width * 0.9)
                            color: "#fff"
                            anchors.centerIn: parent
                        }
                    }

                    onClicked: {
                        dialog_add_parameter.open()
                    }
                }
            }
        }

        Dialog {
            id: dialog_add_parameter
            title: qsTr("Adicionar parametro")
            modal: true

            x: Math.round((window.width - width) /2)
            y: 0
            width: (window.width > 350)? 300 : Math.round(window.width * 0.90)

            contentItem: Rectangle {
                color: "transparent"
                implicitWidth: parent.width

                Column {
                    width: parent.width
                    spacing: 10
                    anchors.margins: 10

                    Label {
                        text: qsTr("Parametro:")
                    }
                    TextField {
                        id: textfield_parameter
                        width: parent.width
                        placeholderText: qsTr("Parametro")
                    }

                    Label {
                        text: qsTr("Valor:")
                    }
                    TextField {
                        id: textfield_value
                        width: parent.width
                        placeholderText: qsTr("Valor")
                    }

                    Button {
                        id: button_append_parameter
                        width: parent.width
                        text: qsTr("Adicionar")
                        Material.background: Material.Green
                        Material.foreground: "#fff"

                        onClicked: {
                            homePage.parameters.push({'parameter': textfield_parameter.text, 'value': textfield_value.text})
                            listview.model = homePage.parameters
                            textfield_parameter.text = ""
                            textfield_value.text = ""
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        window.header.title_page = "QPost"
    }
}
