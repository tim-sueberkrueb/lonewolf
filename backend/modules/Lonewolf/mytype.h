#ifndef BOOK_H
#define BOOK_H

#include <libxml/tree.h>
#include <QObject>

class Book : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString filename READ filename WRITE setFilename NOTIFY filenameChanged)
    Q_PROPERTY(QString firstPageId READ firstPageId NOTIFY filenameChanged)
    Q_PROPERTY(QString pageId READ pageId WRITE setPageId NOTIFY pageIdChanged)
    Q_PROPERTY(QString pageTitle READ pageTitle NOTIFY pageIdChanged)
    Q_PROPERTY(QString pageContent READ pageContent NOTIFY pageIdChanged)
    Q_PROPERTY(QString nextPageId READ nextPageId NOTIFY pageIdChanged)
    Q_PROPERTY(QString prevPageId READ prevPageId NOTIFY pageIdChanged)

public:
    explicit Book(QObject *parent = 0);
    ~Book();

    Q_INVOKABLE int getDamageToEnemy(int delta, int rand);
    Q_INVOKABLE int getDamageToYou(int delta, int rand);

Q_SIGNALS:
    void filenameChanged();
    void pageIdChanged();

protected:
    QString filename() { return m_filename; }
    void setFilename(const QString &filename);

    QString pageId() { return m_pageId; }
    void setPageId(const QString &id);

    QString firstPageId();
    QString nextPageId();
    QString prevPageId();
    QString pageTitle();
    QString pageContent();

    ////

    xmlNodePtr getElement(const QString &tag, xmlNodePtr parent = NULL);
    xmlNodePtr getElementById(const QString &tag, const QString &id = QString::null, xmlNodePtr parent = NULL);
    xmlNodePtr getElementByClass(const QString &tag, const QString &klass = QString::null, xmlNodePtr parent = NULL);

    QString xmlToHtml(const QString &xml);
    QString getSectionContent(xmlNodePtr section);
    QString getChildContent(xmlNodePtr section);

    ////

    QString m_filename;
    QString m_pageId;
    xmlDocPtr m_dom;
};

#endif // BOOK_H

