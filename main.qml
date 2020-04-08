import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import Qt.labs.settings 1.0
import QtQuick.LocalStorage 2.12

ApplicationWindow {
    visible: true
    width: 480
    height: 640
    title: qsTr("NoteManager")
    id: mainWindow
    contentOrientation: Qt.Vertical

    onOpenglContextCreated: {
        scrollAreas.list.load()
    }

    onClosing: {
        scrollAreas.list.save()
    }

    ScrollAreas {
        id: scrollAreas
        anchors.fill: parent
    }

    ButtonAdd {
        id: addButton
        height: 60
        width: 60
        radius: height / 2
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 5
        opacity: mouse.pressed ? 0.2 : 1
        z: 1
        color: Material.color(Material.Amber)

        MouseArea {
            id: mouse
            anchors.fill: addButton
            onClicked: {
                scrollAreas.list.addItem()
            }
        }
    }
}

/*##^##
Designer {
    D{i:2;anchors_height:20;anchors_width:20}
}
##^##*/

