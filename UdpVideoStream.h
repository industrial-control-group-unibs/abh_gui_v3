#ifndef QML_GRABBER_H
#define QML_GRABBER_H

#include <QImage>
#include <QVideoFrame>
#include <QAbstractVideoSurface>
#include "opencv2/opencv.hpp"
#include <QObject>
#include <QString>
#include <QVideoSurfaceFormat>
#include <QTimer>
#include <QVideoFrame>
#include <mutex>
#include <PracticalSocket.h>
#include <thread>

namespace UdpCom
{
class UdpVideoStream : public QObject
{
  Q_OBJECT
  Q_PROPERTY(QString port    READ port    WRITE setPort NOTIFY portChanged)
  Q_PROPERTY(QAbstractVideoSurface* videoSurface READ videoSurface WRITE setVideoSurface NOTIFY signalVideoSurfaceChanged)
public:
  explicit UdpVideoStream(QObject *parent = nullptr);
  ~UdpVideoStream();
  QAbstractVideoSurface *videoSurface() const;
  void setVideoSurface(QAbstractVideoSurface *videoSurface);

  QString port() const;
  void setPort(QString port);
public:
  void updateFrame(cv::Mat& frame);
signals:
  void signalVideoSurfaceChanged();
  void portChanged();

public slots:
  void slotTick();
  void receiverThread();

private:
  void startSurface();

private:
  QAbstractVideoSurface *mVideoSurface;
  QVideoSurfaceFormat *mSurfaceFormat;
  QImage *mImage=NULL;
  QTimer mTimer;
  std::mutex m_mtx;
  std::thread thread_;
  QString port_;
  bool m_started=false;
  bool stop_flag_=false;

};

}

#endif // QML_GRABBER_H
