QT += qml quick widgets sql positioning

CONFIG += c++11

SOURCES += main.cpp \
    makegpx.cpp \
    exif/exifinfo.cpp \
    database/database.cpp \
    database/pointsmodel.cpp \
    database/tracksmodel.cpp \
    database/imagesmodel.cpp \
    database/locationsmodel.cpp \
    database/linesModel.cpp

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
    database/tracksmodel.h \
    database/imagesmodel.h \
    database/locationsmodel.h \
    database/linesModel.h

DISTFILES += \
    database/DataBase.db
