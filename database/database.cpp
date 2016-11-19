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

void DataBase::printPoints()
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

int DataBase::parseUD()
{   

    QFile file("jpg.txt");
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << file.errorString();
        return 1;
    }

    while (!file.atEnd()) {
        QString line(file.readLine());
        QStringList csv(line.split('\t'));

        QSqlQuery query;
        query.prepare("INSERT INTO Points (track_id, lat, lon, alt, comment, type) VALUES (:id, :lat, :lon, :alt, :comment, :type)");
        query.bindValue(":id", "1");
        query.bindValue(":lat", csv[LAT]);
        query.bindValue(":lon", csv[LON]);
        query.bindValue(":alt", csv[ALT]);
        query.bindValue(":comment", csv[IMG_PATH]);
        query.bindValue(":type", "test");

        if (!query.exec()){
            qDebug() << "Error SQLite:" << query.lastError().text();
        }
    }
    qDebug() << "Hello";
    return 0;
}
