import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Styles 1.4

ScrollView {
    anchors.fill: parent
    ScrollBar.vertical.interactive: true

    property alias list: listModel
    ListView {

        width: parent.width
        layoutDirection: Qt.LeftToRight
        model: ListModel {
            id: listModel
        }
        delegate: Rectangle {
            border.width: 1
            id: root
            property alias task: taskText

            width: parent.width
            height: 140
            opacity: checkBox.checkState === Qt.Checked ? 0.1 : 1
            color: Material.background
            task.enabled: checkBox.checkState === Qt.Checked ? false : true

            property alias isChecked: checkBox

            MouseArea {
                anchors.fill: root
                enabled: checkBox.checkState === Qt.Checked ? false : true
                onDoubleClicked: {
                    taskText.enabled = true
                }
                onPressAndHold: {
                    listModel.remove(root)
                }
            }

            CheckBox {
                id: checkBox
                anchors.left: parent.left
                checked: false
                width: 50
                anchors.verticalCenter: parent.verticalCenter
            }
            TextEdit {
                id: taskText
                anchors.left: checkBox.right
                width: parent.width - button.width + 10
                height: checkBox.height
                color: Material.foreground
                text: "Item " + (index + 1)
                textFormat: Text.PlainText
                wrapMode: Text.WrapAnywhere
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
                color: Material.color(Material.DeepPurple)
                opacity: mouse.pressed ? 0.6 : 1

                Image {
                    id: image
                    source: "qrc:/tick.svg"
                    anchors.fill: button
                    scale: 0.8
                    antialiasing: true
                    smooth: true
                }

                MouseArea {
                    id: mouse
                    enabled: checkBox.checkState === Qt.Checked ? false : true
                    anchors.fill: button
                    onClicked: {
                        taskText.enabled = false
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

