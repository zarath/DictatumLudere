#include <qglobal.h>
#ifdef Q_OS_LINUX
#include "footpaddle.h"

#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>

#include <QDebug>

constexpr auto DEVNAME_BUF_SIZE = 128;

FootPaddle::FootPaddle(QObject *parent, const QString &&deviceName)
    : QObject(parent)
    , deviceName_{deviceName}
{}

FootPaddle::~FootPaddle(){
    close();
}

FootPaddle::ErrorCode FootPaddle::open(){
    if (fd_ != -1)
        return SUCCESS;
    fd_ = ::open(deviceName_.toUtf8(), O_RDONLY|O_NONBLOCK);
    if (fd_ < 0)
        return OPEN_FAILED;
    std::array<char, DEVNAME_BUF_SIZE> name{};
    if (::ioctl(fd_, JSIOCGNAME(sizeof(name)), name.data()) == -1){
        close();
        return NO_FOOTPADDLE;
    }
    qDebug() << "Found: " << name.data();

    char bt;
    if (::ioctl(fd_, JSIOCGBUTTONS, &bt) < 0)
    {
      close();
      return ERR_GET_BUTTONS;
    }
    return SUCCESS;
}

void FootPaddle::close(){
    if (fd_ != -1){
        ::close(fd_);
    }
    fd_ = -1;
}

void FootPaddle::updateButtons(){
    for(ssize_t err{0};err != -1;){
        err = read (fd_, &event_, sizeof(event_));
        if((err != -1) &&
           (event_.type & JS_EVENT_BUTTON) &&
           (event_.number < MAX_BUTTONS))
                button_.at(event_.number) = event_.value;
       /* EAGAIN is returned when the queue is empty */
    }
}
#endif
