#ifndef RULER_H
#define RULER_H

#include <QAbstractListModel>
#include <QList>
#include <QGeoCoordinate>
#include <QDebug>

class RulerModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList rulerList READ rulerList NOTIFY rulerListChanged)
    Q_PROPERTY(QVariant startPoint READ startPoint NOTIFY startPointChanged)
    Q_PROPERTY(QVariant finishPoint READ finishPoint NOTIFY finishPointChanged)
    Q_PROPERTY(QVariant distance READ distance NOTIFY distanceChanged)

public:
    RulerModel(QObject *parent = 0);
    QVariantList rulerList()
    {
        return this->m_rulerList;
    }
    QVariant startPoint()
    {
        if(!this->m_rulerList.empty())
        {
            return this->m_rulerList.first();
        }
        return QVariant::fromValue(QGeoCoordinate(34.0, -42.0));
    }

    QVariant finishPoint()
    {
        if(this->m_rulerList.size() > 1)
        {
            return this->m_rulerList.last();
        }

        return QVariant::fromValue(QGeoCoordinate(34.0, -42.0)); // убрать в океан
    }
    QVariant distance();

    Q_INVOKABLE void addPoint(QGeoCoordinate point);
    Q_INVOKABLE void delPoint();

signals:
    void rulerListChanged();
    void startPointChanged();
    void finishPointChanged();
    void distanceChanged();
private:
    QVariantList m_rulerList;
};
#endif // RULER_H
