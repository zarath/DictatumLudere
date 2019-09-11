#include "footpaddle.h"

#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>

#include <QDebug>

FootPaddle::FootPaddle(QObject *parent, const QString &deviceName)
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
    char name[128];
    if (::ioctl(fd_, JSIOCGNAME(sizeof(name)), &name) == -1){
        close();
        return NO_FOOTPADDLE;
    }
    qDebug() << "Found: " << name;

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
           (event_.number < 8))
                button_[event_.number] = event_.value;
       /* EAGAIN is returned when the queue is empty */
    }
}

int FootPaddle::getButton(const int buttonNr){
    if((buttonNr >=0) && (buttonNr < 8)){
        return button_[buttonNr];
    } else {
        return 0;
    }
}
