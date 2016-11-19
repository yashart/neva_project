QT += qml quick widgets sql

CONFIG += c++11

SOURCES += main.cpp \
    makegpx.cpp \
    exif/exifinfo.cpp \
    database/database.cpp \
    database/pointsmodel.cpp \
    database/tracksmodel.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    makegpx.h \
    exif/exifinfo.h \
    database/database.h \
    database/pointsmodel.h \
    database/tracksmodel.h
