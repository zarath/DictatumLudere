#ifndef DSSLOADER_H
#define DSSLOADER_H

#include <QObject>
#include <QUrl>

class DSSLoader : public QObject
{
    Q_OBJECT
public:
    explicit DSSLoader(QObject *parent = nullptr);

signals:

public slots:
    void prepare(const QUrl&);
    QString getSource();
private:
    QString source {""};
};

#endif // DSSLOADER_H
