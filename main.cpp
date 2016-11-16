#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "makegpx.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    MakeGPX mkgpx;

    QQmlContext* ctx = engine.rootContext();
    ctx->setContextProperty("CMakeGPX", &mkgpx);
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));
    //receiver.sendToQml(43);

    return app.exec();
}
