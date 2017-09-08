import QtQuick 2.6
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

Page {
    id: page

    default property alias content: pane.contentItem

    Flickable {
        anchors.fill: parent
        anchors.margins: 2
        contentHeight: pane.implicitHeight
        flickableDirection: Flickable.AutoFlickIfNeeded

        Pane {
            id: pane
            width: parent.width
        }

        ScrollIndicator.vertical: ScrollIndicator {}
    }
}
