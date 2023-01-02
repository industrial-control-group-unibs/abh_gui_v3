#include <ProgrammaAllenamento.h>
#include <QDebug>
#include <iostream>
#include <ctime>

namespace abh {

ProgrammaAllenamento::ProgrammaAllenamento(QString path, QObject* /*parent*/)
{
  dir_path_=path;
  completed_=true;
  end_session_=false;
  act_session_=1;
}

void ProgrammaAllenamento::readFile(std::string file_name)
{


  try {
    doc_.reset(new rapidcsv::Document(file_name));

    idx_=0;

    completed_=false;
    end_session_=false;
    updateField();

  }
  catch (...)
  {
    std::cerr<< "file does not exist :"<<file_name<<std::endl;

  }
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
  score_= doc_->GetCell<double>(7,idx_);
}

void ProgrammaAllenamento::setScore(double score)
{
  doc_->SetCell(7,idx_,score);
  score_=score;
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
  }
  else
  {
    updateField();
    end_session_=session_>act_session_;
  }
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
}


QStringList ProgrammaAllenamento::listSessionExercise()
{
  QStringList  lista;

  for (int idx=idx_;idx<(int)doc_->GetRowCount();idx++)
  {
    QString code=QString::fromStdString(doc_->GetCell<std::string>(0,idx));
    int session= doc_->GetCell<int>(6,idx);
    if (session>act_session_)
      break;
    lista.push_back(code);
  }
  return lista;
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
  doc_->Save(file_name_);
  readFile(file_name_);


  QString workout_id=workout_name;
  return workout_id;


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

  std::vector<std::string> col = stat_doc->GetColumn<std::string>("current_session");
  if (col.size()>0)
    act_session_=std::stoi(col.back());
  else
    act_session_=1;
  setSession(act_session_);
}



}
