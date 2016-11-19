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
    return roles;
}

// Метод обновления таблицы в модели представления данных
void TracksModel::updateModel()
{
    // Обновление производится SQL-запросом к базе данных
    QString str_query("SELECT id, name FROM Tracks;");
    this->setQuery(str_query);
    qDebug() << str_query << endl;
}

// Получение id из строки в модели представления данных
int TracksModel::getId(int row)
{
    return this->data(this->index(row, 0), IdRole).toInt();
}
