#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "makegpx.h"
#include "database/database.h"
#include "database/tracksmodel.h"
#include "database/pointsmodel.h"
#include "database/imagesmodel.h"
#include "database/locationsmodel.h"
#include "database/linesModel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);


    DataBase db;
    TracksModel tracksModel;
    PointsModel pointsModel;
    ImagesModel imagesModel;
    LocationsModel locationsModel;
    LinesModel linesModel;

    QObject::connect(&db, SIGNAL(updateLocationsModel()),
                     &locationsModel, SLOT(updateModel()));
    //db.printTracks();
    //db.printPoints();

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    MakeGPX mkgpx;

    QQmlContext* ctx = engine.rootContext();

    ctx->setContextProperty("CMakeGPX", &mkgpx);
    ctx->setContextProperty("dataBase", &db);
    ctx->setContextProperty("tracksModel", &tracksModel);
    ctx->setContextProperty("pointsModel", &pointsModel);
    ctx->setContextProperty("imagesModel", &imagesModel);
    ctx->setContextProperty("locationsModel", &locationsModel);
    ctx->setContextProperty("linesModel", &linesModel);
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
