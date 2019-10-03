#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QtDebug>
#include <QIcon>

#include "dssloader.h"
#include "footpaddle.h"
#include "unistd.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationName("outgesourced.org");
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/favicon.png"));

    DSSLoader loader;
    FootPaddle footPaddle(&app, "/dev/input/js0");
    footPaddle.open();

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("loader", &loader);
    engine.rootContext()->setContextProperty("footPaddle", &footPaddle);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
