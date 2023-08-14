#ifndef QML_UDP_BINARY_REC
#define QML_UDP_BINARY_REC

#include <QObject>
#include <QString>
#include <QVector>
#include <UdpSocketHelperCpp/udp_binary_sockets.h>

namespace UdpCom {
class BinaryReceiver : public QObject
{
  Q_OBJECT
  Q_PROPERTY(QString         port    READ    port   WRITE setPort NOTIFY portChanged)
  Q_PROPERTY(QVector<qreal>  data    READ    data   WRITE setData NOTIFY dataChanged)
  Q_PROPERTY(QString         name    READ    name   WRITE setName NOTIFY nameChanged)
  Q_PROPERTY(int             size    READ    size   WRITE setSize NOTIFY sizeChanged)

public:
  explicit BinaryReceiver(QObject *parent = nullptr);
  virtual ~BinaryReceiver();
  QString port() const;
  void setPort(QString port);

  QString name() const;
  void setName(QString name);

  int size() const;
  void setSize(int size);

  QVector<qreal> data();
  void setData(QVector<qreal> d);

public slots:
  bool receivedData();
  void rebootThread();
protected slots:
  void createSocket();
signals:
  void portChanged();
  void nameChanged();
  void dataChanged();
  void sizeChanged();
protected:
  QString port_;
  QString name_;
  QVector<qreal> data_;
  bool connected_=false;
  std::shared_ptr<udp_binary_helper::Receiver> socket_;
  bool stop_flag_=false;
  bool received_data_=false;
  std::thread thread_;
  int size_;

  std::mutex data_mtx;
  void readThread();
};

}

#endif // QML_TCP_REC
