
#include "ListUserConfig.h"

#include <QByteArray>
#include <QTimer>
#include <cstdlib>
#include <rapidcsv.h>

ListUserConfig::ListUserConfig(QString path, QObject *parent) :
  QObject(parent)
{
  path_=path;
  dir_path_=path_.toStdString();
  doc_.reset();
}
void ListUserConfig::readFile(QString filename)
{

  nome_file=dir_path_+"/"+filename.toStdString()+".csv";
  try {
     doc_=std::make_shared<rapidcsv::Document>(nome_file);
  } catch (...) {
    qCritical() << "the file does not exist = " << nome_file.c_str();
    doc_.reset();
  }
  emit updated();
}

bool ListUserConfig::setValue(QString field, QString value)
{
  if (!doc_)
  {
    qCritical("User file do not exist")  ;
    return false;
  }

  std::string str=field.toStdString();
  bool found=false;
  for (size_t idx=0;idx<doc_->GetRowCount();idx++)
  {
    if (!doc_->GetCell<std::string>(idx,0).compare(str))
    {
      doc_->SetCell<std::string>(idx,1,value.toStdString());
      emit updated();
      return true;
    }
  }
  qCritical() << "the field does not exist = " << nome_file.c_str();
  return false;
}


QString ListUserConfig::getValue(QString field)
{
  if (!doc_)
  {
    qCritical("User file do not exist")  ;
    return "";
  }

  std::string str=field.toStdString();
  for (size_t idx=0;idx<doc_->GetRowCount();idx++)
  {
    if (!doc_->GetCell<std::string>(idx,0).compare(str))
    {
      std::string value= doc_->GetCell<std::string>(idx,1);
      QString v=QString::fromStdString(value);
      return v;
    }
  }
  qCritical() << "the field does not exist = " << nome_file.c_str();
  return "";
}
