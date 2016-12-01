#include "database.h"
DataBase::DataBase(QObject *parent) : QObject(parent)
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("DataBase.db");
    db.open();
}

void DataBase::printTracks()
{
    //Осуществляем запрос
    QSqlQuery query;
    query.prepare("SELECT id, name FROM Tracks");
    if (!query.exec()){
        qDebug() << "Error:" << query.lastError().text();
    }

    //Выводим значения из запроса
    while (query.next())
    {
    QString _id = query.value(0).toString();
    QString name = query.value(1).toString();
    qDebug() <<_id << " " << name << "\n";
    }
}

//Функция вычисляет "центр масс" множества точек ШИРОТЫ
double DataBase::getAvgLat(int track_id)
{
    QSqlQuery query;
    query.prepare("SELECT AVG(lat) FROM Points WHERE Points.track_id = :track_id");
    query.bindValue(":track_id", track_id);
    if (!query.exec()){
        qDebug() << "Error:" << query.lastError().text();
    }

    //Выводим значения из запроса
    while (query.next())
    {
        QString lat = query.value(0).toString().toLocal8Bit().constData();
        return lat.toDouble(); // широта
    }

    return -1; //ошибка
}

//Функция вычисляет "центр масс" множества точек ДОЛГОТЫ
double DataBase::getAvgLon(int track_id)
{
    QSqlQuery query;
    query.prepare("SELECT AVG(lon) FROM Points WHERE Points.track_id = :track_id");
    query.bindValue(":track_id", track_id);
    if (!query.exec()){
        qDebug() << "Error:" << query.lastError().text();
    }

    //Выводим значения из запроса
    while (query.next())
    {
        QString lat = query.value(0).toString().toLocal8Bit().constData();
        return lat.toDouble(); // долгота
    }

    return -1; //ошибка
}

void DataBase::createLocalPoint(double lat, double lon, QString type)
{
   QSqlQuery query;
    query.prepare("INSERT INTO LocationsPoints (lat, lon, type) VALUES (:lat, :lon, :type);");
    query.bindValue(":lat", lat);
    query.bindValue(":lon", lon);
    query.bindValue(":type", type);

    if (!query.exec()){
        qDebug() << "Error SQLite:" << query.lastError().text();
    }
    emit updateLocationsModel();
}

void DataBase::prepareDeletePoint(int id)
{
    this->prepareDelete = id;
}

void DataBase::deleteLocalPoint()
{
    QSqlQuery query;
    query.prepare("DELETE FROM LocationsPoints WHERE LocationsPoints.id = :id;");
    query.bindValue(":id", this->prepareDelete);
    if (!query.exec()){
        qDebug() << "Error SQLite:" << query.lastError().text();
    }

    qDebug() << query.lastQuery();
    emit updateLocationsModel();
    qDebug() << "++++++";
    this->prepareDelete = 0;
}

void DataBase::insertIntoTable(QString name)
{
    QSqlQuery query;
    query.prepare("INSERT INTO Tracks (name) VALUES (:name)");
    query.bindValue(":name", name);

    if (!query.exec()){
        qDebug() << "Error SQLite:" << query.lastError().text();
    }

}

int DataBase::parseCSV(QString path)
{   
    path.replace(QString("file:///"), QString(""));
    QString filePath = path;

    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << file.errorString();
        return 1;
    }

    while (!file.atEnd()) {
        QString line(file.readLine());
        QStringList csv(line.split('\t'));

        QSqlQuery query;
        query.prepare("INSERT INTO Points (track_id, lat, lon, alt, azimuth, url, type) VALUES (:id, :lat, :lon, :alt, :azimuth, :url, :type);");
        query.bindValue(":id", "3");
        query.bindValue(":lat", csv[LAT]);
        query.bindValue(":lon", csv[LON]);
        query.bindValue(":alt", csv[ALT]);
        query.bindValue(":azimuth", csv[ANGLE]);
        query.bindValue(":url", csv[IMG_PATH]);
        query.bindValue(":type", "test");

        if (!query.exec()){
            qDebug() << "Error SQLite:" << query.lastError().text();
            qDebug() << query.lastQuery();
        }
    }
    qDebug() << "Hello";
    return 0;
}

/*void DataBase::printPoints()
{
    QSqlQuery query;
    query.prepare("SELECT track_id, lat, lon, alt, comment, type FROM Points WHERE track_id = 1");
    if (!query.exec()){
        qDebug() << "Error:" << query.lastError().text();
    }

    //Выводим значения из запроса
    while (query.next())
    {
        QString id = query.value(0).toString().toLocal8Bit().constData();
        QString lat = query.value(1).toString().toLocal8Bit().constData();
        QString lon = query.value(2).toString().toLocal8Bit().constData();
        QString alt = query.value(3).toString().toLocal8Bit().constData();
        QString comment = query.value(4).toString().toLocal8Bit().constData();
        QString type = query.value(5).toString().toLocal8Bit().constData();
        qDebug() << id << " " << lat << " " << lon  << " "<< alt << " " << comment << " " << type << "\n";
    }
}*/
