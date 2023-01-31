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
  Q_PROPERTY(double          time           READ    time           WRITE setTime     NOTIFY timeChanged)
  Q_PROPERTY(double          tut            READ    tut            WRITE setTut      NOTIFY tutChanged)

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
  double  time       () const {return time_         ;}
  double  tut        () const {return tut_          ;}


  void readFile(std::string file_name);
  public slots:
    QString createWorkout(QString user_id, QString workout_name, int number_of_session);
    void loadWorkout(QString user_id, QString workout_name);

    void next();

    void updateStatFile(QString id, QString workout_name, int time, int tut);
    void readStatFile(QString id);

    QVariant listSessionExercise(int session);
    void setScore(double score);
    void setTime(double time);
    void setTut(double tut);
    void setSession(int session);

    int getActiveSession(){return act_session_;}
    QVariant listSessionsNumber();

    double getSessionProgess(int session);
    double getSessionScore  (int session);
    double getSessionTime   (int session);
    double getSessionTut    (int session);
    QString getSessionTimeString   (int session);
    QString getSessionTutString    (int session);

    double getProgess();
    double getScore  ();
    QString getTime();

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
  void timeChanged();
  void tutChanged();
protected:

  bool            completed_     ;
  bool            end_session_   ;
  QString         code_          ;
  QString         image_         ;
  int             session_       ;
  int             act_session_   ;
  int             power_         ;
  int             reps_          ;
  int             rest_          ;
  int             rest_set_      ;
  int             sets_          ;
  double          score_         ;
  double          time_          ;
  double          tut_           ;
  QString         dir_path_      ;
  QString         workoutName_   ;
  int             idx_           ;
  std::string     file_name_     ;
  std::string     stat_file_name_;

  std::unique_ptr<rapidcsv::Document> doc_;
  std::unique_ptr<rapidcsv::Document> stat_doc_;

  void updateField();



};

}

#endif // QML_TCP_REC
