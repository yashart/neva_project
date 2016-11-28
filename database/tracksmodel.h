#ifndef TRACKSMODEL_H
#define TRACKSMODEL_H

#include <QObject>
#include <QSqlQueryModel>
#include <QList>
#include <QJSEngine>

class TracksModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        NameRole,
        PointsRole
    };

    explicit TracksModel(QObject *parent = 0);
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QVector<QVariantList> tracks;
    QHash<int, QByteArray> roleNames() const;
    QVector<QVariantList>  getPointsOfTracks();

signals:

public slots:
    void updateModel();
    int getId(int row);
};

#endif // TRACKSMODEL_H
