
#include "ListaZone.h"

#include <QByteArray>
#include <QTimer>
#include <cstdlib>
#include <rapidcsv.h>

ListaZona::ListaZona(QObject *parent) :
  QAbstractListModel(parent)
{


  std::string file_path = __FILE__;
  dir_path_ = file_path.substr(0, file_path.rfind("/"));
  path_=QString::fromStdString(dir_path_);

  readFile("Zone");
}

int ListaZona::rowCount( const QModelIndex& parent) const
{
  if (parent.isValid())
    return 0;

  return data_.count();
}

QVariant ListaZona::data(const QModelIndex &index, int role) const
{
  if ( !index.isValid() )
    return QVariant();

  const Zona &data = data_.at(index.row());
  if ( role == NameRole ){
    return data.ex_name_;
  }
  else if ( role == ImageRole )
    return data.image_name_;
  else if ( role == PathRole )
    return path_;
  else
    return QVariant();
}


QHash<int, QByteArray> ListaZona::roleNames() const
{
  static QHash<int, QByteArray> mapping {
    {NameRole, "ex_name"},
    {ImageRole, "image_name"},
    {PathRole, "path"}
  };
  return mapping;
}


void ListaZona::readFile(QString string)
{

  std::string nome_file=dir_path_+"/"+string.toStdString()+".csv";
  rapidcsv::Document doc(nome_file);

  std::vector<std::string> col = doc.GetColumn<std::string>("ex_name");
  size_t elements=col.size();


  data_.clear();
  for (size_t idx=0;idx<elements;idx++)
  {
    std::cout << doc.GetCell<std::string>(0,idx) <<std::endl;
    QString ex_name=QString::fromStdString(doc.GetCell<std::string>(0,idx));
    QString image=QString::fromStdString(doc.GetCell<std::string>(1,idx));
    data_ << Zona(ex_name,image);
  }
}
