#include <QtQml>
#include <QtQml/QQmlContext>
#include <libxml/xmlversion.h>
#include "backend.h"
#include "mytype.h"


void BackendPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QLatin1String("Lonewolf"));

    qmlRegisterType<Book>(uri, 1, 0, "Book");
}

void BackendPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    LIBXML_TEST_VERSION

    QQmlExtensionPlugin::initializeEngine(engine, uri);
}

