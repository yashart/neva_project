#ifndef LINESMODEL_H
#define LINESMODEL_H

#include <QObject>
#include <QSqlQueryModel>
#include <QList>
#include <QGeoCoordinate>

class LinesModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        NameRole,
        PointsRole

    };

    explicit LinesModel(QObject *parent = 0);
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QStringList list_id;
    QVector<QVariantList> tracks;
    QHash<int, QByteArray> roleNames() const;
    QVector<QVariantList> getPointsOfTracks();

signals:

public slots:
    void updateModel();
    void addId(QString new_id);
    void delId(QString del_id);
    int  getId(int row);
};

#endif // LINESMODEL_H
