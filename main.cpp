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

#include "ListaNome.h"
#include "ListaImmagini.h"
#include "ListaUtenti.h"
#include "ListStringCSV.h"
#include "Settings.h"
#include "ProgrammaAllenamento.h"
#include "DescrizioneEsercizi.h"
#include <iostream>

#include "areachart.h"
#include "statchart.h"
#include "ChiamataSistema.h"

#include <listwifi.h>
#include <stringquee.h>

#include <rapidcsv.h>
#include <rapidcsv.h>

#include <QTranslator>

#include <ListUserConfig.h>


std::string exec(const char* cmd) {
    std::array<char, 128> buffer;
    std::string result;
    std::unique_ptr<FILE, decltype(&pclose)> pipe(popen(cmd, "r"), pclose);
    if (!pipe) {
        throw std::runtime_error("popen() failed!");
    }
    while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
        result += buffer.data();
    }
    return result;
}

int main(int argc, char *argv[])
{
 std::string prev_loc = std::setlocale(LC_ALL, nullptr);




  qmlRegisterType<UdpCom::StringReceiver>("StringReceiver", 1, 0, "StringReceiver");
  qmlRegisterType<UdpCom::StringSender>  ("StringSender",   1, 0, "StringSender");
  qmlRegisterType<UdpCom::BinaryReceiver>("BinaryReceiver", 1, 0, "BinaryReceiver");
  qmlRegisterType<UdpCom::BinarySender>  ("BinarySender",   1, 0, "BinarySender");
  qmlRegisterType<UdpCom::UdpVideoStream>("UdpVideoStream", 1, 0, "UdpVideoStream");
  qmlRegisterType<AreaChart>("Charts",1,0,"AreaChart");
  qmlRegisterType<StatChart>("Charts",1,0,"StatChart");
  qmlRegisterType<SysCall>("SysCall",1,0,"SysCall");
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

  std::string Username = getlogin();
  bool fs=true;
  if (!Username.compare("jacobi"))
  {
    fs=false;
  }

  QSurfaceFormat format;
  format.setSamples(4);
  QSurfaceFormat::setDefaultFormat(format);

  std::string dir_path;
  std::string template_path;





  if (fs)
  {
    dir_path="/home/"+Username+"/Scrivania/abh/abh_data";
    template_path="/home/"+Username+"/Scrivania/abh/abh_data/template";
  }
  else
  {
    dir_path="/home/jacobi/projects/abh/abh_data";
    template_path="/home/jacobi/projects/abh/abh_gui_v3/template";
  }

  QString q_template_path=QString::fromStdString(template_path);

  QString data_path=QString::fromStdString(dir_path);

  ListaNome model(data_path);
  ListString ls;
  ListaImmagini zone(data_path+"/zone");

  ListaUtenti utenti(data_path+"/../utenti",
                     template_path);

  ListUserConfig user_config(data_path+"/../utenti");
  user_config.readFile("user_config");

  abh::ProgrammaAllenamento workout(data_path+"/../utenti",
                                    data_path+"/allenamento_programmato",
                                    template_path);

  abh::DescrizioneEsercizi esercizi(data_path);

  StringQuee queue;

  ListStringCSV active_workouts(data_path+"/../utenti");
  active_workouts.appendIcon(true);

  ListStringCSV custom_workouts(data_path+"/../utenti");
  custom_workouts.appendIcon(true);

  ListStringCSV custom_sessions(data_path+"/../utenti");
  custom_sessions.appendIcon(true);


  UdpCom::UdpVideoStream udpStream;
  udpStream.setPort("5000");

  ListStringCSV workout_list(data_path+"/allenamento_programmato");

  ListStringCSV dati_list(data_path);

  std::string coloreBordo="#c6aa76";
  std::string coloreSfondo="#2A211B";
  std::string coloreUtente="#8c177b";
  std::string coloreLed="#8c177b";

  std::string coloreLedEsercizioInizio="#ff0000";
  std::string coloreLedEsercizioFine="#00ff00";
  std::string coloreLedPausa="#ffff00";
  std::string coloreLedFinePausa="#ff0000";

  std::string pausaRiposo="30";
  std::string wifi_name="";
  std::string monitor;
  std::string touch;

  double score_min,score_max;

  try {
    rapidcsv::Document info(dir_path+"/../utenti/device_names.csv");
    wifi_name=info.GetCell<std::string>(1,0);
    monitor=info.GetCell<std::string>(1,1);
    touch=info.GetCell<std::string>(1,2);
  } catch (std::exception ex) {
    std::cerr << "error:" << ex.what() <<std::endl;
    std::cerr << "file " << dir_path <<"/../utenti/device_names.csv is wrong, it should have 3 rows" << std::endl;
    return 0;
  }



  try {
    rapidcsv::Document doc(dir_path+"/default.csv");
    coloreBordo=doc.GetCell<std::string>(1,0);
    coloreSfondo=doc.GetCell<std::string>(1,1);
    coloreUtente=doc.GetCell<std::string>(1,2);
    coloreLed=doc.GetCell<std::string>(1,3);

    coloreLedEsercizioInizio=doc.GetCell<std::string>(1,4);
    coloreLedEsercizioFine=doc.GetCell<std::string>(1,5);
    coloreLedPausa=doc.GetCell<std::string>(1,6);
    coloreLedFinePausa=doc.GetCell<std::string>(1,7);

    pausaRiposo=doc.GetCell<std::string>(1,8);
    score_min=doc.GetCell<double>(1,9);
    score_max=doc.GetCell<double>(1,10);


  } catch (std::exception ex) {
    std::cerr << "error:" << ex.what() <<std::endl;
    std::cerr << "file " << dir_path <<"/default.csv is wrong, it should have 12 rows" << std::endl;
    return 0;
  }

  std::system(("xrandr --output "+monitor+" --auto").c_str());


  workout.setThresholds(score_min,score_max);
  QStringList default_values;
  default_values.push_back(QString().fromStdString(coloreBordo             )); // 0
  default_values.push_back(QString().fromStdString(coloreSfondo            )); // 1
  default_values.push_back(QString().fromStdString(coloreUtente            )); // 2
  default_values.push_back(QString().fromStdString(coloreLed               )); // 3

  default_values.push_back(QString().fromStdString(coloreLedEsercizioInizio)); // 4
  default_values.push_back(QString().fromStdString(coloreLedEsercizioFine  )); // 5
  default_values.push_back(QString().fromStdString(coloreLedPausa          )); // 6
  default_values.push_back(QString().fromStdString(coloreLedFinePausa      )); // 7

  default_values.push_back(QString().fromStdString(pausaRiposo             )); // 8
  default_values.push_back(QString().fromStdString(wifi_name               )); // 9
  default_values.push_back(QString().fromStdString(monitor                 )); // 10
  default_values.push_back(QString().fromStdString(touch                   )); // 11

  utenti.setDefaultColor(default_values);



  ListaWifi wifi;
  ListStringCSV wifi2(data_path+"/../utenti");
  wifi2.appendIcon(false);

  zone.readFile("Zone");
  workout_list.readFile("lista_workout");
//  workout.readFile("workout1_level_1");


  std::shared_ptr<QGuiApplication> app=std::make_shared<QGuiApplication>(argc, argv);
  std::shared_ptr<QTranslator> translator=std::make_shared<QTranslator>();
  //if (!translator->load("abh_en",QString().fromStdString(dir_path)+"/traduzioni/"))
  if (!translator->load("abh_it"))
    std::cerr << "unable to load translation" << std::endl;
  if (!app->installTranslator(translator.get()))
    std::cerr << "unable to install translation" << std::endl;

  std::shared_ptr<QQmlApplicationEngine> engine=std::make_shared<QQmlApplicationEngine>();

  Settings settings(engine,app,translator,"abh_it");

//  engine->retranslate();


  std::string str;
  std::ifstream inFile;
  inFile.open(dir_path+"/privacy.txt"); //open the input file
  if ( inFile.fail() )
  {
    str="file "+dir_path+"/privacy.txt mancante";
  }
  else
  {
    std::stringstream strStream;
    strStream << inFile.rdbuf(); //read the file
    str = strStream.str(); //str holds the content of the file
  }
  QString privacy=QString::fromStdString(str);

  std::ifstream inFile2;
  inFile2.open(dir_path+"/info.txt"); //open the input file
  if ( inFile2.fail() )
  {
    str="file "+dir_path+"/info.txt mancante";
  }
  else
  {
    std::stringstream strStream;
    strStream << inFile2.rdbuf(); //read the file
    str = strStream.str(); //str holds the content of the file
  }
  QString info=QString::fromStdString(str);

  StringQuee page_history;

  QQmlContext *context = engine->rootContext();
  context->setContextProperty("_myModel", &model);
  context->setContextProperty("_list_string", &ls);
  context->setContextProperty("_workout_list", &workout_list);
  context->setContextProperty("_utenti", &utenti);
  context->setContextProperty("_zona", &zone);
  context->setContextProperty("_fullscreen", fs);
  context->setContextProperty("_esercizi",&esercizi);
  context->setContextProperty("_workout", &workout);
  context->setContextProperty("_wifi", &wifi2);
  context->setContextProperty("_queue", &queue);
  context->setContextProperty("_history", &page_history);
  context->setContextProperty("_active_workouts", &active_workouts);
  context->setContextProperty("_custom_workouts", &custom_workouts);
  context->setContextProperty("_custom_sessions", &custom_sessions);
  context->setContextProperty("_settings", &settings);
  context->setContextProperty("udpStream", &udpStream);
  context->setContextProperty("_user_config", &user_config);



  context->setContextProperty("_default", default_values);

  engine->rootContext()->setContextProperty("PATH", data_path);
  engine->rootContext()->setContextProperty("_template_path", q_template_path);
  engine->rootContext()->setContextProperty("_privacy", privacy);
  engine->rootContext()->setContextProperty("_info", info);



  const QUrl url(QStringLiteral("qrc:/main.qml"));
  QObject::connect(&(*engine), &QQmlApplicationEngine::objectCreated,
                   &(*app), [url](QObject *obj, const QUrl &objUrl) {
    if (!obj && url == objUrl)
      QCoreApplication::exit(-1);
  }, Qt::QueuedConnection);
  engine->load(url);

  int output;
  std::cout << "running gui";
  try {
    output=app->exec();
  } catch (std::exception ex) {
    std::cout << "exception: "<<ex.what();
  }

  std::cout << "exiting gui";

  engine.reset();
  std::cout << "exit" << std::endl;
  return output;
}
