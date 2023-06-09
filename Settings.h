#ifndef SETTINIGS_____
#define SETTINIGS_____

#include <QObject>
#include <QString>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTranslator>
#include <memory>

class Settings : public QObject
{
  Q_OBJECT
public:
  explicit Settings(std::shared_ptr<QQmlApplicationEngine> engine,
                    std::shared_ptr<QGuiApplication> app,
                    std::shared_ptr<QTranslator> translator,
                    QString default_dict,
                    QObject *parent = nullptr);





public slots:
  bool setLanguage(QString dict);
protected:
  std::shared_ptr<QTranslator> translator_;
  std::shared_ptr<QQmlApplicationEngine> engine_;
  std::shared_ptr<QGuiApplication> app_;
};


#endif // SETTINIGS_____
