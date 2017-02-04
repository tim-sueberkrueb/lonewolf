#include "util.h"

#include <math.h>
#include <time.h>


Util::Util(QObject *parent) :
    QObject(parent)
{
    srand(time(NULL));
}

int Util::getRandom() {
    return rand() % 10;
}

int Util::getDamageToEnemy(int delta, int rand)
{
    if (rand == 0) {
        rand = 10;
    }

    int rv;
    if (delta <= 0) {
        rv = (int)floor(delta / 2.0) + rand + 2;
    } else {
        rv = (int)ceil(delta / 2.0) + rand + 2;
    }
    if (rv < 0) {
        rv = 0;
    } else if (rv > 12) {
        rv = 12 + (rv - 12) * 2;
        if (rv > 18) {
            rv = -1;
        }
    }
    return rv;
}

int Util::getDamageToYou(int delta, int rand)
{
    if (rand == 0) {
        return 0;
    } else if (rand == 9) {
        return delta > -7 ? 0 :
               delta > -9 ? 2 : 3;
    } else if (rand == 8) {
        return delta > -1 ? 0 :
               delta > -5 ? 1 :
               delta > -7 ? 2 :
               delta > -9 ? 3 : 4;
    } else if (rand == 7) {
        return delta > 4 ? 0 :
               delta > -1 ? 1 :
               delta > -5 ? 2 :
               delta > -7 ? 3 :
               delta > -9 ? 4 : 5;
    } else if (rand == 6) {
        return delta > 4 ? 1 :
               delta > -3 ? 2 :
               delta > -5 ? 3 :
               delta > -7 ? 4 :
               delta > -9 ? 5 : 6;
    } else if (rand == 5) {
        return delta > 10 ? 1 :
               delta > -1 ? 2 :
               delta > -3 ? 3 :
               delta > -7 ? 4 :
               delta > -9 ? 5 :
               delta > -11 ? 6 : 7;
    } else if (rand == 4) {
        return delta > 2 ? 2 :
               delta > -1 ? 3 :
               delta > -5 ? 4 :
               delta > -7 ? 5 :
               delta > -9 ? 6 :
               delta > -11 ? 7 : 8;
    } else if (rand == 3) {
        return delta > 6 ? 2 :
               delta > 0 ? 3 :
               delta > -3 ? 4 :
               delta > -7 ? 5 :
               delta > -9 ? 6 :
               delta > -11 ? 7 : 8;
    } else if (rand == 2) {
        return delta > 10 ? 2 :
               delta > 4 ? 3 :
               delta > -1 ? 4 :
               delta > -5 ? 5 :
               delta > -7 ? 6 :
               delta > -9 ? 7 :
               delta > -11 ? 8 : -1;
    } else if (rand == 1) {
        return delta > 8 ? 3 :
               delta > 2 ? 4 :
               delta > -3 ? 5 :
               delta > -7 ? 6 :
               delta > -9 ? 8 : -1;
    }
}
