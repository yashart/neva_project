#include "database.h"
#include "linesModel.h"

LinesModel::LinesModel(QObject *parent) :
    QSqlQueryModel(parent)
{
    this->updateModel();
}

/* Метод для получения данных из модели.
 * Вообще этот метод создан для QML. Именно он его скрытно
 * использует
*/
QVariant LinesModel::data(const QModelIndex & index, int role) const {

    //Если пришел запрос на массив, то досрочно его отдаем
    if (role == PointsRole)
    {
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
QHash<int, QByteArray> LinesModel::roleNames() const {
    /* То есть сохраняем в хеш-таблицу названия ролей
     * по их номеру
     * */
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[NameRole] = "name";
    roles[PointsRole] = "points";
    return roles;
}

// Метод обновления таблицы в модели представления данных
void LinesModel::updateModel()
{
    this->tracks = this->getPointsOfTracks();
    // Обновление производится SQL-запросом к базе данных
    QString str_query("SELECT id, name FROM Tracks;");
    this->setQuery(str_query);
}

void LinesModel::addId(QString new_id)
{
    list_id.append(new_id);

}

void LinesModel::delId(QString del_id)
{
    for (int i = 0; i < list_id.size(); i++)
        if (list_id.at(i) == del_id)
        {
            list_id.removeAt(i);
        }
}

QVector<QVariantList> LinesModel::getPointsOfTracks()
{
    QVector<QVariantList> list;

    //for (int i = 0; i < this->tracksIdList.size(); i++)
    //{
        qDebug() << ">>>>>>>" <<  "ПРИВЕТ";
        QSqlQuery query;

        query.prepare("SELECT lat, lon FROM Points WHERE Points.track_id = :track_id");
        query.bindValue(":track_id", 1/*tracksIdList.at(1)*/);
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
}


// Получение id из строки в модели представления данных
int LinesModel::getId(int row)
{
    return this->data(this->index(row, 0), IdRole).toInt();
}
