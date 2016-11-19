#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>
#include <QFile>
#include <QDate>
#include <QDebug>

#define LAT 2
#define LON 1
#define ALT 3
#define IMG_PATH 0

class DataBase : public QObject
{
    Q_OBJECT
private:
    QSqlDatabase db;
public:
    explicit DataBase(QObject *parent = 0);
    ~DataBase(){
     db.close();
    }

signals:

public slots:
    void printTracks();
    void printPoints();
    double getAvgLat(int track_id);
    double getAvgLon(int track_id);
    void insertIntoTable(QString name);
    int parseCSV(QString path);
};

#endif // DATABASE_H
