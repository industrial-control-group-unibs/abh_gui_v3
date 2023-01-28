
#include "ListaImmagini.h"

#include <QByteArray>
#include <QTimer>
#include <cstdlib>
#include <rapidcsv.h>

ListaImmagini::ListaImmagini(QString path, QObject *parent) :
  QAbstractListModel(parent)
{
  path_=path;
  dir_path_=path_.toStdString();
  append_=false;
}

int ListaImmagini::rowCount( const QModelIndex& parent) const
{
  if (parent.isValid())
    return 0;

  return data_.count();
}

QVariant ListaImmagini::data(const QModelIndex &index, int role) const
{
  if ( !index.isValid() )
    return QVariant();

  const Immagine &data = data_.at(index.row());
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


QHash<int, QByteArray> ListaImmagini::roleNames() const
{
  static QHash<int, QByteArray> mapping {
    {NameRole, "ex_name"},
    {ImageRole, "image_name"},
    {PathRole, "path"}
  };
  return mapping;
}


void ListaImmagini::readFile(QString string)
{
  std::string nome_file=dir_path_+"/"+string.toStdString()+".csv";
  rapidcsv::Document doc(nome_file);

  std::vector<std::string> col = doc.GetColumn<std::string>("ex_name");
  size_t elements=col.size();

  data_.clear();
  for (size_t idx=0;idx<elements;idx++)
  {
    QString ex_name=QString::fromStdString(doc.GetCell<std::string>(0,idx));
    QString image=QString::fromStdString(doc.GetCell<std::string>(1,idx));
    data_ << Immagine(ex_name,image);
  }
  if (append_)
  {
    data_ << Immagine("+","");
  }
}
