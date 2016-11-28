#ifndef TRACKSMODEL_H
#define TRACKSMODEL_H

#include <QObject>
#include <QSqlQueryModel>

class TracksModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        NameRole,
        PointRole
    };

    explicit TracksModel(QObject *parent = 0);
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QVariantList list;
    QHash<int, QByteArray> roleNames() const;

signals:

public slots:
    void updateModel();
    int getId(int row);
};

#endif // TRACKSMODEL_H
