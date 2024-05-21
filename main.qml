import QtQuick
import QtQuick.Controls

Window {
    id: root
    width: 800
    height: 480
    minimumHeight: 480
    minimumWidth: 800
    visible: true
    title: qsTr("mamabear")
    flags: Qt.FramelessWindowHint | Qt.Window

    MainView {
        id: mainview

        anchors.centerIn: parent
        width: root.width - 90
        height: root.height - 90
    }
}
