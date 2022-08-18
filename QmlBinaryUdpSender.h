#ifndef QML_BINARY_UDP_SENDER
#define QML_BINARY_UDP_SENDER

#include <QObject>
#include <QString>
#include <QVector>
#include <UdpSocketHelperCpp/udp_binary_sockets.h>

namespace UdpCom {
class BinarySender : public QObject
{
  Q_PROPERTY(QString         host    READ host    WRITE setHost   NOTIFY hostChanged )
  Q_PROPERTY(QString         port    READ port    WRITE setPort   NOTIFY portChanged)
  Q_PROPERTY(QVector<qreal>  data    READ data    WRITE setData   NOTIFY dataChanged)
  Q_OBJECT
public:
  explicit BinarySender(QObject *parent = nullptr);

  QString host() const;
  void setHost(QString ip);

  QString port() const;
  void setPort(QString port);

  QVector<qreal> data() const;
  void setData(QVector<qreal> data);

  protected slots:
  void createSocket();
signals:
  void portChanged();
  void hostChanged();
  void dataChanged();
protected:
  QString host_;
  QString port_;
  QVector<qreal> data_;
  bool connected_=false;
  std::shared_ptr<udp_binary_helper::Sender> socket_;

};

}

#endif // QML_TCP_REC
