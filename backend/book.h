#pragma once

#include <libxml/tree.h>
#include <QColor>
#include <QObject>
#include "downloader.h"

class Book : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString filename READ filename WRITE setFilename NOTIFY filenameChanged)
    Q_PROPERTY(QString firstPageId READ firstPageId NOTIFY filenameChanged)
    Q_PROPERTY(QString pageId READ pageId WRITE setPageId NOTIFY pageIdChanged)
    Q_PROPERTY(QString pageTitle READ pageTitle NOTIFY pageIdChanged)
    Q_PROPERTY(QString pageContent READ pageContent NOTIFY pageIdChanged)
    Q_PROPERTY(QString pageType READ pageType NOTIFY pageIdChanged)
    Q_PROPERTY(QString nextPageId READ nextPageId NOTIFY pageIdChanged)
    Q_PROPERTY(QString prevPageId READ prevPageId NOTIFY pageIdChanged)
    Q_PROPERTY(int progress READ progress NOTIFY progressChanged)
    Q_PROPERTY(QString dir READ dir WRITE setDir NOTIFY dirChanged)
    Q_PROPERTY(QString cacheDir READ cacheDir NOTIFY filenameChanged)

    Q_PROPERTY(QColor bgColor READ bgColor WRITE setBgColor NOTIFY bgColorChanged)
    Q_PROPERTY(QColor textColor READ textColor WRITE setTextColor NOTIFY textColorChanged)
    Q_PROPERTY(QColor linkColor READ linkColor WRITE setLinkColor NOTIFY linkColorChanged)

public:
    explicit Book(QObject *parent = 0);
    ~Book();

    Q_INVOKABLE void downloadBook();
    Q_INVOKABLE void downloadImages();

Q_SIGNALS:
    void filenameChanged();
    void pageIdChanged();
    void progressChanged();
    void dirChanged();
    void bgColorChanged();
    void textColorChanged();
    void linkColorChanged();

protected Q_SLOTS:
    void downloadProgressChanged();

protected:
    QString filename() { return m_filename; }
    void setFilename(const QString &filename);

    QString pageId() { return m_pageId; }
    void setPageId(const QString &id);

    QString dir() { return m_dir; }
    void setDir(const QString &dir);

    QColor bgColor() { return m_bgColor; }
    void setBgColor(const QColor &bgColor);

    QColor textColor() { return m_textColor; }
    void setTextColor(const QColor &textColor);

    QColor linkColor() { return m_linkColor; }
    void setLinkColor(const QColor &linkColor);

    QString cacheDir();

    QString firstPageId();
    QString nextPageId();
    QString prevPageId();
    QString pageTitle();
    QString pageContent();
    QString pageType();
    void downloadExternalEntities(xmlNodePtr parent);
    void downloadIllustration(xmlNodePtr illustration);
    int progress() {return m_downloader.progress();}
    bool isBookDownloaded();

    ////

    xmlNodePtr getElement(const QString &tag, xmlNodePtr parent = NULL);
    xmlNodePtr getElementById(const QString &tag, const QString &id = QString::null, xmlNodePtr parent = NULL);
    xmlNodePtr getElementByClass(const QString &tag, const QString &klass = QString::null, xmlNodePtr parent = NULL);

    QString xmlToHtml(const QString &xml);
    QString getTitleContent();
    QString getSectionContent(xmlNodePtr section);
    QString getChildContent(xmlNodePtr section);

    ////

    QString m_filename;
    QString m_pageId;
    xmlDocPtr m_dom;
    QString m_dir;
    QColor m_bgColor;
    QColor m_textColor;
    QColor m_linkColor;
    Downloader m_downloader;
};
