#ifndef POINTSMODEL_H
#define POINTSMODEL_H

#include <QObject>
#include <QSqlQueryModel>

class PointsModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    /* Перечисляем все роли, которые будут использоваться в TableView
     * Как видите, они должны лежать в памяти выше параметра Qt::UserRole
     * Связано с тем, что информация ниже этого адреса не для кастомизаций
     * */
    enum Roles {
        IdRole = Qt::UserRole + 1,      // id
        LatRole,
        LonRole,
        AltRole,
        AngleRole,
        DirRole,
        URLRole,
        CommentRole,
        TypeRole
    };

    // объявляем конструктор класса
    explicit PointsModel(QObject *parent = 0);

    // Переопределяем метод, который будет возвращать данные
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QStringList list_id;
    /* хешированная таблица ролей для колонок.
     * Метод используется в дебрях базового класса QAbstractItemModel,
     * от которого наследован класс QSqlQueryModel
     * */
    QHash<int, QByteArray> roleNames() const;

signals:
    void setTracksId(QStringList ids);

public slots:
    void updateModel();
    void addId(QString new_id);
    void delId(QString del_id);
    int  getId(int row);
};

#endif // POINTSMODEL_H
