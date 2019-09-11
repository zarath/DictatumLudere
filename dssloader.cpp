#include "dssloader.h"
#include <QTemporaryFile>
#include <QDebug>

DSSLoader::DSSLoader(QObject *parent) : QObject(parent)
{
}

void DSSLoader::prepare(QUrl audio_url){
    auto path = audio_url.path();
    if (path.toLower().endsWith(".dss")){
        qDebug() << path;
    }


    QTemporaryFile file;
    if (file.open()) {
        // file.fileName() returns the unique file name
    }

    // The QTemporaryFile destructor removes the temporary file
    // as it goes out of scope.
}

QString DSSLoader::getSource(){
    return source;
}
