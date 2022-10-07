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

#include "areachart.h"


int main(int argc, char *argv[])
{
  qmlRegisterType<UdpCom::StringReceiver>("StringReceiver", 1, 0, "StringReceiver");
  qmlRegisterType<UdpCom::StringSender>  ("StringSender",   1, 0, "StringSender");
  qmlRegisterType<UdpCom::BinaryReceiver>("BinaryReceiver", 1, 0, "BinaryReceiver");
  qmlRegisterType<UdpCom::BinarySender>  ("BinarySender",   1, 0, "BinarySender");
  qmlRegisterType<UdpCom::UdpVideoStream>("UdpVideoStream", 1, 0, "UdpVideoStream");
  qmlRegisterType<AreaChart>("Charts",1,0,"AreaChart");
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

  std::string Username = getlogin();
  std::cout << Username << std::endl;
  bool fs=true;
  if (!Username.compare("abhorizon"))
  {

  }
  else
  {

    fs=false;
  }

  QSurfaceFormat format;
  format.setSamples(8);
  QSurfaceFormat::setDefaultFormat(format);

  std::string dir_path;

  if (fs)
  {
    dir_path="/home/abhorizon/Scrivania/abh_data";
  }
  else
  {
    dir_path="/home/jacobi/projects/abh_data";
  }

  QString data_path=QString::fromStdString(dir_path);

std::cout << "a" <<std::endl;
  ListaEsercizi model(data_path);
  std::cout << "b" <<std::endl;
  ListaZona zone(data_path+"/zone");
  std::cout << "c" <<std::endl;
  ListaZona workout_list(data_path+"/allenamento_programmato");
  std::cout << "d" <<std::endl;
  ListaUtenti utenti(data_path+"/utenti");
  std::cout << "e" <<std::endl;
  abh::ProgrammaAllenamento workout(data_path+"/allenamento_programmato");
  std::cout << "f" <<std::endl;
  abh::DescrizioneEsercizi esercizi(data_path);
  std::cout << "g" <<std::endl;

  std::cout << __LINE__ <<std::endl;
  zone.readFile("Zone");
  std::cout << __LINE__ <<std::endl;
  workout_list.readFile("lista_workout");
  std::cout << __LINE__ <<std::endl;
  workout.readFile("workout1_facile_1");
  std::cout << __LINE__ <<std::endl;


  std::shared_ptr<QGuiApplication> app=std::make_shared<QGuiApplication>(argc, argv);
  std::shared_ptr<QQmlApplicationEngine> engine=std::make_shared<QQmlApplicationEngine>();



  QQmlContext *context = engine->rootContext();
  std::cout << __LINE__ <<std::endl;
  context->setContextProperty("_myModel", &model);
  context->setContextProperty("_workout_list", &workout_list);
  context->setContextProperty("_utenti", &utenti);
  context->setContextProperty("_zona", &zone);
  context->setContextProperty("_fullscreen", fs);
  context->setContextProperty("_esercizi",&esercizi);
  std::cout << __LINE__ <<std::endl;

  context->setContextProperty("_workout", &workout);
  std::cout << __LINE__ <<std::endl;
  engine->rootContext()->setContextProperty("PATH", data_path);
  std::cout << __LINE__ <<std::endl;


  const QUrl url(QStringLiteral("qrc:/main.qml"));
  std::cout << __LINE__ <<std::endl;
  QObject::connect(&(*engine), &QQmlApplicationEngine::objectCreated,
                   &(*app), [url](QObject *obj, const QUrl &objUrl) {
    if (!obj && url == objUrl)
      QCoreApplication::exit(-1);
  }, Qt::QueuedConnection);
  std::cout << __LINE__ <<std::endl;
  engine->load(url);
  std::cout << __LINE__ <<std::endl;

  std::cout << __LINE__ <<std::endl;
  int output=app->exec();
  std::cout << __LINE__ <<std::endl;
  engine.reset();
  std::cout << "exit" << std::endl;
  return output;
}
