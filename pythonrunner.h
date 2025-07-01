#include <QObject>
#include <QProcess>

class PythonRunner : public QObject {
    Q_OBJECT
public:
    Q_INVOKABLE void runScript(const QString &scriptPath) {
        QProcess *process = new QProcess(this);
        process->start("python3", QStringList() << scriptPath);

        connect(process, &QProcess::readyReadStandardOutput, [process]() {
            qDebug() << "Python stdout:" << process->readAllStandardOutput();
        });

        connect(process, &QProcess::readyReadStandardError, [process]() {
            qDebug() << "Python stderr:" << process->readAllStandardError();
        });
    }
};