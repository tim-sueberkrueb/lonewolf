#include "mytype.h"

#include <QDebug>
#include <QFile>
#include <QXmlQuery>
#include <QTextStream>
#include <QUrl>
#include <libxml/tree.h>
#include <math.h>

Book::Book(QObject *parent) :
    QObject(parent),
    m_dom(NULL)
{

}

Book::~Book()
{
    xmlFreeDoc(m_dom);
}

void Book::setFilename(const QString &filename)
{
    m_dom = xmlReadFile(filename.toUtf8(), NULL, XML_PARSE_NOENT);
    if (m_dom == NULL)
        return;

    unsigned char *str;
    xmlDocDumpMemory(m_dom, &str, NULL);
    qDebug() << QString((char*)str);

    m_pageId = "";
    m_filename = filename;

    Q_EMIT filenameChanged();
    Q_EMIT pageIdChanged();
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
        // TODO: render title page from meta info
    } else {
        content = getSectionContent(section);
    }
    return xmlToHtml(content);
}

int Book::getDamageToEnemy(int delta, int rand)
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

int Book::getDamageToYou(int delta, int rand)
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
