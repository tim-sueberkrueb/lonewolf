#include "book.h"

#include <QDebug>
#include <QFile>
#include <QXmlQuery>
#include <QTextStream>
#include <QUrl>
#include <libxml/tree.h>

Book::Book(QObject *parent) :
    QObject(parent),
    m_dom(NULL)
{

}

Book::~Book()
{
    xmlFreeDoc(m_dom);
}

/*QString Book::getCacheDir()
{
    return QStandardPaths::writableLocation(QStandardPaths::CacheLocation);
}*/

void Book::setFilename(const QString &filename)
{
    m_filename = filename;

    //QString filePath = getCacheDir() + "/" + filename + ".xml";
    QString filePath = "http://www.projectaon.org/en/xml/" + filename + ".xml";
    m_dom = xmlReadFile(filePath.toUtf8(), NULL, XML_PARSE_NOENT);
    if (m_dom == NULL)
        return;

    Q_EMIT filenameChanged();
}

xmlNodePtr Book::getElement(const QString &tag, xmlNodePtr parent)
{
    if (parent == NULL)
        parent = xmlDocGetRootElement(m_dom);

    xmlNodePtr cur;
    cur = parent->children;
    while (cur != NULL) {
        if ((!xmlStrcmp(cur->name, (const xmlChar *)tag.toUtf8().data()))) {
            return cur;
        }

        xmlNodePtr maybe = getElement(tag, cur);
        if (maybe)
            return maybe;

        cur = cur->next;
    }

    return NULL;
}

xmlNodePtr Book::getElementById(const QString &tag, const QString &id, xmlNodePtr parent)
{
    if (parent == NULL)
        parent = xmlDocGetRootElement(m_dom);

    xmlNodePtr cur;
    cur = parent->children;
    while (cur != NULL) {
        if ((!xmlStrcmp(cur->name, (const xmlChar *)tag.toUtf8().data()))) {
            xmlChar *val = xmlGetProp(cur, (const xmlChar *)"id");
            if (!xmlStrcmp(val, (const xmlChar *)id.toUtf8().data())) {
                xmlFree(val);
                return cur;
            }
            xmlFree(val);
        }

        xmlNodePtr maybe = getElementById(tag, id, cur);
        if (maybe)
            return maybe;

        cur = cur->next;
    }

    return NULL;
}

xmlNodePtr Book::getElementByClass(const QString &tag, const QString &klass, xmlNodePtr parent)
{
    if (parent == NULL)
        parent = xmlDocGetRootElement(m_dom);

    xmlNodePtr cur;
    cur = parent->children;
    while (cur != NULL) {
        if ((!xmlStrcmp(cur->name, (const xmlChar *)tag.toUtf8().data()))) {
            xmlChar *val = xmlGetProp(cur, (const xmlChar *)"class");
            if (!xmlStrcmp(val, (const xmlChar *)klass.toUtf8().data())) {
                xmlFree(val);
                return cur;
            }
            xmlFree(val);
        }

        xmlNodePtr maybe = getElementByClass(tag, klass, cur);
        if (maybe)
            return maybe;

        cur = cur->next;
    }

    return NULL;
}

QString Book::getTitleContent()
{
    QString text;

    xmlNodePtr meta = getElement("meta");

    xmlNodePtr blurb = getElementByClass("description", "blurb", meta);
    xmlBufferPtr buf = xmlBufferCreate();
    xmlNodeDump(buf, m_dom, blurb, 0, 1);
    text += (const char *)buf->content;
    xmlBufferFree(buf);

    xmlNodePtr creator = getElementByClass("creator", "long", meta);
    buf = xmlBufferCreate();
    xmlNodeDump(buf, m_dom, creator, 0, 1);
    text += (const char *)buf->content;
    xmlBufferFree(buf);

    xmlNodePtr pub = getElementByClass("description", "publication", meta);
    buf = xmlBufferCreate();
    xmlNodeDump(buf, m_dom, pub, 0, 1);
    text += (const char *)buf->content;
    xmlBufferFree(buf);

    xmlNodePtr license = getElementByClass("rights", "license-notification", meta);
    buf = xmlBufferCreate();
    xmlNodeDump(buf, m_dom, license, 0, 1);
    text += (const char *)buf->content;
    xmlBufferFree(buf);

    return text;
}

// Gets all child content, with special treatment for sub-sections
QString Book::getSectionContent(xmlNodePtr section)
{
    QString text;

    xmlNodePtr data = getElement("data", section);

    xmlNodePtr cur;
    cur = data->children;
    while (cur != NULL) {
        bool isSection = xmlStrcmp(cur->name, (const xmlChar *)"section") == 0;
        xmlNodePtr meta = isSection ? getElement("meta", cur) : NULL;
        xmlNodePtr prev = meta ? getElementByClass("link", "prev", meta) : NULL;

        // If it is a simple organizational section (think Credits), then
        // allow it.  If it has its own navigation part, then ignore it.
        if (!prev) {
            xmlBufferPtr buf = xmlBufferCreate();
            xmlNodeDump(buf, m_dom, cur, 0, 1);
            text += (const char *)buf->content;
            xmlBufferFree(buf);
        }

        cur = cur->next;
    }

    return text;
}

QString Book::getChildContent(xmlNodePtr section)
{
    QString text;

    xmlNodePtr cur;
    cur = section->children;
    while (cur != NULL) {
        xmlChar *content= xmlNodeGetContent(cur);
        text += (const char *)content;
        xmlFree(content);

        cur = cur->next;
    }

    return text;
}

QString Book::xmlToHtml(const QString &xml)
{
    QXmlQuery query(QXmlQuery::XSLT20);
    query.setFocus("<body>" + xml + "</body>");
    query.setQuery(QUrl("/home/mike/Work/lonewolf/app/html.xsl"));

    qDebug() << "input:";
    qDebug() << xml;
    QString transformed;
    query.evaluateTo(&transformed);

    return transformed;
}

void Book::setPageId(const QString &id)
{
    m_pageId = id;
    Q_EMIT pageIdChanged();
}

QString Book::firstPageId()
{
    return "title";
}

QString Book::pageTitle()
{
    if (m_dom == NULL)
        return "";
    xmlNodePtr section = getElementById("section", m_pageId);
    xmlNodePtr meta = getElement("meta", section);
    return getChildContent(getElement("title", meta));
}

QString Book::nextPageId()
{
    if (m_dom == NULL)
        return "";
    xmlNodePtr section = getElementById("section", m_pageId);
    xmlNodePtr meta = getElement("meta", section);
    xmlNodePtr link = getElementByClass("link", "next", meta);
    xmlChar *idref = xmlGetProp(link, (const xmlChar *)"idref");
    QString nextId((const char *)idref);
    xmlFree(idref);
    return nextId;
}

QString Book::prevPageId()
{
    if (m_dom == NULL)
        return "";
    xmlNodePtr section = getElementById("section", m_pageId);
    xmlNodePtr meta = getElement("meta", section);
    xmlNodePtr link = getElementByClass("link", "prev", meta);
    xmlChar *idref = xmlGetProp(link, (const xmlChar *)"idref");
    QString nextId((const char *)idref);
    xmlFree(idref);
    return nextId;
}

QString Book::pageContent()
{
    if (m_dom == NULL)
        return "";
    xmlNodePtr section = getElementById("section", m_pageId);
    QString content;
    if (m_pageId == "title") {
        content = getTitleContent();
    } else {
        content = getSectionContent(section);
    }
    return xmlToHtml(content);
}
