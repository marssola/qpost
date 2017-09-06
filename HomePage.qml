import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0


ScrollablePage {
    id: homePage

    ColumnLayout {
        spacing: 5

        Column {
            width: parent.width

            Label {
                width: parent.width
                wrapMode: Label.Wrap
                text: qsTr("URL")
            }

            TextField {
                id: field
                width: parent.width
                placeholderText: qsTr("URL")
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    Component.onCompleted: {
        window.header.title_page = "QPost"
    }
}
