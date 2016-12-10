#include "database.h"
#include "locationsmodel.h"

LocationsModel::LocationsModel(QObject *parent) :
    QSqlQueryModel(parent)
{
    this->updateModel();
}

/* Метод для получения данных из модели.
 * Вообще этот метод создан для QML. Именно он его скрытно
 * использует
*/
QVariant LocationsModel::data(const QModelIndex & index, int role) const
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
QHash<int, QByteArray> LocationsModel::roleNames() const {
    /* То есть сохраняем в хеш-таблицу названия ролей
     * по их номеру
     * */
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[LatRole] = "lat";
    roles[LonRole] = "lon";
    roles[TypeRole] = "type";
    return roles;
}

// Метод обновления таблицы в модели представления данных
void LocationsModel::updateModel()
{
    // Обновление производится SQL-запросом к базе данных
    QString str_query("SELECT ");
    str_query.append("LocationsPoints.id, ");
    str_query.append("LocationsPoints.lat, ");
    str_query.append("LocationsPoints.lon, ");
    str_query.append("LocationsPoints.type ");
    str_query.append("FROM LocationsPoints; ");

    this->setQuery(str_query);

    while(this->canFetchMore()){ // загрузка всех данных в кэш
        this->fetchMore();
    }
}

//Получение id из строки в модели представления данных
int LocationsModel::getId(int row)
{
    return this->data(this->index(row, 0), IdRole).toInt();
}
