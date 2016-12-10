#ifndef POINTSPHOTOMODEL_H
#define POINTSPHOTOMODEL_H

#include <QObject>
#include <QSqlQueryModel>
#include <QGeoCoordinate>

class PointsPhotoModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    QVariantList list;

    /* Перечисляем все роли, которые будут использоваться в TableView
     * Как видите, они должны лежать в памяти выше параметра Qt::UserRole
     * Связано с тем, что информация ниже этого адреса не для кастомизаций
     * */
    enum Roles {
        IdRole = Qt::UserRole + 1,      // id
        LatRole,
        LonRole,
        TypeRole,
        DistRole
    };

    // объявляем конструктор класса
    explicit PointsPhotoModel(QObject *parent = 0);

    // Переопределяем метод, который будет возвращать данные
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QGeoCoordinate center;
    /* хешированная таблица ролей для колонок.
     * Метод используется в дебрях базового класса QAbstractItemModel,
     * от которого наследован класс QSqlQueryModel
     * */
    QHash<int, QByteArray> roleNames() const;

signals:
    void centerChanged();

public slots:
    void updateModel();
    void setCenter(double lat, double lon);
    int getId(int row);
};

#endif // POINTSPHOTOMODEL_H
