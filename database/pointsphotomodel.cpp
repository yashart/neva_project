#include "database.h"
#include "pointsphotomodel.h"

PointsPhotoModel::PointsPhotoModel(QObject *parent) :
    QSqlQueryModel(parent)
{
    QObject::connect(this, &PointsPhotoModel::centerChanged,
            this, &PointsPhotoModel::updateModel);

    this->center.setLatitude(45.889533);
    this->center.setLongitude(40.126534);

    this->updateModel();
}

/* Метод для получения данных из модели.
 * Вообще этот метод создан для QML. Именно он его скрытно
 * использует
*/
QVariant PointsPhotoModel::data(const QModelIndex & index, int role) const
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

//Метод для получения имен ролей через хешированную таблицу.
QHash<int, QByteArray> PointsPhotoModel::roleNames() const {
    /* То есть сохраняем в хеш-таблицу названия ролей
     * по их номеру
     * */
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[LatRole] = "lat";
    roles[LonRole] = "lon";
    roles[TypeRole] = "type";
    roles[DistRole] = "dist";
    return roles;
}

// Метод обновления таблицы в модели представления данных
void PointsPhotoModel::updateModel()
{
    // Обновление производится SQL-запросом к базе данных
    QString str_query("SELECT ");
    str_query.append("id, ");
    str_query.append("lat, ");
    str_query.append("lon, ");
    str_query.append("type, ");
    str_query.append(QString("(((lat - (%1)) * (lat - (%1))) + ").arg(this->center.latitude()));
    str_query.append(QString("(lon - (%1)) * (lon - (%1))) * (110 * 110) AS dist ").arg(this->center.longitude()));
    str_query.append("FROM LocationsPoints ");
    str_query.append("WHERE dist <= (0.25 * 0.25); ");

    this->setQuery(str_query);

    while(this->canFetchMore()){ // загрузка всех данных в кэш
        this->fetchMore();
    }
}

//Получение id из строки в модели представления данных
int PointsPhotoModel::getId(int row)
{
    return this->data(this->index(row, 0), IdRole).toInt();
}

void PointsPhotoModel::setCenter(double lat, double lon)
{
    this->center.setLatitude(lat);
    this->center.setLongitude(lon);
    emit centerChanged();
}
