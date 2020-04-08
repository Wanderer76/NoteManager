import QtQuick 2.0
import QtQuick.Controls.Material 2.12

Rectangle {
 //   property alias buttonAdd: mouse
    id: addButton
    Image {
        id: image
        source: "qrc:/plus.svg"
        anchors.fill: addButton
        scale: 0.7
        antialiasing: true
        smooth: true
    }

}
