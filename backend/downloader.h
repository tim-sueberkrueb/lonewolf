#pragma once

#include <QNetworkAccessManager>
#include <QObject>
#include <QUrl>
#include <QVector>

class QNetworkReply;

class Downloader : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int progress READ progress NOTIFY progressChanged)
    Q_PROPERTY(QString cacheDir READ cacheDir WRITE setCacheDir NOTIFY cacheDirChanged)

public:
    explicit Downloader(QObject *parent = 0);
    ~Downloader();

    void addFile(const QUrl &url);
    void cancel();
    void setDone();

    int progress() { return m_progress; }

    QString cacheDir() { return m_cacheDir; }
    void setCacheDir(const QString &cacheDir);

Q_SIGNALS:
    void progressChanged();
    void cacheDirChanged();

protected Q_SLOTS:
    void fileFinished();

protected:
    void calculateProgress();

    class FileData {
    public:
        QNetworkReply *reply;
    };

    QString m_cacheDir;
    int m_progress;
    QVector<FileData> m_replies;
    QNetworkAccessManager m_manager;
};
