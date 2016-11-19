#include <QDebug>
#include <QDir>
#include <QDateTime>
#include <iostream>
#include <fstream>

#include "makegpx.h"
#include "exif/exifinfo.h"


MakeGPX::MakeGPX(QObject *parent) : QObject(parent)
{

}

void MakeGPX::receiveFromQml(QString pathToDir) {
    qDebug() << "From QML:" << pathToDir;

    pathToDir.replace(QString("file:///"), QString(""));
    QString filePath = pathToDir;

    filePath +="/TrackGPX.gpx";
    QFile fileGPX(filePath);
    fileGPX.open(QIODevice::WriteOnly);

    QTextStream fStream(&fileGPX);

    //Header of gpx written to the file
    fStream << "<?xml version=\"1.0\" encoding=\"UTF-8\"?> " << endl;
    fStream << "<gpx version=\"1.0\">" << endl;
    fStream << " <name>Example gpx</name>" << endl;
    fStream << "   <wpt>" << endl;
    fStream << "       <ele>2372</ele>" << endl;
    fStream << "       <name>LAGORETICO</name>" << endl;
    fStream << "   </wpt>" << endl;
    fStream << "   <trk><name>Example gpx</name><number>1</number><trkseg>" << endl;

    QDir dir;
    dir.setFilter(QDir::Files | QDir::Hidden | QDir::NoSymLinks);
    dir.setSorting(QDir::Time | QDir::Reversed);
    dir.setPath(pathToDir);

    QStringList filters;
    filters << "*.jpg" << "*.jpeg";

    QFileInfoList list = dir.entryInfoList(filters, QDir::Files|QDir::NoDotAndDotDot);
    for (int i = 0; i < list.size(); ++i) {
        QFileInfo fileInfo = list.at(i);
        qDebug() << qPrintable(QString("%1").arg(fileInfo.absoluteFilePath()));

        FILE *fp = fopen(fileInfo.absoluteFilePath().toUtf8().constData(), "rb");
        if (!fp) {
            printf("Can't open file.\n");
        }
        fseek(fp, 0, SEEK_END);
        unsigned long fsize = ftell(fp);
        rewind(fp);
        unsigned char *buf = new unsigned char[fsize];
        if (fread(buf, 1, fsize, fp) != fsize) {
            printf("Can't read file.\n");
            delete[] buf;
        }
        fclose(fp);

        // Parse EXIF
        easyexif::EXIFInfo result;
        int code = result.parseFrom(buf, fsize);
        delete[] buf;
        if (code) {
            printf("Error parsing EXIF: code %d\n", code);
        }

        fStream << "                <trkpt ";
        fStream << "lat=\"" << result.GeoLocation.Latitude << "\" ";
        fStream << "lon=\"" << result.GeoLocation.Longitude << "\" ";
        fStream << "alt=\"" << result.GeoLocation.Altitude << "\">";
        fStream << "<image>" << fileInfo.fileName().toUtf8().constData() << "</image>";
        //fStream << "<time>" << fileInfo.created().toString().toUtf8().constData() << "</time>";
        fStream << "</trkpt>" << endl;
    }
    fStream << "    </trkseg></trk>" << endl;
    fStream << "</gpx>";
    fileGPX.close();


}
