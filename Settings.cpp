#include "Settings.h"
#include <QDebug>

Settings::Settings(std::shared_ptr<QQmlApplicationEngine> engine,
                   std::shared_ptr<QGuiApplication> app,
                   std::shared_ptr<QTranslator> translator,
                   QString default_dict,
                   QObject *parent)
  : QObject(parent)
{
  engine_=engine;
  app_=app;
  translator_=translator;
  setLanguage(default_dict);
}

bool Settings::setLanguage(QString dict)
{

    if (app_->removeTranslator(translator_.get()))
    {
      qDebug() << "unable to remove translation";
    }
    if (!translator_->load(dict))
    {
      qDebug() << "unable to load translation";
      return  false;
    }

    if (!app_->installTranslator(translator_.get()))
    {
      qDebug() << "unable to install translation";
      return  false;
    }
    engine_->retranslate();
    qDebug() << "change  translation to " <<dict;
    return true;
}

