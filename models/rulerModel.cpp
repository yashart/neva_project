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
    emit startPoint();
}

void RulerModel::delPoint()
{
    if (!this->m_rulerList.empty())
    {
        this->m_rulerList.pop_back();
    }

    emit rulerListChanged();
    emit startPoint();
}

/*
int RulerModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) {
        return 0;
    }

    return m_data.size();
}

QVariant RulerModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }

    switch (role) {
    case PathRole:
        //qDebug() << this->tracks[0];
        return m_data.at(index.row());
    case TextRole:
        return m_data.at(index.row());
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> RulerModel::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[PathRole] = "path";
    roles[TextRole] = "txt";

    return roles;
}

void RulerModel::add()
{
    beginInsertRows(QModelIndex(), m_data.size(), m_data.size());
    m_data.append("new");
    endInsertRows();

    m_data[0] = QString("Size: %1").arg(m_data.size());
    QModelIndex index = createIndex(0, 0, static_cast<void *>(0));
    emit dataChanged(index, index);
}
*/
