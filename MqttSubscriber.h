#pragma once

#include <QtCore/QMap>
#include <QtMqtt/QMqttClient>
#include <QtMqtt/QMqttSubscription>

#include <QtQml/qqml.h>

class MqttSubscriber : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantMap feeder READ feeder NOTIFY feederChanged MEMBER feeder_)
    QML_ELEMENT
public:

    MqttSubscriber(QObject *parent = nullptr);
    ~MqttSubscriber();

    void connectToHost();
    void disconnectFromHost();
    void setTopic(const QString &topic);

    const QVariantMap feeder() const;

signals:
    void feederChanged();

private:
    void handleMessage(const QMqttMessage &qmsg);

    Q_DISABLE_COPY(MqttSubscriber)
    QMqttClient client_;
    QMqttTopicFilter topic_;
    QMqttSubscription* subscription_;
    QVariantMap feeder_;
};
