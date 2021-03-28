#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QtCore/QUrl>
#include <qqml.h>
#include "App.h"

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<App>("mstein.swffgdice", 1, 0, "App");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/ui/App.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
