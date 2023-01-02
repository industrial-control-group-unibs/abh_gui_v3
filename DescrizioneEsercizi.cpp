#include <DescrizioneEsercizi.h>
#include <QDebug>
#include <iostream>

namespace abh {

DescrizioneEsercizi::DescrizioneEsercizi(QString path, QObject *parent)
{
  dir_path_=path;
  readFile();
}
void DescrizioneEsercizi::readFile()
{

  std::string nome_file=dir_path_.toStdString()+"/lista_esercizi.csv";

  try {
    doc_.reset(new rapidcsv::Document(nome_file));
  }
  catch (...)
  {
    std::cerr<<nome_file<<std::endl;

  }
}

void DescrizioneEsercizi::setCode(QString new_code)
{
  code=new_code;
  std::string n=name.toStdString();
  std::vector<std::string> col = doc_->GetColumn<std::string>("codice");
  size_t elements=col.size();

  size_t idx;
  for (idx=0;idx<elements;idx++)
  {
    if (!n.compare(col.at(idx)))
    {
      code=getCode(name);
      video_intro=getVideoIntro(name);
      video_preparazione=getVideoPrep(name);
      video_workout=getVideoWorkout(name);
      image=getImage(name);
      return;
    }
  }

  name="";
  video_intro="";
  video_preparazione="";
  video_workout="";
  image="";
}

QString DescrizioneEsercizi::getImage(QString nome)
{
  QString s=getInfo(nome,"immagine");

  if (s=="")
    s="place_holder_1x1.png";
  return s;
}
QString DescrizioneEsercizi::getCode(QString nome)
{
  return getInfo(nome,"codice");
}

QString DescrizioneEsercizi::getName(QString nome)
{
  return getInfo(nome,"nome");
}

QString DescrizioneEsercizi::getVideoIntro(QString nome)
{
  QString s=getInfo(nome,"video_breve");

  if (s=="")
    s="placeholver_video.mp4";
  return s;
}
QString DescrizioneEsercizi::getVideoIstruzioni(QString nome)
{
  QString s=getInfo(nome,"video_istruzioni");

  if (s=="")
    s="placeholver_video.mp4";
  return s;
}
QString DescrizioneEsercizi::getVideoPrep(QString nome)
{
  return getInfo(nome,"video_preparazione");
}
QString DescrizioneEsercizi::getVideoWorkout(QString nome)
{
  return getInfo(nome,"video_workout");
}


int DescrizioneEsercizi::getType(QString nome)
{
  return getValue(nome,"tipologia");
}


int DescrizioneEsercizi::getMaxPosVel(QString nome)
{
  return getValue(nome,"max_vel_positiva");
}
int DescrizioneEsercizi::getMaxNegVel(QString nome)
{
  return getValue(nome,"max_vel_negativa");
}

QString DescrizioneEsercizi::getInfo(QString nome,std::string field)
{
  std::string n=nome.toStdString();
  std::vector<std::string> col = doc_->GetColumn<std::string>("codice");
  std::vector<std::string> col2 = doc_->GetColumn<std::string>(field);
  size_t elements=col.size();
  QString out;
  for (size_t idx=0;idx<elements;idx++)
  {
    if (!n.compare(col.at(idx)))
    {
      out=QString::fromStdString(col2.at(idx));
    }
  }
  return out;
}

double DescrizioneEsercizi::getValue(QString nome, std::string field)
{
  std::string n=nome.toStdString();
  std::vector<std::string> col = doc_->GetColumn<std::string>("codice");
  std::vector<double> col2 = doc_->GetColumn<double>(field);
  size_t elements=col.size();
  double out;
  for (size_t idx=0;idx<elements;idx++)
  {
    if (!n.compare(col.at(idx)))
    {
      out=col2.at(idx);
    }
  }
  return out;
}

}
