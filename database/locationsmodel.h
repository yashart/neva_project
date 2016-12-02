#ifndef LOCATIONSMODEL_H
#define LOCATIONSMODEL_H

#include <QObject>
#include <QSqlQueryModel>

class LocationsModel : public QSqlQueryModel
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
        TypeRole
    };

    // объявляем конструктор класса
    explicit LocationsModel(QObject *parent = 0);

    // Переопределяем метод, который будет возвращать данные
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    /* хешированная таблица ролей для колонок.
     * Метод используется в дебрях базового класса QAbstractItemModel,
     * от которого наследован класс QSqlQueryModel
     * */
    QHash<int, QByteArray> roleNames() const;

signals:

public slots:
    void updateModel();
    int getId(int row);
};

#endif // LOCATIONSMODEL_H
