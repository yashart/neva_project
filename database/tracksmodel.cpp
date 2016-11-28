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
        return tracks[index.row()];
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
    roles[PointsRole] = "points";
    return roles;
}

// Метод обновления таблицы в модели представления данных
void TracksModel::updateModel()
{
    this->tracks = this->getPointsOfTracks();
    // Обновление производится SQL-запросом к базе данных
    QString str_query("SELECT id, name FROM Tracks;");
    this->setQuery(str_query);
    qDebug() << str_query << endl;
    qDebug() << this->tracks[0][0] << endl;
}

QVector<QVariantList> TracksModel::getPointsOfTracks()
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
       //}
       temp_tracks.push_back(path);
       // Сохраняем трек в список
    }
    return temp_tracks;
}

// Получение id из строки в модели представления данных
int TracksModel::getId(int row)
{
    return this->data(this->index(row, 0), IdRole).toInt();
}
