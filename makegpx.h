#ifndef MAKEGPX_H
#define MAKEGPX_H

#include <QObject>

class MakeGPX : public QObject
{
    Q_OBJECT
public:
    explicit MakeGPX(QObject *parent = 0);

signals:
    void sendToQml(int count);

public slots:
    void receiveFromQml(QString pathToDir);
};

#endif // MAKEGPX_H
