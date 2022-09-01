#ifndef QML_PROGRAMMA_ALLENAMENTO
#define QML_PROGRAMMA_ALLENAMENTO

#include <QObject>
#include <QString>
#include <QVector>
#include <UdpSocketHelperCpp/udp_binary_sockets.h>


#include <rapidcsv.h>


namespace abh {
class ProgrammaAllenamento : public QObject
{
  Q_OBJECT
  Q_PROPERTY(bool            completed      READ    completed      NOTIFY completedChanged)
  Q_PROPERTY(QString         name           READ    name           NOTIFY nameChanged)
  Q_PROPERTY(QString         image          READ    image          NOTIFY imageChanged)
  Q_PROPERTY(int             power          READ    power          NOTIFY powerChanged)
  Q_PROPERTY(int             reps           READ    reps           NOTIFY repsChanged)
  Q_PROPERTY(int             rest           READ    rest           NOTIFY restChanged)
  Q_PROPERTY(int             sets           READ    sets           NOTIFY setsChanged)
  Q_PROPERTY(double          maxPosSpeed    READ    maxPosSpeed    NOTIFY maxPosSpeedChanged)
  Q_PROPERTY(double          maxNegSpeed    READ    maxNegSpeed    NOTIFY maxNegSpeedChanged)
  Q_PROPERTY(QString         dir_path       MEMBER  dir_path_      NOTIFY dirPathChanged)
  Q_PROPERTY(QString         workoutName    MEMBER  workoutName_   NOTIFY workoutNameChanged   )

public:
  explicit ProgrammaAllenamento(QString path, QObject *parent = nullptr);
//  virtual ~ProgrammaAllenamento();

  bool    completed  () const {return completed_    ;}
  QString name       () const {return name_         ;}
  QString image      () const {return image_        ;}
  int     power      () const {return power_        ;}
  int     reps       () const {return reps_         ;}
  int     rest       () const {return rest_         ;}
  int     sets       () const {return sets_         ;}
  double  maxPosSpeed() const {return maxPosSpeed_  ;}
  double  maxNegSpeed() const {return maxNegSpeed_  ;}

  public slots:
    void readFile(QString string);
    void next();
signals:
  void completedChanged();
  void nameChanged();
  void imageChanged();
  void powerChanged();
  void repsChanged();
  void restChanged();
  void setsChanged();
  void maxPosSpeedChanged();
  void maxNegSpeedChanged();
  void dirPathChanged();
  void workoutNameChanged();
protected:

  bool            completed_    ;
  QString         name_         ;
  QString         image_        ;
  int             power_        ;
  int             reps_         ;
  int             rest_         ;
  int             sets_         ;
  double          maxPosSpeed_  ;
  double          maxNegSpeed_  ;
  QString         dir_path_     ;
  QString         workoutName_;
  int idx;


  std::unique_ptr<rapidcsv::Document> doc_;

  void updateField();
};

}

#endif // QML_TCP_REC
