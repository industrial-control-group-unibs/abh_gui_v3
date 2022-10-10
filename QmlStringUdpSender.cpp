#include <QmlStringUdpSender.h>
#include <QDebug>
#include <iostream>

namespace UdpCom {
StringSender::StringSender(QObject *parent)
  : QObject(parent)
{
  connect( this, &StringSender::hostChanged, this, &StringSender::createSocket, Qt::ConnectionType::QueuedConnection );
}

QString StringSender::host() const
{
  return host_;
}

void StringSender::setHost(QString host)
{
  host_=host;
  emit hostChanged();
}

QString StringSender::port() const
{
  return port_;
}
void StringSender::setPort(QString port)
{
  port_=port;
  emit portChanged();
}

QString StringSender::string() const
{
  return string_;
}
void StringSender::setString(QString string)
{
  string_=string;
  if (socket_)
  {
    std::cout << "send " << string.toStdString() << std::endl;
    socket_->sendString(string.toStdString()+"\n");
    emit stringChanged();
  }
}

void StringSender::createSocket()
{
  if (host_.isEmpty() or port_.isEmpty())
    return;

  std::cout << host_.toStdString() << " : " << port_.toStdString() << std::endl;
  if (socket_)
  {
    socket_.reset();
  }
  try {
    socket_=std::make_shared<udp_string_helper::Sender>(host_.toStdString(), port_.toStdString());
    connected_=true;
  }
  catch (std::exception& e)
  {
    std::cout << e.what() << std::endl;
    connected_=false;
    return;
  }
}

void StringSender::send()
{
  std::cout << "send " << string_.toStdString() << std::endl;
  socket_->sendString(string_.toStdString()+"\n");
}

}
