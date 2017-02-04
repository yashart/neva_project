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
            qDebug() << "Hello";
            return this->m_rulerList.at(0);
        }
        return QVariant();
    }

    Q_INVOKABLE void addPoint(QGeoCoordinate point);
    Q_INVOKABLE void delPoint();
signals:
    void rulerListChanged();
    void startPointChanged();
private:
    QVariantList m_rulerList;
};
#endif // RULER_H
