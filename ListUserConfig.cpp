
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
  for (size_t idx=0;idx<doc_->GetRowCount();idx++)
  {
    std::cout << doc_->GetCell<std::string>(0,idx) << std::endl;
    if (!doc_->GetCell<std::string>(0,idx).compare(str))
    {
      doc_->SetCell<std::string>(1,idx,value.toStdString());
      doc_->Save(nome_file);
      qInfo() << "field " << field << " set to " << value;
      emit updated();
      return true;
    }
  }
  qCritical() << "the field " << field <<" does not exist = " << nome_file.c_str();
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
    std::cout << "v";
    if (!doc_->GetCell<std::string>(0,idx).compare(str))
    {
      std::string value= doc_->GetCell<std::string>(1,idx);
      QString v=QString::fromStdString(value);
      //qInfo() << "field " << field << " is: " << v;
      return v;
    }
  }
  qCritical() << "the field does not exist = " << nome_file.c_str();
  return "";
}
