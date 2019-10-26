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

    explicit FootPaddle(QObject *parent = nullptr,
                       const QString&& deviceName = "");
    ~FootPaddle();
    FootPaddle::ErrorCode open();
    void close();
    Q_INVOKABLE void updateButtons();
    Q_INVOKABLE int getButton(const int buttonNr) {
        return button_.at(buttonNr);
    };

    static constexpr auto MAX_BUTTONS = 8;
private:
    QString deviceName_{};
    int fd_{-1};
    struct js_event event_{};
    std::array<int, 9> button_{MAX_BUTTONS};
signals:

public slots:
};

#endif // FOOTPADDLE_H
