#ifndef DOWNLOADER_H
#define DOWNLOADER_H

#include <QDir>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QObject>
#include <QUrl>

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
    void fileProgress(qint64 bytes, qint64 total);
    void fileFinished();

protected:
    void calculateProgress();

    class FileData {
    public:
        QNetworkReply *reply;
        qint64 received;
        qint64 total;
    };

    QString m_cacheDir;
    int m_progress;
    QVector<FileData> m_replies;
    QNetworkAccessManager m_manager;
};

#endif // DOWNLOADER_H
