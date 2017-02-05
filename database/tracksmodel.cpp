#include "database.h"
#include "tracksmodel.h"

TracksModel::TracksModel(QObject *parent) :
    QSqlQueryModel(parent)
{
    this->updateModel();
}

/* Метод для получения данных из модели.
 * Вообще этот метод создан для QML. Именно он его скрытно
 * использует
*/
QVariant TracksModel::data(const QModelIndex & index, int role) const {

    //Если пришел запрос на массив, то досрочно его отдаем
    if (role == PointsRole)
    {
        qDebug() << "Пытаются докапаться до " << index.row();
        return this->tracks[0];
    }

    // Определяем номер колонки, адрес так сказать, по номеру роли
    int columnId = role - Qt::UserRole - 1;
    // Создаём индекс с помощью новоиспечённого ID колонки
    QModelIndex modelIndex = this->index(index.row(), columnId);

    /* И с помощью уже метода data() базового класса
     * вытаскиваем данные для таблицы из модели
     * */
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

// Метод для получения имен ролей через хешированную таблицу.
QHash<int, QByteArray> TracksModel::roleNames() const {
    /* То есть сохраняем в хеш-таблицу названия ролей
     * по их номеру
     * */
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[NameRole] = "name";
    roles[CheckRole] = "is_check";
    roles[PointsRole] = "points";
    return roles;
}

// Метод обновления таблицы в модели представления данных
void TracksModel::updateModel()
{
    this->tracks = this->getPointsOfTracks();
    // Обновление производится SQL-запросом к базе данных
    QString str_query("SELECT id, name, is_check FROM Tracks;");
    this->setQuery(str_query);
}

void TracksModel::setChecked(int id)
{
    QSqlQuery query;
    query.prepare("UPDATE Tracks SET is_check = 'true' WHERE id = :id ");
    query.bindValue(":id", id);

    if (!query.exec()){
        qDebug() << "Error SQLite:" << query.lastError().text();
    }
}

void TracksModel::setUnchecked(int id)
{
    QSqlQuery query;
    query.prepare("UPDATE Tracks SET is_check = 'false' WHERE id = :id ");
    query.bindValue(":id", id);

    if (!query.exec()){
        qDebug() << "Error SQLite:" << query.lastError().text();
    }
}
TracksModel::~TracksModel()
{
    QSqlDatabase db;
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("DataBase.db");
    db.open();

    QSqlQuery query;
    query.prepare("UPDATE Tracks SET is_check = 'false' ");

    if (!query.exec()){
        qDebug() << "Error SQLite:" << query.lastError().text();
    }
}

void TracksModel::recvTracksId(QStringList ids)
{
    this->tracksIdList = ids;
}

QVector<QVariantList> TracksModel::getPointsOfTracks()
{
    QVector<QVariantList> list;

    //for (int i = 0; i < this->tracksIdList.size(); i++)
    //{
        QSqlQuery query;

        query.prepare("SELECT lat, lon FROM Points WHERE Points.track_id = :track_id");
        query.bindValue(":track_id", 1);
        if (!query.exec()){
            qDebug() << "Error:" << query.lastError().text();
        }

        QVariantList path;

        while (query.next())
        {
            QString lat = query.value(0).toString().toLocal8Bit().constData();
            QString lon = query.value(1).toString().toLocal8Bit().constData();
            QGeoCoordinate coordinate(lat.toDouble(), lon.toDouble());
            path.append(QVariant::fromValue(coordinate));
        }
        list.push_back(path);

    //}

    return list;

    /*QVariantList path;
    QGeoCoordinate coordinate(55.924449, 37.510043);
    path.append(QVariant::fromValue(coordinate));
    coordinate = QGeoCoordinate(55.948002, 37.558683);
    path.append(QVariant::fromValue(coordinate));
    */
}

/*QVector<QVariantList> TracksModel::getPointsOfTracks()
{
    QVector<QVariantList> temp_tracks;
    for (int i = 0; i <= 3; i++) // обрабатываем каждый трек
    {
       QVariantList path;
//       for(int j = 0; j <= 10; j++) // ззаполняем массив с точками одного трека
//       {
           QVariantMap point;
           point["latitude"] = QVariant(55.928848 + (0.000680 * i));
           point["longtitude"] = QVariant(37.519537 + (0.002200 * i));
           path.append(point);

           QVariantMap point2;
           point2["latitude"] = QVariant(55.928169 + (0.000680 * i));
           point2["longtitude"] = QVariant(37.521683 + (0.002200 * i));
           path.append(point2);
       //}push_back(path);
       temp_tracks.
       // Сохраняем трек в список
    }

    return temp_tracks;
}*/

// Получение id из строки в модели представления данных
int TracksModel::getId(int row)
{
    return this->data(this->index(row, 0), IdRole).toInt();
}
