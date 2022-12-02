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
  Q_PROPERTY(bool            completed      READ    completed                        NOTIFY completedChanged)
  Q_PROPERTY(bool            endSession     READ    endSession                       NOTIFY endSessionChanged)
  Q_PROPERTY(QString         code           READ    code                             NOTIFY codeChanged)
  Q_PROPERTY(QString         image          READ    image                            NOTIFY imageChanged)
  Q_PROPERTY(int             power          READ    power                            NOTIFY powerChanged)
  Q_PROPERTY(int             reps           READ    reps                             NOTIFY repsChanged)
  Q_PROPERTY(int             rest           READ    rest                             NOTIFY restChanged)
  Q_PROPERTY(int             restSet        READ    restSet                          NOTIFY restSetChanged)
  Q_PROPERTY(int             sets           READ    sets                             NOTIFY setsChanged)
  Q_PROPERTY(int             session        READ    session                          NOTIFY sessionChanged)
  Q_PROPERTY(int             actSession     READ    actSession     WRITE setSession  NOTIFY actSessionChanged)
  Q_PROPERTY(QString         dir_path       MEMBER  dir_path_                        NOTIFY dirPathChanged)
  Q_PROPERTY(QString         workoutName    MEMBER  workoutName_                     NOTIFY workoutNameChanged)
  Q_PROPERTY(double          score          READ    score          WRITE setScore    NOTIFY scoreChanged)

public:
  explicit ProgrammaAllenamento(QString path, QObject *parent = nullptr);
//  virtual ~ProgrammaAllenamento();

  bool    completed  () const {return completed_    ;}
  bool    endSession () const {return end_session_  ;}
  QString code       () const {return code_         ;}
  QString image      () const {return image_        ;}
  int     power      () const {return power_        ;}
  int     reps       () const {return reps_         ;}
  int     rest       () const {return rest_         ;}
  int     restSet    () const {return rest_set_     ;}
  int     sets       () const {return sets_         ;}
  int     session    () const {return session_      ;}
  int     actSession () const {return act_session_  ;}
  double  score      () const {return score_        ;}

  void setScore(double score);
  void setSession(int session);

  void readFile(std::string file_name);
  public slots:
    void createWorkout(QString user_id, QString workout_name, int number_of_session);

    void next();

signals:
  void completedChanged();
  void endSessionChanged();
  void codeChanged();
  void imageChanged();
  void powerChanged();
  void repsChanged();
  void restChanged();
  void restSetChanged();
  void setsChanged();
  void sessionChanged();
  void scoreChanged();
  void dirPathChanged();
  void workoutNameChanged();
  void actSessionChanged();
protected:

  bool            completed_    ;
  bool            end_session_  ;
  QString         code_         ;
  QString         image_        ;
  int             session_      ;
  int             act_session_  ;
  int             power_        ;
  int             reps_         ;
  int             rest_         ;
  int             rest_set_         ;
  int             sets_         ;
  double          score_        ;
  QString         dir_path_     ;
  QString         workoutName_;
  int             idx_;
  std::string     file_name_;

  std::unique_ptr<rapidcsv::Document> doc_;

  void updateField();
};

}

#endif // QML_TCP_REC
