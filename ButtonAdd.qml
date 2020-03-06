import QtQuick 2.0
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Styles 1.4

Rectangle {
    id: addButton
    opacity: mouse.pressed ? 0.2 : 1
    Image {
        id: image
        source: "qrc:/plus.svg"
        anchors.fill: addButton
        scale: 0.7
        antialiasing: true
        smooth: true
    }

    MouseArea {
        id: mouse
        anchors.fill: addButton
        onClicked: {
            scrollAreas.list.append({
                                        "root": "item1"
                                    })
        }
    }
}
