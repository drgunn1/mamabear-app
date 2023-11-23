import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    id: root

    property string icon: ""
    spacing: 10

    Image {
        id: image
        Layout.alignment: Qt.AlignCenter
        Layout.preferredWidth: root.height / 2
        Layout.preferredHeight: width
        fillMode: Image.PreserveAspectFit
        source: root.icon
        sourceSize.width: width
        sourceSize.height: height
    }
}
