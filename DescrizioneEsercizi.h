#ifndef QML_ESERCIZIO
#define QML_ESERCIZIO

#include <QObject>
#include <QString>
#include <QVector>
#include <rapidcsv.h>
#include <memory>

namespace abh {
class DescrizioneEsercizi : public QObject
{
  Q_OBJECT
  Q_PROPERTY(QString         name                MEMBER name                 WRITE setName()  NOTIFY nameChanged               )
  Q_PROPERTY(QString         code                MEMBER code                 NOTIFY codeChanged               )
  Q_PROPERTY(QString         image               MEMBER image                NOTIFY imageChanged              )
  Q_PROPERTY(QString         video_intro         MEMBER video_intro          NOTIFY video_introChanged        )
  Q_PROPERTY(QString         video_preparazione  MEMBER video_preparazione   NOTIFY video_preparazioneChanged )
  Q_PROPERTY(QString         video_workout       MEMBER video_workout        NOTIFY video_workoutChanged      )

public:
  explicit DescrizioneEsercizi(QObject *parent = nullptr);

  void setName(QString new_name);

  void setPath(QString& path){dir_path_=path;readFile();}
public slots:
  void readFile();

  QString getImage(QString nome);
  QString getCode(QString nome);
  QString getVideoIntro(QString nome);
  QString getVideoPrep(QString nome);
  QString getVideoWorkout(QString nome);

signals:
  void nameChanged()              ;
  void codeChanged()              ;
  void imageChanged()             ;
  void video_introChanged()       ;
  void video_preparazioneChanged();
  void video_workoutChanged()     ;
protected:

  QString         name               ;
  QString         image              ;
  QString         code               ;
  QString         video_intro        ;
  QString         video_preparazione ;
  QString         video_workout      ;

  QString dir_path_;
  std::unique_ptr<rapidcsv::Document> doc_;

  QString getInfo(QString nome,std::string field);
};

}

#endif // QML_TCP_REC
