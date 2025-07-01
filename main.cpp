#include <QApplication>
#include <QQmlApplicationEngine>
#include <QProcess>
#include "pythonrunner.h"


int main(int argc, char *argv[])
{
    QApplication::setApplicationName(u"mamabear"_qs);
    QApplication::setOrganizationDomain(u"mamabear.net"_qs);
    QApplication app(argc, argv);
    app.setDesktopFileName(u"mamabear"_qs);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    qmlRegisterType<PythonRunner>("Python.Helper", 1, 0, "PythonRunner");
 //   QProcess *pythonProcess = new QProcess;
 //   pythonProcess->start("python3", QStringList() << "/root/object_detect_don.py");

    engine.load(url);

    return app.exec();
}
