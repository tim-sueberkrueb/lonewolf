#include <QtQml>
#include <QtQml/QQmlContext>
#include <libxml/xmlversion.h>
#include "backend.h"
#include "book.h"
#include "util.h"

static QObject *utilInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    return new Util;
}

void BackendPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QLatin1String("Lonewolf"));

    qmlRegisterType<Book>(uri, 1, 0, "Book");
    qmlRegisterSingletonType<Util>(uri, 1, 0, "Util", utilInstance);
}

void BackendPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    LIBXML_TEST_VERSION

    QQmlExtensionPlugin::initializeEngine(engine, uri);
}
