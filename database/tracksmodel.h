#ifndef TRACKSMODEL_H
#define TRACKSMODEL_H

#include <QObject>
#include <QSqlQueryModel>
#include <QList>
#include <QJSEngine>
#include <QGeoCoordinate>

class TracksModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        NameRole,
        CheckRole,
        PointsRole

    };

    explicit TracksModel(QObject *parent = 0);
    ~TracksModel();

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QStringList tracksIdList;
    QVector<QVariantList> tracks;
    QHash<int, QByteArray> roleNames() const;
    QVector<QVariantList> getPointsOfTracks();

signals:

public slots:
    void updateModel();
    int getId(int row);
    void recvTracksId(QStringList ids);
    void setChecked(int id);
    void setUnchecked(int id);
};

#endif // TRACKSMODEL_H
