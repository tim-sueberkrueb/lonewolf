#include "downloader.h"

#include <math.h>
#include <QNetworkRequest>

Downloader::Downloader(QObject *parent) :
    QObject(parent),
    m_progress(0)
{
}

Downloader::~Downloader()
{
    cancel();
}

void Downloader::setCacheDir(const QString &cacheDir)
{
    m_cacheDir = cacheDir;
    Q_EMIT cacheDirChanged();
}

void Downloader::cancel()
{
    for (int i = 0; i < m_replies.length(); i++) {
        FileData &data = m_replies[i];
        if (data.reply)
            data.reply->deleteLater();
    }
    m_replies.clear();
    m_progress = 0;
    Q_EMIT progressChanged();
}

void Downloader::setDone()
{
    m_progress = 100;
    Q_EMIT progressChanged();
}

void Downloader::addFile(const QUrl &url)
{
    Downloader::FileData data;
    data.reply = m_manager.get(QNetworkRequest(url));
    data.received = 0;
    data.total = 0;
    m_replies.append(data);
    connect(data.reply, SIGNAL(downloadProgress(qint64, qint64)), this, SLOT(fileProgress(qint64, qint64)));
    connect(data.reply, SIGNAL(finished()), this, SLOT(fileFinished()));
    calculateProgress();
}

void Downloader::fileProgress(qint64 bytes, qint64 total)
{
    for (int i = 0; i < m_replies.length(); i++) {
        FileData &data = m_replies[i];
        if (data.reply == sender()) {
            data.received = bytes;
            data.total = total;
        }
    }
    calculateProgress();
}

void Downloader::fileFinished()
{
    for (int i = 0; i < m_replies.length(); i++) {
        FileData &data = m_replies[i];
        if (data.reply == sender()) {
            QFile localFile(m_cacheDir + "/" + data.reply->url().fileName());
            if (localFile.open(QIODevice::WriteOnly)) {
                localFile.write(data.reply->readAll());
                localFile.close();
            }

            data.reply->deleteLater();
            data.reply = 0;
            data.received = data.total;
        }
    }
    calculateProgress();
}

void Downloader::calculateProgress()
{
    double done = 0;
    // Rather than calculating actual bytes, we just count files.
    // Often total bytes are 0 until the first chunk download, which
    // also finishes the file.  So we jump between 0 and 100 if we do
    // it by bytes.
    for (int i = 0; i < m_replies.length(); i++) {
        FileData &data = m_replies[i];
        if (!data.reply)
            done += 1;
    }
    if (m_replies.empty()) {
        m_progress = 0;
    } else {
        m_progress = (int)floor(done / m_replies.length() * 100);
    }
    Q_EMIT progressChanged();
}
