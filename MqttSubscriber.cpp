#include "MqttSubscriber.h"
#include <QDebug>

MqttSubscriber::MqttSubscriber(QObject *parent)
    : QObject(parent)
{
    feeder_ = {{"ROOM_TEMP", "--"},
               {"HUM", "--"},
               {"VOC", 0},
               {"ACCX", "--"},
               {"ACCY", "--"},
               {"ACCZ", "--"},
               {"GYROX", "--"},
               {"GYROY", "--"},
               {"GYROZ", "--"},
               {"BODY_TEMP", "--"},
               {"MIC", "--"},
               {"DIST", "--"}};

    client_.setHostname("localhost");
    client_.setPort(1883);
    connect(&client_, &QMqttClient::stateChanged, this,
            [this](const QMqttClient::ClientState &state) {
                if (state == QMqttClient::Connected) {
                    setTopic("#");
                }
            });
    connectToHost();
}

MqttSubscriber::~MqttSubscriber()
{
    disconnectFromHost();
}

void
MqttSubscriber::connectToHost()
{
    client_.connectToHost();
}

void
MqttSubscriber::disconnectFromHost()
{
    client_.disconnectFromHost();
}

void
MqttSubscriber::setTopic(const QString &topic)
{
    subscription_ = client_.subscribe(topic, 0);
    connect(subscription_, &QMqttSubscription::messageReceived, this, &MqttSubscriber::handleMessage);
    topic_ = subscription_->topic();

}

void
MqttSubscriber::handleMessage(const QMqttMessage &qmsg)
{
    if (qmsg.topic().name() == "sensors/sht40-temperature") {
        feeder_["ROOM_TEMP"] = qmsg.payload();
    } else if (qmsg.topic().name() == "sensors/sht40-humidity") {
        feeder_["HUM"] = qmsg.payload();
    } else if (qmsg.topic().name() == "sensors/sgp40-voc") {
        feeder_["VOC"] = qmsg.payload();
    } else if (qmsg.topic().name() == "sensors/bmi323-accelerometerX") {
        feeder_["ACCX"] = qmsg.payload();
    } else if (qmsg.topic().name() == "sensors/bmi323-accelerometerY") {
        feeder_["ACCY"] = qmsg.payload();
    } else if (qmsg.topic().name() == "sensors/bmi323-accelerometerZ") {
        feeder_["ACCZ"] = qmsg.payload();
    } else if (qmsg.topic().name() == "sensors/bmi323-gyroscopeX") {
        feeder_["GYROX"] = qmsg.payload();
    } else if (qmsg.topic().name() == "sensors/bmi323-gyroscopeY") {
        feeder_["GYROY"] = qmsg.payload();
    } else if (qmsg.topic().name() == "sensors/bmi323-gyroscopeZ") {
        feeder_["GYROZ"] = qmsg.payload();
    } else if (qmsg.topic().name() == "sensors/mlx90632-temperature") {
        feeder_["BODY_TEMP"] = qmsg.payload();
    } else if (qmsg.topic().name() == "sensors/microphone") {
        feeder_["MIC"] = qmsg.payload();
    } else if (qmsg.topic().name() == "sensors/sr040-distance") {
        feeder_["DIST"] = qmsg.payload();
    }

    emit feederChanged();
}

const QVariantMap
MqttSubscriber::feeder() const
{
    return feeder_;
}
