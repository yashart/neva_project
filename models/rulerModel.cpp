#include "rulerModel.h"
#include <QDebug>

RulerModel::RulerModel(QObject *parent):
    QObject(parent)
{

}
void RulerModel::addPoint(QGeoCoordinate point)
{
    qDebug() << point.latitude() << " " << point.longitude() << endl;
    double lat = point.latitude();
    double lon = point.longitude();
    this->m_rulerList.append(QVariant::fromValue
                             (QGeoCoordinate(lat, lon)));
    emit rulerListChanged();
    emit startPointChanged();
    emit finishPointChanged();
    emit distanceChanged();
}

void RulerModel::delPoint()
{
    if (!this->m_rulerList.empty())
    {
        this->m_rulerList.pop_back();
    }

    emit rulerListChanged();
    emit startPointChanged();
    emit finishPointChanged();
    emit distanceChanged();
}

QVariant RulerModel::distance()
{
    double sum = 0;
    for (int i = 1; i < this->rulerList().size(); i++)
    {
        QGeoCoordinate one(this->rulerList().at(i-1).value<QGeoCoordinate>());
        QGeoCoordinate two(this->rulerList().at(i).value<QGeoCoordinate>());
        sum+= one.distanceTo(two);
    }
    return QVariant(QString::number(sum).append(" метров"));
}
