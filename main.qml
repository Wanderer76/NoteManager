import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Styles 1.4

ApplicationWindow {
    visible: true
    width: 480
    height: 640
    title: qsTr("TaskManager")

    ScrollAreas {
        id: scrollAreas
        anchors.fill: parent
    }

    ButtonAdd {
        id: addButton
        height: 80
        width: 80
        radius: height / 2
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 5
        z: 1
        color: Material.color(Material.Amber)
    }
}

/*##^##
Designer {
    D{i:2;anchors_height:20;anchors_width:20}
}
##^##*/

