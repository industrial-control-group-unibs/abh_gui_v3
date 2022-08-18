#include <QmlStringUdpReceiver.h>
#include <QDebug>
#include <iostream>

namespace UdpCom {
StringReceiver::StringReceiver(QObject *parent)
  : QObject(parent)
{
  connect( this, &StringReceiver::portChanged, this, &StringReceiver::createSocket, Qt::ConnectionType::QueuedConnection );
}

QString StringReceiver::port() const
{
  return port_;
}
void StringReceiver::setPort(QString port)
{
  port_=port;
  emit portChanged();
}

QString StringReceiver::rstring() const
{
  return rstring_;
}

QString StringReceiver::name() const
{
  return name_;
}
void StringReceiver::setName(QString name)
{
  name_=name;
}


void StringReceiver::readThread()
{
  if (not socket_)
    return;
  std::cout << "[" << name_.toStdString() <<": " << port_.toStdString() << "]" << " start read thread" << std::endl;
  while (not stop_flag_)
  {
    if (socket_->isUnreadDataAvailable())
    {
      rstring_ = QString::fromStdString(socket_->getData());
      std::cout << rstring_.toStdString() << std::endl;
      socket_->clearQueue();
      emit stringChanged();
    }
    usleep(1000);
  }
  socket_.reset();
}

void StringReceiver::createSocket()
{
  if (port_.isEmpty())
    return;

  if (socket_)
  {
    stop_flag_=true;
    if (thread_.joinable())
      thread_.join();

    stop_flag_=false;
    socket_.reset();
  }
  try {
    socket_=std::make_shared<udp_string_helper::Receiver>( port_.toStdString());
    stop_flag_=false;
    connected_=true;
  }
  catch (std::exception& e)
  {
    std::cout << e.what() << std::endl;
    connected_=false;
    return;
  }
  thread_=std::thread(&StringReceiver::readThread,this);


}

StringReceiver::~StringReceiver()
{
  stop_flag_=true;
  if (thread_.joinable())
    thread_.join();

}
}
