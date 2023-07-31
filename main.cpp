#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QtDebug>
#include <QIcon>

#include "dssloader.h"
#ifdef Q_OS_LINUX
#include "footpaddle.h"
#endif

int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationName("outgesourced.org");
    QGuiApplication app(argc, argv);

    QGuiApplication::setWindowIcon(QIcon(":/favicon.png"));

    DSSLoader loader;
    QObject *fpaddel = nullptr;
#ifdef Q_OS_LINUX
    FootPaddle footPaddle(&app, "/dev/input/js0");
    footPaddle.open();
    fpaddel = &footPaddle;
#endif

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("loader", &loader);
    engine.rootContext()->setContextProperty("footPaddle", fpaddel);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return QGuiApplication::exec();
}
