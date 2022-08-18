#ifndef QML_TCP_SENDER
#define QML_TCP_SENDER

#include <QObject>
#include <QString>
#include <UdpSocketHelperCpp/udp_string_sockets.h>

namespace UdpCom {
class StringSender : public QObject
{
  Q_PROPERTY(QString host    READ host    WRITE setHost   NOTIFY hostChanged )
  Q_PROPERTY(QString port    READ port    WRITE setPort   NOTIFY portChanged)
  Q_PROPERTY(QString string  READ string  WRITE setString NOTIFY stringChanged)
  Q_OBJECT
public:
  explicit StringSender(QObject *parent = nullptr);

  QString host() const;
  void setHost(QString ip);

  QString port() const;
  void setPort(QString port);

  QString string() const;
  void setString(QString string);

  protected slots:
  void createSocket();
signals:
  void portChanged();
  void hostChanged();
  void stringChanged();
protected:
  QString host_;
  QString port_;
  QString string_;
  bool connected_=false;
  std::shared_ptr<udp_string_helper::Sender> socket_;

};

}

#endif // QML_TCP_REC
