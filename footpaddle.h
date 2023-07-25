#ifdef Q_OQ_LINUX
#ifndef FOOTPADDLE_H
#define FOOTPADDLE_H

#include <array>
#include <QObject>
#include <linux/joystick.h>

class FootPaddle : public QObject
{
    Q_OBJECT
public:
    enum ErrorCode
    {
      SUCCESS,
      OPEN_FAILED,
      NO_FOOTPADDLE,
      WRONG_VERSION,
      ERR_GET_VERSION,
      ERR_GET_BUTTONS
    };

    static constexpr auto MAX_BUTTONS = 8;

    explicit FootPaddle(QObject *parent = nullptr,
                       const QString&& deviceName = "");
    ~FootPaddle();
    FootPaddle::ErrorCode open();
    void close();
    Q_INVOKABLE void updateButtons();
    Q_INVOKABLE int getButton(const int buttonNr) {
        return button_.at(static_cast<size_t>(buttonNr));
    }

private:
    QString deviceName_{};
    int fd_{-1};
    struct js_event event_{};
    std::array<int, MAX_BUTTONS> button_{};
signals:

public slots:
};

#endif // FOOTPADDLE_H
#endif // Q_OS_LINUX
