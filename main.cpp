#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QQuickView>
#include <QStringListModel>
#include <QQmlEngine>
#include <QQmlContext>
#include <QQmlComponent>
#include "ListaEsercizi.h"
#include "ListaZone.h"

int main(int argc, char *argv[])
{
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

  QGuiApplication app(argc, argv);

  QSurfaceFormat format;
  format.setSamples(8);
  QSurfaceFormat::setDefaultFormat(format);

  std::string file_path = __FILE__;
  std::string dir_path = file_path.substr(0, file_path.rfind("/"));
  QString cpp_path=QString::fromStdString(dir_path);

  ListaEsercizi model;
  ListaZona zone;

  QQmlApplicationEngine engine;
  const QUrl url(QStringLiteral("qrc:/main.qml"));

  QQmlContext *context = engine.rootContext();
  context->setContextProperty("_myModel", &model);
  context->setContextProperty("_zona", &zone);
  engine.rootContext()->setContextProperty("PATH", cpp_path);

  QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                   &app, [url](QObject *obj, const QUrl &objUrl) {
    if (!obj && url == objUrl)
      QCoreApplication::exit(-1);
  }, Qt::QueuedConnection);
  engine.load(url);

  return app.exec();
}
