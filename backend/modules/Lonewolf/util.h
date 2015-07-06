#ifndef UTIL_H
#define UTIL_H

#include <QObject>

class Util : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(Util)

public:
    explicit Util(QObject *parent = 0);

    Q_INVOKABLE int getRandom();
    Q_INVOKABLE int getDamageToEnemy(int delta, int rand);
    Q_INVOKABLE int getDamageToYou(int delta, int rand);
};

#endif // UTIL_H

