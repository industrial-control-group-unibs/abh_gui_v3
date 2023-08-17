#include <QmlBinaryUdpReceiver.h>
#include <QDebug>
#include <iostream>

namespace UdpCom {
BinaryReceiver::BinaryReceiver(QObject *parent)
  : QObject(parent)
{
  connect( this, &BinaryReceiver::portChanged, this, &BinaryReceiver::createSocket, Qt::ConnectionType::QueuedConnection );
}

QString BinaryReceiver::port() const
{
  return port_;
}
void BinaryReceiver::setPort(QString port)
{
  port_=port;
  emit portChanged();
}

QString BinaryReceiver::name() const
{
  return name_;
}
void BinaryReceiver::setName(QString name)
{
  name_=name;
}

int BinaryReceiver::size() const
{
  return size_;
}
void BinaryReceiver::setSize(int size)
{
  size_=size;
  data_mtx.lock();
  data_.resize(size_);
  for (int idx=0;idx<size_;idx++)
    data_[idx]=0.0;
  data_mtx.unlock();
  if (socket_)
    socket_->setDataSize(size);
}

QVector<qreal> BinaryReceiver::data()
{
  QVector<qreal> d;
  data_mtx.lock();
  d=data_;
  data_mtx.unlock();
  return d;
}

void BinaryReceiver::setData(QVector<qreal> d)
{
  if (d.size()==size_)
  {
    data_mtx.lock();
    data_=d;
    data_mtx.unlock();
  }
}

bool BinaryReceiver::receivedData()
{
  bool tmp=received_data_;
  received_data_=false;
  return tmp;
}

void  BinaryReceiver::rebootThread()
{
  createSocket();
}

void BinaryReceiver::readThread()
{
  if (not socket_)
    return;
  std::cout << "[" << name_.toStdString() <<": " << port_.toStdString() << "]" << " start read thread" << std::endl;
  while (not stop_flag_)
  {

    if (socket_->isUnreadDataAvailable())
    {
      received_data_=true;
      std::vector<double> v=socket_->getData();
      if (v.size()==size_)
      {
        data_mtx.lock();
        for (size_t idx=0;idx<v.size();idx++)
          data_[idx]=v.at(idx);
        data_mtx.unlock();

        socket_->clearQueue();
        emit dataChanged();
      }
      else
      {
        std::cout << "[" << name_.toStdString() <<": " << port_.toStdString() << "]" << v.size()<< " instead of " << size_ << std::endl;
        if (v.size()<size_)
        {
          int tmp_size=(size_-v.size());
          socket_->setDataSize(tmp_size);
          while (not stop_flag_)
          {
             if (socket_->isUnreadDataAvailable())
             {
               break;
             }
          }
        }

         socket_->clearQueue();
         socket_->setDataSize(size_);
      }
    }
    usleep(1000);
  }
  std::cout << "[" << name_.toStdString() <<": " << port_.toStdString() << "]" << " stop read thread" << std::endl;
  socket_.reset();
}

void BinaryReceiver::createSocket()
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
    qDebug() << "create udp_binary_helper::Receiver. Port: "<<port_;
    socket_=std::make_shared<udp_binary_helper::Receiver>( port_.toStdString());
    stop_flag_=false;
    connected_=true;
  }
  catch (std::exception& e)
  {
    std::cout << e.what() << std::endl;
    connected_=false;
    return;
  }
  thread_=std::thread(&BinaryReceiver::readThread,this);


}

BinaryReceiver::~BinaryReceiver()
{
  stop_flag_=true;
  if (thread_.joinable())
    thread_.join();

}
}
