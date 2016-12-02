#include "database.h"
#include "pointsmodel.h"

PointsModel::PointsModel(QObject *parent) :
    QSqlQueryModel(parent)
{
    this->updateModel();
}

/* Метод для получения данных из модели.
 * Вообще этот метод создан для QML. Именно он его скрытно
 * использует
*/
QVariant PointsModel::data(const QModelIndex & index, int role) const
{
    // Определяем номер колонки, адрес так сказать, по номеру роли
    int columnId = role - Qt::UserRole - 1;
    // Создаём индекс с помощью новоиспечённого ID колонки
    QModelIndex modelIndex = this->index(index.row(), columnId);

    /* И с помощью уже метода data() базового класса
     * вытаскиваем данные для таблицы из модели
     * */
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

void PointsModel::addId(QString new_id)
{
    list_id.append(new_id);
    emit setTracksId(list_id);

}

void PointsModel::delId(QString del_id)
{
    for (int i = 0; i < list_id.size(); i++)
        if (list_id.at(i) == del_id)
        {
            list_id.removeAt(i);
        }
    emit setTracksId(list_id);
}

//Метод для получения имен ролей через хешированную таблицу.
QHash<int, QByteArray> PointsModel::roleNames() const {
    /* То есть сохраняем в хеш-таблицу названия ролей
     * по их номеру
     * */
    QHash<int, QByteArray> roles;
    roles[IdRole] = "track_id";
    roles[LatRole] = "lat";
    roles[LonRole] = "lon";
    roles[AltRole] = "alt";
    roles[AngleRole] = "azimuth";
    roles[DirRole] = "dir";
    roles[URLRole] = "url";
    roles[CommentRole] = "comment";
    roles[TypeRole] = "type";
    return roles;
}

// Метод обновления таблицы в модели представления данных
void PointsModel::updateModel()
{
    // Обновление производится SQL-запросом к базе данных
    QString str_query("SELECT ");
    str_query.append("Points.track_id, ");
    str_query.append("Points.lat, ");
    str_query.append("Points.lon, ");
    str_query.append("Points.alt, ");
    str_query.append("Points.azimuth, ");
    str_query.append("Tracks.dir, ");
    str_query.append("Points.url, ");
    str_query.append("Points.comment, ");
    str_query.append("Points.type ");
    str_query.append("FROM Points ");
    str_query.append("LEFT OUTER JOIN Tracks ON Tracks.id = Points.track_id ");
    str_query.append("WHERE Points.track_id IN (");

    for (int i = 0; i < list_id.size(); i++){
        if (i == list_id.size() - 1) // обработка последнего элемента списка
        {
            str_query.append(QString("%1").arg(list_id.at(i)));
        }
        else
        {
            str_query.append(QString("%1, ").arg(list_id.at(i)));
        }
    }

    str_query.append(") ORDER BY Points.track_id; ");
    this->setQuery(str_query);

    while(this->canFetchMore()){ // загрузка всех данных в кэш
        this->fetchMore();
    }
}

//Получение id из строки в модели представления данных
int PointsModel::getId(int row)
{
    return this->data(this->index(row, 0), IdRole).toInt();
}
