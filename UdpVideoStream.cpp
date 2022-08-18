#include <UdpVideoStream.h>
#include <QDebug>

#define BUF_LEN 65536 // Larger than maximum UDP packet size


namespace UdpCom
{
UdpVideoStream::UdpVideoStream(QObject *parent)
  : QObject(parent), mVideoSurface(nullptr), mSurfaceFormat(nullptr)
{
  mTimer.setInterval(30);
  connect(&mTimer, &QTimer::timeout, this, &UdpVideoStream::slotTick);
  thread_=std::thread(&UdpVideoStream::receiverThread,this);
}

UdpVideoStream::~UdpVideoStream()
{
  stop_flag_=true;
  std::cout << "udp video stream exiting" << std::endl;

  if (thread_.joinable())
    thread_.join();
  std::cout << "udp video stream exit" << std::endl;

}

QAbstractVideoSurface *UdpVideoStream::videoSurface() const
{
  return mVideoSurface;
}


QString UdpVideoStream::port() const
{
  return port_;
}
void UdpVideoStream::setPort(QString port)
{
  port_=port;
  emit portChanged();
}

void UdpVideoStream::setVideoSurface(QAbstractVideoSurface *videoSurface)
{
  if(videoSurface != mVideoSurface)
  {
    mVideoSurface = videoSurface;
    emit signalVideoSurfaceChanged();
    startSurface();

    mTimer.start();
  }

}

void UdpVideoStream::slotTick()
{
 if (mImage && m_started)
  {
    m_mtx.lock();
    QVideoFrame frame(*mImage);
    m_mtx.unlock();
    if (not mVideoSurface->present(frame))
        std::cerr << "errore nel frame" <<std::endl;
    ;
  }
}



void UdpVideoStream::startSurface()
{
  if (mImage and mVideoSurface)
  {
    std::cout << "startSurface" << std::endl;


    auto pixelFormat = QVideoFrame::pixelFormatFromImageFormat(mImage->format());
    std::cout << "*" << std::endl;
    mSurfaceFormat = new QVideoSurfaceFormat(mImage->size(), pixelFormat);
    std::cout << "*" << std::endl;

    if (not mVideoSurface->isFormatSupported(*mSurfaceFormat))
    {
      std::cout << "*" << std::endl;
      std::cerr << "Surface do not support format"  << std::endl;
      QVideoSurfaceFormat* new_format = new QVideoSurfaceFormat(mVideoSurface->nearestFormat(*mSurfaceFormat));
      if (not mVideoSurface->isFormatSupported(*new_format))
      {
        std::cerr << "Surface do not support also this format"  << std::endl;
      }

    }

    if(!mVideoSurface->start(*mSurfaceFormat))
    {
      std::cerr << "Surface couldn't be started! error = " << mVideoSurface->error() << std::endl;
      m_started=false;;
    }
    else
    {
      std::cout << "surface started" << std::endl;
      m_started=true;
    }
  }
  else
    m_started=false;

}

void UdpVideoStream::updateFrame(cv::Mat& frame)
{
  QImage image;
  image = QImage(frame.data,
                   frame.cols,
                   frame.rows,
                   frame.step,
                   QImage::Format_RGB888);
  image = image.rgbSwapped();
  m_mtx.lock();
  delete mImage;
  mImage=new QImage(image.convertToFormat(QImage::Format_RGB32));
  m_mtx.unlock();
  if (not m_started)
    startSurface();

}

void UdpVideoStream::receiverThread()
{
  int servPort=port_.toInt();
  try {
    UDPSocket sock(servPort);

    std::vector<char> buffer;
    buffer.resize(BUF_LEN); // Buffer for echo string
    int recv_msg_size; // Size of received message
    std::string source_address; // Address of datagram source
    unsigned short source_port; // Port of datagram source

    std::vector<char> dat;
    int total_pack=0;
    cv::Mat raw_data;
    cv::Mat frame;

    while (1) {
      if (stop_flag_)
      {
        std::cout << "exit receiverThread"<<std::endl;
        return;
      }
      // Block until receive message from a client

      recv_msg_size = sock.recvFrom(buffer.data(), BUF_LEN, source_address, source_port);


      dat.insert(dat.end(), (buffer.begin()+1), (buffer.begin()+recv_msg_size));
      if (int(buffer[0])==1)
      {
        raw_data = cv::Mat(1, dat.size() , CV_8UC1, dat.data());
        frame = imdecode(raw_data, cv::IMREAD_COLOR);
        if (frame.size().width == 0) {
          std::cerr << "decode failure!" << std::endl;
          continue;
        }
        this->updateFrame(frame);
        emit signalVideoSurfaceChanged();
        total_pack=dat.size();
        dat.clear();
      }
    }
  } catch (SocketException & e) {
    std::cerr << e.what() << std::endl;
    exit(1);
  }
}
}
