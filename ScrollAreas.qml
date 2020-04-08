import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import NoteModel 1.0

ScrollView {
    id: scroll
    anchors.fill: parent
    ScrollBar.vertical.interactive: true
    anchors.topMargin: 30
    property alias list: listModel

    ListView {
        id: view
        width: parent.width
        layoutDirection: Qt.LeftToRight
        anchors.topMargin: 15

        model: NoteModel {
            id: listModel
        }

        delegate: Rectangle {
            property alias task: taskText

            id: rootT
            border.width: 1
            width: parent.width
            height: 105
            opacity: checkBox.checkState === Qt.Checked ? 0.5 : 1
            color: Material.background
            task.enabled: checkBox.checkState === Qt.Checked ? false : true

            MouseArea {
                id: delegMouse
                anchors.fill: rootT
                enabled: checkBox.checkState === Qt.Checked ? false : true
                onClicked: {
                    view.currentIndex = index
                    taskText.enabled = true
                }
                onPressAndHold: {
                    //view.currentIndex = index
                    listModel.removeRow(view.currentIndex)
                }
            }

            CheckBox {
                id: checkBox
                anchors.left: parent.left
                checked: isChecked
                width: 50
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    //view.currentIndex = index
                    listModel.setChecked(index, checked)
                }
            }

            TextInput {
                id: taskText
                anchors.left: checkBox.right
                width: parent.width - (acceptButton.width * 3)
                height: checkBox.height
                text: note
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
                autoScroll: true
                onTextChanged: {
                    listModel.setStr(index, text)
                    acceptButton.enabled = true
                    acceptButton.visible = true
                }
            }

            Rectangle {
                id: acceptButton
                height: rootT.height - 10
                width: rootT.height / 2
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 4
                color: Material.color(Material.Green)
                opacity: mouse.pressed ? 0.6 : 1
                visible: checkBox.checkState === Qt.Checked ? false : isAccepted
                Image {
                    id: image
                    source: "qrc:/tick.svg"
                    anchors.fill: acceptButton
                    scale: 0.6
                    antialiasing: true
                    smooth: true
                }

                MouseArea {
                    id: mouse
                    enabled: checkBox.checkState === Qt.Checked ? false : true
                    anchors.fill: acceptButton
                    onClicked: {
                        acceptButton.visible = false
                        isAccepted = true
                        listModel.setStr(index, taskText.text)
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

