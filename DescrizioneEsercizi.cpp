#include <DescrizioneEsercizi.h>
#include <QDebug>
#include <iostream>

namespace abh {

DescrizioneEsercizi::DescrizioneEsercizi(QObject *parent)
{

}
void DescrizioneEsercizi::readFile()
{

  std::string nome_file=dir_path_.toStdString()+"/lista_esercizi.csv";

  try {
    doc_.reset(new rapidcsv::Document(nome_file));

    int r=doc_->GetRowCount();
    int c=doc_->GetColumnCount();

    std::cout << "read " << r << " x " << c << std::endl;

  }
  catch (...)
  {
    std::cerr<<nome_file<<std::endl;

  }
}

void DescrizioneEsercizi::setName(QString new_name)
{
  name=new_name;
  std::string n=name.toStdString();
  std::vector<std::string> col = doc_->GetColumn<std::string>("nome");
  size_t elements=col.size();

  std::cout <<"XXXttt "<< elements << std::endl;
  size_t idx;
  for (idx=0;idx<elements;idx++)
  {
    std::cout <<"XXX "<< col.at(idx) << std::endl;
    std::cout <<"YYY "<< doc_->GetCell<std::string>(1,idx) << std::endl;
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

  code="";
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
QString DescrizioneEsercizi::getVideoIntro(QString nome)
{
  QString s=getInfo(nome,"video_breve");

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


QString DescrizioneEsercizi::getInfo(QString nome,std::string field)
{
  std::string n=nome.toStdString();
  std::vector<std::string> col = doc_->GetColumn<std::string>("nome");
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
}
