import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import mamabear

ColumnLayout {
    id: root

    MqttSubscriber {
        id: mqttSub
    }

    Rectangle { // do not use RowLayout as it breaks the column
        id: logos
        Layout.fillWidth: true
        height: parent.height / 10

        Image {
            id: futureLogo
            anchors.left: parent.left
            height: parent.height

            fillMode: Image.PreserveAspectFit
            source: "resources/future-electronics.svg"
        }

        Image {
            id: nxpLogo
            anchors.right: parent.right
            height: parent.height

            fillMode: Image.PreserveAspectFit
            source: "resources/nxp-logo.svg"
        }
    }

    GridLayout {
        id: grid
        columns: 2
        rows: 3
        Layout.alignment: Qt.AlignHCenter
        Layout.fillHeight: false
        Layout.fillWidth: false
        Layout.preferredWidth: parent.width * 2 / 3
        Layout.topMargin: 5
        Layout.preferredHeight: parent.height * 3 / 5
        flow: GridLayout.TopToBottom
        layoutDirection: Qt.LeftToRight

        Rectangle {
            Layout.alignment: Qt.AlignCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            SensorData {
                id: bodyTemp
                anchors.fill: parent
                icon: "resources/thermometer.png"
                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 30

                        text: "Body Temp: %1 °C".arg(mqttSub.feeder.BODY_TEMP)
                        color: "#00A05D"
                        font {
                            pixelSize: 16
                            bold: true
                        }
                    }
                }
            }
        }
        Rectangle {
            Layout.alignment: Qt.AlignCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            SensorData {
                id: roomData
                anchors.fill: parent
                icon: "resources/humidity.png"
                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 30

                        text: "Temperature - %1 °C\n".arg(mqttSub.feeder.ROOM_TEMP) +
                              "Humidity - %1 %".arg(mqttSub.feeder.HUM)
                        color: "#00A05D"
                        font {
                            pixelSize: 16
                            bold: true
                        }
                    }
                }
            }
        }
        Rectangle {
            Layout.alignment: Qt.AlignCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            SensorData {
                id: giroData
                anchors.fill: parent
                icon: "resources/gyroscope.png"
                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 30

                        text: "accelerometer - x: %1 y: %2 z: %3\n".arg(mqttSub.feeder.ACCX).arg(mqttSub.feeder.ACCY).arg(mqttSub.feeder.ACCZ) +
                              "gyroscope - x: %1 y: %2 z: %3".arg(mqttSub.feeder.GYROX).arg(mqttSub.feeder.GYROY).arg(mqttSub.feeder.GYROZ)
                        color: "#00A05D"
                        font {
                            pixelSize: 16
                            bold: true
                        }
                    }
                }
            }
        }
        Rectangle {
            Layout.alignment: Qt.AlignCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            SensorData {
                id: voc
                anchors.fill: parent
                icon: "resources/voc.png"
                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Text {
                        anchors.horizontalCenter: vocBar.horizontalCenter
                        anchors.bottom: vocBar.top
                        anchors.bottomMargin: 30

                        text: qsTr("VOC Index")
                        color: "#00A05D"
                        font {
                            pixelSize: 16
                            bold: true
                        }
                    }
                    Rectangle {
                        id: vocBar
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 30
                        width: parent.width / 2
                        height: 30
                        radius: 5
                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0.0; color: "blue" }
                            GradientStop { position: 0.2; color: "green" }
                            GradientStop { position: 0.4; color: "yellow" }
                            GradientStop { position: 0.8; color: "orange" }
                            GradientStop { position: 1.0; color: "red" }
                        }
                    }
                    Text {
                        text: "1"
                        anchors.horizontalCenter: vocBar.left
                        anchors.top: vocBar.bottom
                        anchors.topMargin: 5
                        color: "blue"
                    }
                    Text {
                        text: "500"
                        anchors.horizontalCenter: vocBar.right
                        anchors.top: vocBar.bottom
                        anchors.topMargin: 5
                        color: "red"
                    }
                    Triangle {
                        width: 30
                        height: width / 2
                        anchors.verticalCenter: vocBar.top
                        anchors.left: vocBar.left
                        anchors.leftMargin: vocBar.width * mqttSub.feeder.VOC / 500 - width / 2
                    }
                }
            }
        }
        Rectangle {
            Layout.alignment: Qt.AlignCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            SensorData {
                id: mic
                anchors.fill: parent
                icon: "resources/microphone.png"
                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 30

                        text: "%1 dB".arg(mqttSub.feeder.MIC)
                        color: "#00A05D"
                        font {
                            pixelSize: 16
                            bold: true
                        }
                    }
                }
            }
        }
        Rectangle {
            Layout.alignment: Qt.AlignCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            SensorData {
                id: distance
                anchors.fill: parent
                icon: "resources/distance.png"
                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 30

                        text: "Distance: %1 cm".arg(mqttSub.feeder.DIST)
                        color: "#00A05D"
                        font {
                            pixelSize: 16
                            bold: true
                        }
                    }
                }
            }
        }
    }

    Rectangle { // Needed due to interference between the SensorData layout and the current Layout
        Layout.fillHeight: true
        Layout.preferredWidth: parent.width / 2
        Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
        SensorData {
            id: videoData
            anchors.fill: parent
            icon: "resources/camera.png"
            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: false
                Layout.preferredWidth: 16 / 9 * height
                Layout.alignment: Qt.AlignCenter
                color: "transparent"
                MediaDevices {
                    id: devices
                    Component.onCompleted: {
                        console.log(videoInputs)
                        console.log(defaultVideoInput)
                    }
                }
                CaptureSession {
                    camera: Camera {
                        id: camera
                        cameraDevice: devices.defaultVideoInput
                    }
                    videoOutput: video
                }
                VideoOutput {
                    id: video
                    anchors.fill: parent
                    fillMode: VideoOutput.PreserveAspectFit
                }
            }
        }
    }
}
