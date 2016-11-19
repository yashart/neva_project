#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "makegpx.h"
#include "database/database.h"
#include "database/tracksmodel.h"
#include "database/pointsmodel.h"
#include <QDir>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);


    DataBase db;
    TracksModel trackModel;
    PointsModel pointModel;

    //db.parseUD();
    //db.printTracks();
    //db.printPoints();

    //qDebug() << QDir::currentPath();

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    MakeGPX mkgpx;

    QQmlContext* ctx = engine.rootContext();

    ctx->setContextProperty("CMakeGPX", &mkgpx);
    ctx->setContextProperty("dataBase", &db);
    ctx->setContextProperty("tracksModel", &trackModel);
    ctx->setContextProperty("pointsModel", &pointModel);
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
