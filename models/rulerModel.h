#ifndef RULER_H
#define RULER_H

#include <QAbstractListModel>
#include <QList>
#include <QGeoCoordinate>

class RulerModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        ColorRole = Qt::UserRole + 1,
        TextRole
    };

    RulerModel(QObject *parent = 0);

    virtual int rowCount(const QModelIndex &parent) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE void add();

private:
    QStringList m_data;
};
#endif // RULER_H
