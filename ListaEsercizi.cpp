
#include "ListaEsercizi.h"

#include <QByteArray>
#include <QTimer>
#include <cstdlib>
#include <rapidcsv.h>

ListaEsercizi::ListaEsercizi(QString path, QObject *parent) :
  QAbstractListModel(parent)
{


  path_=path;
  dir_path_=path_.toStdString();

  readFile("Gambe");
}

int ListaEsercizi::rowCount( const QModelIndex& parent) const
{
  if (parent.isValid())
    return 0;

  return data_.count();
}

QVariant ListaEsercizi::data(const QModelIndex &index, int role) const
{
  if ( !index.isValid() )
    return QVariant();

  const Data &data = data_.at(index.row());
  if ( role == NameRole ){
    return data.ex_name_;
  }
//  else if ( role == CodeRole )
//    return data.ex_code_;
//  else if ( role == ImageRole )
//    return data.image_name_;
  else if ( role == PathRole )
    return path_;
  else
    return QVariant();
}


QHash<int, QByteArray> ListaEsercizi::roleNames() const
{
  static QHash<int, QByteArray> mapping {
    {NameRole, "ex_name"},
//    {CodeRole, "ex_code"},
//    {ImageRole, "image_name"},
    {PathRole, "path"}
  };
  return mapping;
}


void ListaEsercizi::readFile(QString string)
{

  std::string nome_file=dir_path_+"/zone/"+string.toStdString()+".csv";
  std::cout << "file = "<<nome_file<<std::endl;
  rapidcsv::Document doc(nome_file);

  std::vector<std::string> col = doc.GetColumn<std::string>("ex_name");
  size_t elements=col.size();


  data_.clear();
  for (size_t idx=0;idx<elements;idx++)
  {
//    std::cout << doc.GetCell<std::string>(0,idx)<< ", " << doc.GetCell<std::string>(1, idx) << ", " << doc.GetCell<std::string>(2, idx) << std::endl;

    QString ex_name=QString::fromStdString(doc.GetCell<std::string>(0,idx));
//    QString ex_code=QString::fromStdString(doc.GetCell<std::string>(1,idx));
//    QString image=QString::fromStdString(doc.GetCell<std::string>(2,idx));
    data_ << Data(ex_name/*,ex_code,image*/);
  }
}
