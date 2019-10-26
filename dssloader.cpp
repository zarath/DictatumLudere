#include "dssloader.h"
#include <QTemporaryFile>
#include <QDebug>

DSSLoader::DSSLoader(QObject *parent) : QObject(parent)
{
}

void DSSLoader::prepare(const QUrl& audio_url){
    auto path = audio_url.path();
    if (path.endsWith(".dss", Qt::CaseInsensitive)){
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
