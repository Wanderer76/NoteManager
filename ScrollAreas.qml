import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

ScrollView {
    anchors.fill: parent
    ScrollBar.vertical.interactive: true
    anchors.topMargin: 15
    property alias list: listModel
    property alias viewNotes: view
    ListView {
        id: view
        width: parent.width
        layoutDirection: Qt.LeftToRight
        anchors.topMargin: 10

        model: ListModel {
            id: listModel
        }

        delegate: Rectangle {
            id: root
            border.width: 1
            width: parent.width
            height: 100
            opacity: checkBox.checkState === Qt.Checked ? 0.5 : 1
            color: Material.background
            task.enabled: checkBox.checkState === Qt.Checked ? false : true

            property alias task: taskText
            property alias isChecked: checkBox

            MouseArea {
                id: delegMouse
                anchors.fill: root
                enabled: checkBox.checkState === Qt.Checked ? false : true
                onClicked: {
                    taskText.enabled = true
                    button.visible = true
                }
                onPressAndHold: {
                    view.currentIndex = index

                    listModel.remove(view.currentIndex)
                }
            }

            CheckBox {
                id: checkBox
                anchors.left: parent.left
                checked: false
                width: 50
                anchors.verticalCenter: parent.verticalCenter
            }

            TextInput {
                id: taskText
                anchors.left: checkBox.right
                width: parent.width - (button.width * 3)
                height: checkBox.height
                text: idText
                color: Material.toolTextColor
                maximumLength: 90
                selectByMouse: true
                font.weight: Font.Normal
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                font.family: "Yu Gothic UI Semibold"
                font.pointSize: 15
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                renderType: Text.NativeRendering
                anchors.verticalCenter: parent.verticalCenter
                enabled: false
            }
            Rectangle {
                id: button
                height: root.height - 10
                width: root.height / 2
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 4
                color: Material.color(Material.Green)
                opacity: mouse.pressed ? 0.6 : 1
                visible: false
                Image {
                    id: image
                    source: "qrc:/tick.svg"
                    anchors.fill: button
                    scale: 0.6
                    antialiasing: true
                    smooth: true
                }

                MouseArea {
                    id: mouse
                    enabled: checkBox.checkState === Qt.Checked ? false : true
                    anchors.fill: button
                    onClicked: {
                        taskText.enabled = false
                        button.visible = false
                        idText = taskText.text
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

