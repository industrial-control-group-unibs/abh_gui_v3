#include <ProgrammaAllenamento.h>
#include <QDebug>
#include <iostream>
#include <ctime>
#include "ListStringQueue.h"

namespace abh {

ProgrammaAllenamento::ProgrammaAllenamento(QString path,
                                           std::string template_path,
                                           QObject* /*parent*/)
{
  dir_path_=path;
  completed_=true;
  end_workout_=false;
  end_session_=false;
  act_session_=1;
  template_path_=template_path;
}

void ProgrammaAllenamento::readFile(std::string file_name)
{


  try {
    doc_.reset(new rapidcsv::Document(file_name));
    if (isEmpty())
        return;
    act_session_=1;
    idx_=0;

    completed_=false;
    end_session_=false;
    updateField();


    std::vector<int> session = doc_->GetColumn<int>("session");
    std::vector<int> score = doc_->GetColumn<int>("score");

    end_workout_=true;
    for (size_t idx=0;idx<session.size();idx++)
    {
      if (score.at(idx)<0)
      {
        act_session_=session.at(idx);
        end_workout_=false;
        idx_=idx;
        break;
      }
    }
    updateField();
  }
  catch (...)
  {
    std::cerr<< "file does not exist :"<<file_name<<std::endl;

  }
  //setSession(act_session_);
}

void ProgrammaAllenamento::updateField()
{
  code_=QString::fromStdString(doc_->GetCell<std::string>(0,idx_));
  power_=doc_->GetCell<int>(1,idx_);
  reps_= doc_->GetCell<int>(2,idx_);
  sets_= doc_->GetCell<int>(3,idx_);
  rest_= doc_->GetCell<int>(4,idx_);
  rest_set_= doc_->GetCell<int>(5,idx_);
  session_= doc_->GetCell<int>(6,idx_);
  score_= QString().fromStdString(doc_->GetCell<std::string>(7,idx_)).toDouble();
}

void ProgrammaAllenamento::setScore(double score)
{
  doc_->SetCell(7,idx_,score);
  score_=score;
  doc_->Save(file_name_);
}

void ProgrammaAllenamento::setTime(double time)
{
  doc_->SetCell(8,idx_,time);
  time_=time;
  doc_->Save(file_name_);
}
void ProgrammaAllenamento::setTut(double tut)
{
  doc_->SetCell(9,idx_,tut);
  tut_=tut;
  doc_->Save(file_name_);
}

void ProgrammaAllenamento::next()
{
  idx_++;
  if (idx_>=(int)doc_->GetRowCount())
  {
    idx_=0;
    completed_=true;
    end_session_=true;
    end_workout_=true;
  }
  else
  {
    updateField();
    end_session_=session_>act_session_;
  }
}

int ProgrammaAllenamento::getValue(int session, int index, QString field)
{
  int idx=0;
  bool found=false;
  for (;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<int>(6,idx);
    if (s==session)
    {
      found=true;
      break;
    }
  }
  if (!found)
  {
    qDebug() << " session not found";
    return -100;
  }
  int idx2=idx+index;
  if (idx2>=(int)doc_->GetRowCount())
  {
    qDebug() << " index is too big";
    return -100;
  }

  int s= doc_->GetCell<int>(6,idx2);
  if (s!=session)
  {
    qDebug() << " index is too big";
    return  -100;
  }

  int value= doc_->GetCell<int>(field.toStdString(),idx2);
  return value;

}

bool ProgrammaAllenamento::isEmpty()
{
  return doc_->GetRowCount()==0;
}

void ProgrammaAllenamento::setValue(int session, int index, QString field, int value)
{
  int idx=0;
  bool found=false;
  for (;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<int>(6,idx);
    if (s==session)
    {
      found=true;
      break;
    }
  }
  if (!found)
  {
    qDebug() << " session not found";
  }
  int idx2=idx+index;
  if (idx2>=(int)doc_->GetRowCount())
  {
    qDebug() << " index is too big";
  }

  int s= doc_->GetCell<int>(6,idx2);
  if (s!=session)
  {
    qDebug() << " index is too big";
  }

  const ssize_t columnIdx = doc_->GetColumnIdx(field.toStdString());

  doc_->SetCell<int>(columnIdx,idx2,value);
  qDebug()<< " colonna" << field << " value = "<< value;
  doc_->Save(file_name_);
}

void ProgrammaAllenamento::removeRow(int session, int index)
{
  int idx=0;
  bool found=false;
  for (;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<int>(6,idx);
    if (s==session)
    {
      found=true;
      break;
    }
  }
  if (!found)
  {
    qDebug() << " session not found";
  }
  int idx2=idx+index;
  if (idx2>=(int)doc_->GetRowCount())
  {
    qDebug() << " index is too big";
  }

  int s= doc_->GetCell<int>(6,idx2);
  if (s!=session)
  {
    qDebug() << " index is too big";
  }

  doc_->RemoveRow(idx2);
  doc_->Save(file_name_);
}

void ProgrammaAllenamento::removeSession(int session)
{
  int idx=0;
  bool found=false;
  while (idx<(int)doc_->GetRowCount())
  {
    int s= doc_->GetCell<int>(6,idx);
    if (s<session)
    {
      idx++;
    }
    else if (s==session)
    {
      doc_->RemoveRow(idx);
    }
    else
    {
      doc_->SetCell(6,idx,s-1);
      idx++;
    }
  }
  doc_->Save(file_name_);
}



void ProgrammaAllenamento::setSession(int session)
{
  idx_=0;
  if (session==0)
    session=1;
  act_session_=session;
  while (true)
  {
    updateField();
    if (session==session_)
      break;
    idx_++;
    if (idx_>=(int)doc_->GetRowCount())
    {
      qDebug("this section do not exist");
      idx_=0;
      updateField();
      break;
    }
  }

  while (true)
  {
    updateField();
    if (score_<0)
      break;
    idx_++;
    if (idx_>=(int)doc_->GetRowCount())
    {
      qDebug("this section do not exist");
      idx_=0;
      updateField();
      break;
    }
  }
}
void ProgrammaAllenamento::addRow(int session, QStringList dati)
{
  qDebug() << "qui";
  int idx=0;
  for (;idx<(int)doc_->GetRowCount();idx++)
  {
    int s = doc_->GetCell<int>(6,idx);
    if (s>session)
    {
      break;
    }
  }

  if (dati.size()!=10)
  {
    qDebug()<< "errore di dimensone dati. " << dati.size() <<" invece di 10";
    return;
  }
  std::vector<std::string> row;
  for (const QString& s : dati)
    row.push_back(s.toStdString());

  doc_->InsertRow(idx,row);
  doc_->Save(file_name_);
}

QVariant ProgrammaAllenamento::listSessionExercise(int session)
{
  QList<QStringList> vec;
  for (int idx=0;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<int>(6,idx);
    if (s==session)
    {
      QStringList  lista;
      QString code=QString::fromStdString(doc_->GetCell<std::string>(0,idx));
      lista.push_back(code);

      QString rep=QString::fromStdString(doc_->GetCell<std::string>(2,idx));
      lista.push_back(rep);

      QString set=QString::fromStdString(doc_->GetCell<std::string>(3,idx));
      lista.push_back(set);

      QString power=QString::fromStdString(doc_->GetCell<std::string>(1,idx));
      lista.push_back(power);

      vec.push_back(lista);
    }
  }
  return QVariant::fromValue(vec);
}

QVariant ProgrammaAllenamento::listSessionExerciseStat(int session)
{
  QList<QStringList> vec;
  for (int idx=0;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<int>(6,idx);
    if (s==session)
    {
      QStringList  lista;
      QString code=QString::fromStdString(doc_->GetCell<std::string>(0,idx));
      lista.push_back(code);





      double score=std::max(0.0,(double)QString().fromStdString(doc_->GetCell<std::string>(7,idx)).toDouble());
      std::string str = score>=0?"1":"0";
      lista.push_back(QString().fromStdString(str));

      std::stringstream stream;
      stream << std::fixed << std::setprecision(1) << score;
      str = stream.str();
      lista.push_back(QString().fromStdString(str));


      double tempo=std::round(QString().fromStdString(doc_->GetCell<std::string>(8,idx)).toDouble());
      int secondi=int(tempo)%60;
      int minuti=int(std::floor(tempo/60.0))%60;
      int ore=int(std::floor(tempo/3600.0));
      std::string tempo_stringa= std::to_string(ore)+" h "+std::to_string(minuti)+" m";


      lista.push_back(QString::fromStdString(tempo_stringa));

      tempo=std::round(QString().fromStdString(doc_->GetCell<std::string>(9,idx)).toDouble());
      secondi=int(tempo)%60;
      minuti=int(std::floor(tempo/60.0))%60;
      ore=int(std::floor(tempo/3600.0));
      tempo_stringa= std::to_string(ore)+" h "+std::to_string(minuti)+" m";
      lista.push_back(QString::fromStdString(tempo_stringa));


      vec.push_back(lista);
    }
  }
  return QVariant::fromValue(vec);
}


double ProgrammaAllenamento::getSessionProgess(int session)
{
  double score=0.0;
  double avanzamento=0.0;
  double nesercizi=0.0;


  for (int idx=0;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<int>(6,idx);
    int sc=QString().fromStdString(doc_->GetCell<std::string>(7,idx)).toDouble();
    if (s==session)
    {
      nesercizi++;
      score+=std::max(0.0,double(sc));
      if (sc>=0)
        avanzamento++;
    }
  }
  avanzamento/=nesercizi;
  return avanzamento;
}

double ProgrammaAllenamento::getSessionScore(int session)
{
  double score=0.0;
  double nesercizi=0.0;


  for (int idx=0;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<int>(6,idx);
    int sc=QString().fromStdString(doc_->GetCell<std::string>(7,idx)).toDouble();
    if (s==session)
    {
      nesercizi++;
      score+=std::max(0.0,double(sc));
    }
  }
  score/=nesercizi;
  return score;
}

double ProgrammaAllenamento::getSessionTime(int session)
{
  double time=0.0;
  for (int idx=0;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<int>(6,idx);
    int t=QString().fromStdString(doc_->GetCell<std::string>(8,idx)).toDouble();
    if (s==session)
    {
      time+=t;
    }
  }
  return time;

}

double ProgrammaAllenamento::getSessionTut(int session)
{
  double tut=0.0;
  for (int idx=0;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<int>(6,idx);
    int t=QString().fromStdString(doc_->GetCell<std::string>(9,idx)).toDouble();
    if (s==session)
    {
      tut+=t;
    }
  }
  return tut;
}

QString ProgrammaAllenamento::getSessionTimeString(int session)
{
  double time=getSessionTime(session);

  int secondi=int(time)%60;
  int minuti=int(std::floor(time/60.0))%60;
  int ore=int(std::floor(time/3600.0));

  std::string tempo_stringa;
  if (ore>0)
    tempo_stringa= std::to_string(ore)+" h ";
  tempo_stringa+=std::to_string(minuti)+" m "+std::to_string(secondi)+" s";
  return QString().fromStdString(tempo_stringa);

}

QString ProgrammaAllenamento::getSessionTutString(int session)
{
  double tut=getSessionTut(session);
  int secondi=int(tut)%60;
  int minuti=int(std::floor(tut/60.0))%60;
  int ore=int(std::floor(tut/3600.0));

  std::string tempo_stringa;
  if (ore>0)
    tempo_stringa= std::to_string(ore)+" h ";
  tempo_stringa+=std::to_string(minuti)+" m "+std::to_string(secondi)+" s";
  return QString().fromStdString(tempo_stringa);
}

double ProgrammaAllenamento::getProgess()
{
  if (isEmpty())
    return 0;
  double score=0.0;
  double avanzamento=0.0;
  double nesercizi=0.0;


  for (int idx=0;idx<(int)doc_->GetRowCount();idx++)
  {
    int sc=QString().fromStdString(doc_->GetCell<std::string>(7,idx)).toDouble();
    nesercizi++;
    score+=std::max(0.0,double(sc));
    if (sc>=0)
      avanzamento++;
  }
  avanzamento/=nesercizi;
  return avanzamento;
}

double ProgrammaAllenamento::getScore()
{
  double score=0.0;
  double nesercizi=0.0;


  for (int idx=0;idx<(int)doc_->GetRowCount();idx++)
  {
    int sc=QString().fromStdString(doc_->GetCell<std::string>(7,idx)).toDouble();
    if (sc>=0)
    {
      nesercizi++;
      score+=sc;
    }
  }
  if (nesercizi>0)
    score/=nesercizi;

  return score;
}

QString ProgrammaAllenamento::getTime()
{

  double time=0.0;
  for (int idx=0;idx<(int)doc_->GetRowCount();idx++)
  {
    int t=QString().fromStdString(doc_->GetCell<std::string>(8,idx)).toDouble();
    time+=t;
  }

  int secondi=int(time)%60;
  int minuti=int(std::floor(time/60.0))%60;
  int ore=int(std::floor(time/3600.0));

  std::string tempo_stringa= std::to_string(ore)+" h "+std::to_string(minuti)+" m";
  return QString().fromStdString(tempo_stringa);
}

QString ProgrammaAllenamento::getTut()
{

  double time=0.0;
  for (int idx=0;idx<(int)doc_->GetRowCount();idx++)
  {
    int t=QString().fromStdString(doc_->GetCell<std::string>(9,idx)).toDouble();
    time+=t;
  }

  int secondi=int(time)%60;
  int minuti=int(std::floor(time/60.0))%60;
  int ore=int(std::floor(time/3600.0));

  std::string tempo_stringa= std::to_string(ore)+" h "+std::to_string(minuti)+" m";
  return QString().fromStdString(tempo_stringa);
}

QVector<double> ProgrammaAllenamento::getSessionMeanScores()
{
  int session=0;

  for (int idx=idx_;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<int>(6,idx);
    session=std::max(session,s);
  }
  QVector<double> scores(session);
  double value=0;
  double n=0.0;
  for (int is=0;is<session;is++)
  {
    if (std::max(0.0,getSessionScore(is+1))>0.0)
    {
      value+=std::max(0.0,getSessionScore(is+1));
      n++;
    }
  }
  double mean=n>0?value/n:0.0;
  for (int is=0;is<session;is++)
  {
    scores[is]=10.*mean;
  }

  return scores;
}


QVector<double> ProgrammaAllenamento::getSessionScores()
{
  int session=0;
  for (int idx=idx_;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<int>(6,idx);
    session=std::max(session,s);
  }
  QVector<double> scores(session);
  for (int is=0;is<session;is++)
  {
    scores[is]=10.*std::max(0.0,getSessionScore(is+1));
  }
  return scores;
}

QVector<double> ProgrammaAllenamento::getSessionNumbers()
{
  int session=0;
  for (int idx=idx_;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<int>(6,idx);
    session=std::max(session,s);
  }
  QVector<double> v(session);
  for (int is=0;is<session;is++)
  {
    v[is]=(is+1);
  }
  return v;
}

QVector<double> ProgrammaAllenamento::getSessionTimes()
{
  int session=0;
  for (int idx=idx_;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<int>(6,idx);
    session=std::max(session,s);
  }
  QVector<double> values(session);
  for (int is=0;is<session;is++)
  {
    values[is]=std::max(0.0,getSessionTime(is+1)/3600.0);
  }
  return values;
}
QVector<double> ProgrammaAllenamento::getSessionTuts()
{
  int session=0;
  for (int idx=idx_;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<int>(6,idx);
    session=std::max(session,s);
  }
  QVector<double> values(session);
  for (int is=0;is<session;is++)
  {
    values[is]=std::max(0.0,getSessionTut(is+1)/3600.0);
  }
  return values;
}

QVector<double> ProgrammaAllenamento::getSelectedSessionScores    (int session)
{
  QVector<double> values;
  for (int idx=0;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<float>(6,idx);
    ;
    double t=10.*std::max(0.0,QString().fromStdString(doc_->GetCell<std::string>(7,idx)).toDouble());
    if (s==session)
    {
      values.append(t);
    }
  }
  std::string a="1.5";
  std::string b="1,5";
  qDebug() << " a= " << std::stod(a) << " b = " << std::stod(b);
  return values;
}
QVector<double> ProgrammaAllenamento::getSelectedSessionMeanScores(int session)
{
  double n=0;
  double cumscore=0.0;
  for (int idx=0;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<int>(6,idx);
    double t=10.*std::max(0.0,QString().fromStdString(doc_->GetCell<std::string>(7,idx)).toDouble());
    if (s==session)
    {
      cumscore+=t;
      n++;
    }
  }
  QVector<double> values;
  for (int idx=0;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<int>(6,idx);
    if (s==session)
    {
      values.append(cumscore/n);
    }
  }
  return values;
}
QVector<double> ProgrammaAllenamento::getSelectedSessionTimes     (int session)
{
  QVector<double> values;
  for (int idx=0;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<int>(6,idx);
    double t=QString().fromStdString(doc_->GetCell<std::string>(8,idx)).toDouble()/60.0;
    if (s==session)
    {
      values.append(t);
    }
  }
  return values;
}
QVector<double> ProgrammaAllenamento::getSelectedSessionTuts      (int session)
{
  QVector<double> values;
  for (int idx=0;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<int>(6,idx);
    double t=QString().fromStdString(doc_->GetCell<std::string>(9,idx)).toDouble()/60.0;
    if (s==session)
    {

      values.append(t);
    }
  }
  return values;
}
QVector<double> ProgrammaAllenamento::getSelectedSessionNumbers   (int session)
{
  QVector<double> values;
  double v=0.0;
  for (int idx=0;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<int>(6,idx);
    if (s==session)
    {
      values.append(++v);
    }
  }
  return values;
}

QVariant ProgrammaAllenamento::listSessionsNumber()
{

  int session=0;
  for (int idx=idx_;idx<(int)doc_->GetRowCount();idx++)
  {
    int s= doc_->GetCell<int>(6,idx);
    session=std::max(session,s);
  }

  std::vector<double> score(session,0);
  std::vector<double> avanzamento(session,0);
  std::vector<double> nesercizi(session,0);
  std::vector<double> time(session,0);
  std::vector<double> tut(session,0);

  for (int is=0;is<session;is++)
  {
    score.at(is)=getSessionScore(is+1);
    avanzamento.at(is)=getSessionProgess(is+1);
    time.at(is)=getSessionTime(is+1);
    tut.at(is)=getSessionTut(is+1);
  }



  QList<QStringList> vec;
  for (int idx=0;idx<session;idx++)
  {
    QStringList lista;
    lista.push_back(QString::number(idx+1));

    lista.push_back(QString::number(avanzamento.at(idx)));
    lista.push_back(QString::number(score.at(idx)));

    double tempo=std::round(time.at(idx));
    int secondi=int(tempo)%60;
    int minuti=int(std::floor(tempo/60.0))%60;
    int ore=int(std::floor(tempo/3600.0));
    std::string tempo_stringa= std::to_string(ore)+" h "+std::to_string(minuti)+" m";


    lista.push_back(QString::fromStdString(tempo_stringa));

    tempo=std::round(tut.at(idx));
    secondi=int(tempo)%60;
    minuti=int(std::floor(tempo/60.0))%60;
    ore=int(std::floor(tempo/3600.0));
    tempo_stringa= std::to_string(ore)+" h "+std::to_string(minuti)+" m";
    lista.push_back(QString::fromStdString(tempo_stringa));

    vec.push_back(lista);

  }
  return QVariant::fromValue(vec);
}


bool ProgrammaAllenamento::createEmptyWorkout(QString user_id, QString workout_name)
{
  std::string workout_file=template_path_+"/WORKOUT_TEMPLATE.csv";
  std::unique_ptr<rapidcsv::Document> doc;
  try {
    doc.reset(new rapidcsv::Document(workout_file));

  }
  catch (...)
  {
    std::cerr<<"Workout non disponibile" <<workout_file<<std::endl;
    completed_=true;
    return false;
  }

  std::string file=dir_path_.toStdString()+"/"+user_id.toStdString()+"_"+workout_name.toStdString()+".csv";
  doc_->Save(file);
  readFile(file);
  return true;
}

QString ProgrammaAllenamento::createWorkout(QString user_id, QString workout_name, int number_of_session)
{
  qDebug() << "user_id = "  << user_id << " workout name "<<workout_name << "  number of sessions = " << number_of_session;

  workoutName_=workout_name;
  std::string workout_file=dir_path_.toStdString()+"/"+workout_name.toStdString()+".csv";
  std::unique_ptr<rapidcsv::Document> doc;
  try {
    doc.reset(new rapidcsv::Document(workout_file));

  }
  catch (...)
  {
    std::cerr<<"Workout non disponibile" <<workout_file<<std::endl;
    completed_=true;
    return "";
  }

  int workout_rows=doc->GetRowCount();
  int workout_session=doc->GetCell<int>("session",doc->GetRowCount()-1); // numero sessioni nel workout
  doc_.reset(new rapidcsv::Document(workout_file));

  if (workout_session>number_of_session)
  {
    while (doc_->GetCell<int>("session",doc_->GetRowCount()-1)>number_of_session)
    {
      doc_->RemoveRow(doc_->GetRowCount()-1);
    }
  }
  else
  {
    int idx=0;

    int offset=workout_session;
    while(doc_->GetCell<int>("session",doc_->GetRowCount()-1)<=number_of_session)
    {
      if ((doc->GetCell<int>("session",idx)+offset)>number_of_session)
        break;
      doc_->InsertRow(doc_->GetRowCount(),doc->GetRow<std::string>(idx));

      int session=doc_->GetCell<int>("session",doc_->GetRowCount()-1);

      doc_->SetCell(6,doc_->GetRowCount()-1,session+offset);
      idx++;
      if (idx>=workout_rows)
      {
        idx=0;
        offset+=workout_session;
      }
    }
  }

  file_name_=dir_path_.toStdString()+"/../utenti/"+user_id.toStdString()+"_"+workout_name.toStdString()+".csv";


  for  (int idx=0;idx<(int)doc_->GetRowCount();idx++)
  {
    doc_->SetCell(7,idx,-1);
  }
  std::vector<int> time(doc_->GetRowCount(),0);
  doc_->InsertColumn(doc_->GetColumnCount(),time,"time");

  std::vector<int> time_tut(doc_->GetRowCount(),0);
  doc_->InsertColumn(doc_->GetColumnCount(),time_tut,"tut");
  doc_->Save(file_name_);
  readFile(file_name_);



  QString workout_id=workout_name;
  return workout_id;


}


void ProgrammaAllenamento::extend(int number_of_session)
{
  int workout_rows=doc_->GetRowCount();
  int workout_session=doc_->GetCell<int>("session",doc_->GetRowCount()-1); // numero sessioni nel workout

  if (workout_session>number_of_session)
  {
    while (doc_->GetCell<int>("session",doc_->GetRowCount()-1)>number_of_session)
    {
      doc_->RemoveRow(doc_->GetRowCount()-1);
    }
    doc_->Save(file_name_);
    readFile(file_name_);
  }
  else
  {
    int idx=0;

    int offset=workout_session;
    std::unique_ptr<rapidcsv::Document> doc;
    doc.reset(new rapidcsv::Document(file_name_));

    while(doc_->GetCell<int>("session",doc_->GetRowCount()-1)<=number_of_session)
    {
      if ((doc->GetCell<int>("session",idx)+offset)>number_of_session)
        break;
      doc_->InsertRow(doc_->GetRowCount(),doc->GetRow<std::string>(idx));

      int session=doc_->GetCell<int>("session",doc_->GetRowCount()-1);

      doc_->SetCell(6,doc_->GetRowCount()-1,session+offset);
      idx++;
      if (idx>=workout_rows)
      {
        idx=0;
        offset+=workout_session;
      }
    }


    for  (int idx=0;idx<(int)doc_->GetRowCount();idx++)
    {
      doc_->SetCell(7,idx,-1);
    }
    doc_->Save(file_name_);
    readFile(file_name_);

  }
}

void ProgrammaAllenamento::loadWorkout(QString user_id, QString workout_name)
{
  file_name_=dir_path_.toStdString()+"/../utenti/"+user_id.toStdString()+"_"+workout_name.toStdString()+".csv";
  readFile(file_name_);
  readStatFile(user_id);

}


void ProgrammaAllenamento::updateStatFile(QString user_id, QString workout_name, int time, int tut)
{
  stat_file_name_=dir_path_.toStdString()+"/../utenti/stat_"+user_id.toStdString()+".csv";
  std::unique_ptr<rapidcsv::Document> stat_doc;
  stat_doc.reset(new rapidcsv::Document(stat_file_name_));


  int now = std::time(nullptr);;
  std::vector<std::string> row;
  row.push_back(workout_name.toStdString()); //workout name
  row.push_back(std::to_string(act_session_)); // session
  row.push_back(std::to_string(now)); // date
  row.push_back(std::to_string(time)); //time
  row.push_back(std::to_string(tut)); //tut

  stat_doc->InsertRow(stat_doc->GetRowCount(),row);
  stat_doc->Save(stat_file_name_);
}


void ProgrammaAllenamento::readStatFile(QString user_id)
{
  stat_file_name_=dir_path_.toStdString()+"/../utenti/stat_"+user_id.toStdString()+".csv";
  std::unique_ptr<rapidcsv::Document> stat_doc;
  stat_doc.reset(new rapidcsv::Document(stat_file_name_));

  //  std::vector<std::string> col = stat_doc->GetColumn<std::string>("current_session");
  //  if (col.size()>0)
  //    act_session_=std::stoi(col.back());
  //  else
  //    act_session_=1;
  //  setSession(act_session_);
}



}
