import QtQuick
import QtQuick.Controls

Window {
    id: root
    width: 1920
    height: 1080
    minimumHeight: 720
    minimumWidth: 1280
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
