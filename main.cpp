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
#include "ChiamataSistema.h"

#include <listwifi.h>


int main(int argc, char *argv[])
{




  qmlRegisterType<UdpCom::StringReceiver>("StringReceiver", 1, 0, "StringReceiver");
  qmlRegisterType<UdpCom::StringSender>  ("StringSender",   1, 0, "StringSender");
  qmlRegisterType<UdpCom::BinaryReceiver>("BinaryReceiver", 1, 0, "BinaryReceiver");
  qmlRegisterType<UdpCom::BinarySender>  ("BinarySender",   1, 0, "BinarySender");
  qmlRegisterType<UdpCom::UdpVideoStream>("UdpVideoStream", 1, 0, "UdpVideoStream");
  qmlRegisterType<AreaChart>("Charts",1,0,"AreaChart");
  qmlRegisterType<SysCall>("SysCall",1,0,"SysCall");
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

  ListaEsercizi model(data_path);
  ListaZona zone(data_path+"/zone");
  ListaZona workout_list(data_path+"/allenamento_programmato");
  ListaUtenti utenti(data_path+"/utenti");
  abh::ProgrammaAllenamento workout(data_path+"/allenamento_programmato");
  abh::DescrizioneEsercizi esercizi(data_path);

  ListaWifi wifi;

  zone.readFile("Zone");
  workout_list.readFile("lista_workout");
  workout.readFile("workout1_facile_1");


  std::shared_ptr<QGuiApplication> app=std::make_shared<QGuiApplication>(argc, argv);
  std::shared_ptr<QQmlApplicationEngine> engine=std::make_shared<QQmlApplicationEngine>();



  QQmlContext *context = engine->rootContext();
  context->setContextProperty("_myModel", &model);
  context->setContextProperty("_workout_list", &workout_list);
  context->setContextProperty("_utenti", &utenti);
  context->setContextProperty("_zona", &zone);
  context->setContextProperty("_fullscreen", fs);
  context->setContextProperty("_esercizi",&esercizi);
  context->setContextProperty("_workout", &workout);
  context->setContextProperty("_wifi", &wifi);
  engine->rootContext()->setContextProperty("PATH", data_path);


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
