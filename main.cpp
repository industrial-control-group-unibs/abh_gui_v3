#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QmlStringUdpReceiver.h>
#include <QmlStringUdpSender.h>
#include <QmlBinaryUdpReceiver.h>
#include <QmlBinaryUdpSender.h>
#include <QQuickView>
#include <QStringListModel>
#include <QQmlEngine>
#include <QQmlContext>
#include <QQmlComponent>

#include <UdpVideoStream.h>

#include "ListaEsercizi.h"
#include "ListaZone.h"
#include "ListaUtenti.h"
#include "ProgrammaAllenamento.h"
#include "DescrizioneEsercizi.h"
#include <iostream>


int main(int argc, char *argv[])
{
  qmlRegisterType<UdpCom::StringReceiver>("StringReceiver", 1, 0, "StringReceiver");
  qmlRegisterType<UdpCom::StringSender>  ("StringSender",   1, 0, "StringSender");
  qmlRegisterType<UdpCom::BinaryReceiver>("BinaryReceiver", 1, 0, "BinaryReceiver");
  qmlRegisterType<UdpCom::BinarySender>  ("BinarySender",   1, 0, "BinarySender");
  qmlRegisterType<UdpCom::UdpVideoStream>("UdpVideoStream", 1, 0, "UdpVideoStream");
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

  std::string Username = getlogin();
  std::cout << Username << std::endl;

  QSurfaceFormat format;
  format.setSamples(8);
  QSurfaceFormat::setDefaultFormat(format);

  std::string file_path = __FILE__;
  std::string dir_path = file_path.substr(0, file_path.rfind("/"));
  QString cpp_path=QString::fromStdString(dir_path);

  ListaEsercizi model;
  ListaZona zone;
  ListaZona workout_list;
  workout_list.readFile("lista_workout");
  ListaUtenti utenti;




  abh::ProgrammaAllenamento workout;
  workout.setPath(cpp_path);
  workout.readFile("workout1_facile_1");


  std::shared_ptr<QGuiApplication> app=std::make_shared<QGuiApplication>(argc, argv);
  std::shared_ptr<QQmlApplicationEngine> engine=std::make_shared<QQmlApplicationEngine>();

  QQmlContext *context = engine->rootContext();
  context->setContextProperty("_myModel", &model);
  context->setContextProperty("_workout_list", &workout_list);
  context->setContextProperty("_utenti", &utenti);
  context->setContextProperty("_zona", &zone);

  bool fs=true;
  if (!Username.compare("abhorizon"))
  {
  }
  else
  {
    fs=false;
  }
  context->setContextProperty("_fullscreen", fs);

//  UdpCom::BinaryReceiver rec;
//  rec.setName("ricevitore");
//  rec.setSize(3);
//  rec.setData({0.0,0.0,0.0});
//  rec.setPort("15005");
//  context->setContextProperty("_rec_udp", &rec);

  context->setContextProperty("_workout", &workout);
  engine->rootContext()->setContextProperty("PATH", cpp_path);

  abh::DescrizioneEsercizi esercizi;
  esercizi.setPath(cpp_path);
  context->setContextProperty("_esercizi",&esercizi);

  const QUrl url(QStringLiteral("qrc:/main.qml"));
  QObject::connect(&(*engine), &QQmlApplicationEngine::objectCreated,
                   &(*app), [url](QObject *obj, const QUrl &objUrl) {
    if (!obj && url == objUrl)
      QCoreApplication::exit(-1);
  }, Qt::QueuedConnection);
  engine->load(url);

  int output=app->exec();
  engine.reset();
  std::cout << "exit" << std::endl;
  return output;
}
