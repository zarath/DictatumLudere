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
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QGuiApplication::setWindowIcon(QIcon(":/favicon.png"));

    DSSLoader loader;
#ifdef Q_OS_LINUX
    FootPaddle footPaddle(&app, "/dev/input/js0");
    footPaddle.open();
#endif

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("loader", &loader);
#ifdef Q_OS_LINUX
    engine.rootContext()->setContextProperty("footPaddle", &footPaddle);
#else
    engine.rootContext()->setContextProperty("footPaddle", nullptr);
#endif
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return QGuiApplication::exec();
}
