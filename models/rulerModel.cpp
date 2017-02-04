#include "rulerModel.h"
#include <QDebug>

RulerModel::RulerModel(QObject *parent):
    QAbstractListModel(parent)
{
    m_data.append("old");
    m_data.append("another old");
}

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
    case ColorRole:
        return QVariant(index.row() < 2 ? "orange" : "skyblue");
    case TextRole:
        return m_data.at(index.row());
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> RulerModel::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[ColorRole] = "color";
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
