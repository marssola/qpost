import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import QtQuick.LocalStorage 2.0

import "./js/Database.js" as Db

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

        Item {
            width: 50
            height: parent.height

            Text {
                width: parent.width
                height: parent.height
                text: "\uE161"
                font.family: material_icon.name
                font.pixelSize: 32
                color: "#fff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    Db.dbSelectPosts();
                    console.log(JSON.stringify(Db.list));
                }
            }
        }
    }
}
