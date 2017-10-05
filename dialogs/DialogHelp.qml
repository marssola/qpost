import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3

import "../styles"
import "../"

Dialog {
    id: dialog_help
    modal: true

    x: Math.round((window.width - width) /2)
    width: parent.width - 10
    height: parent.height - 5
    padding: (window.width < 480)? 0 : 5

    standardButtons: Dialog.Close
    contentItem: Item {
        width: parent.width
        height: parent.height

        Column {
            anchors.fill: parent

            ColumnLayout {
                width: parent.width
                height: parent.height

                TabBar {
                      id: tabBar
                      Layout.fillWidth: true
                      TabButton {
                          text: qsTr("Ajuda")
                      }
                      TabButton {
                          text: qsTr("Sobre")
                      }
                  }

                  StackLayout {
                      Layout.fillWidth: true
                      Layout.fillHeight: true
                      currentIndex: tabBar.currentIndex
                      Item {
                          id: tabHelp
                          Layout.fillHeight: true
                          Layout.fillWidth: true

                          Rectangle {
                              anchors.fill: parent

                              ColumnLayout {
                                  anchors.left: parent.left
                                  anchors.leftMargin: 10
                                  anchors.right: parent.right
                                  anchors.rightMargin: 10
                                  anchors.top: parent.top
                                  anchors.topMargin: 10
                                  anchors.bottom: parent.bottom
                                  anchors.bottomMargin: 10
                                  anchors.margins: 10
                                  spacing: 10

                                  Text {
                                      Layout.fillWidth: true
                                      text: qsTr("Atalhos")
                                      font.pixelSize: 18
                                      font.bold: true
                                  }

                                  ListView {
                                      Layout.fillWidth: true
                                      Layout.fillHeight: true
                                      clip: true

                                      spacing: 5
                                      model: [
                                          {'shortcut': "F1", 'action': qsTr("Exibe este menu de ajuda")},
                                          {'shortcut': "Ctrl + E", 'action': qsTr("Editar parâmetros")},
                                          {'shortcut': "Ctrl + S", 'action': qsTr("Salvar URL e parâmetros")},
                                          {'shortcut': "Ctrl + Shift + S", 'action': qsTr("Enviar requisição")},
                                          {'shortcut': "Ctrl + Backspace", 'action': qsTr("Limpar dados")},
                                          {'shortcut': "Ctrl + O", 'action': qsTr("Abrir lista de parâmetros salvos")},
                                          {'shortcut': "Ctrl + +", 'action': qsTr("Adicionar parâmetro (Página Editar parêmetros)")}
                                      ]

                                      delegate: Item {
                                          width: parent.width
                                          height: 50

                                          ColumnLayout {
                                              anchors.fill: parent

                                              Text {
                                                  text: modelData.shortcut
                                                  font.bold: true
                                              }
                                              Item {
                                                  Layout.fillHeight: true
                                                  Layout.fillWidth: true

                                                  Text {
                                                      text: modelData.action
                                                      width: parent.width
                                                      wrapMode: Text.WrapAnywhere
                                                  }
                                              }
                                          }
                                      }
                                  }
                              }
                          }
                      }
                      Item {
                          id: tabAbout
                      }
                  }
            }
        }
    }
}
