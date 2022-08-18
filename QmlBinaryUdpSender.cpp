#include <QmlBinaryUdpSender.h>
#include <QDebug>
#include <iostream>

namespace UdpCom {
BinarySender::BinarySender(QObject *parent)
  : QObject(parent)
{
  connect( this, &BinarySender::hostChanged, this, &BinarySender::createSocket, Qt::ConnectionType::QueuedConnection );
}

QString BinarySender::host() const
{
  return host_;
}

void BinarySender::setHost(QString host)
{
  host_=host;
  emit hostChanged();
}

QString BinarySender::port() const
{
  return port_;
}
void BinarySender::setPort(QString port)
{
  port_=port;
  emit portChanged();
}

QVector<qreal> BinarySender::data() const
{
  return data_;
}
void BinarySender::setData(QVector<qreal> data)
{
  data_=data;
  if (socket_)
  {
    std::vector<double> v=data_.toStdVector(); //QVector<double>::toStdVector(data_);
    socket_->sendData(v);
    emit dataChanged();
  }
}

void BinarySender::createSocket()
{
  if (host_.isEmpty() or port_.isEmpty())
    return;

  std::cout << host_.toStdString() << " : " << port_.toStdString() << std::endl;
  if (socket_)
  {
    socket_.reset();
  }
  try {
    socket_=std::make_shared<udp_binary_helper::Sender>(host_.toStdString(), port_.toStdString());
    connected_=true;
  }
  catch (std::exception& e)
  {
    std::cout << e.what() << std::endl;
    connected_=false;
    return;
  }
}


}
