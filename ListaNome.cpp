
#include "ListaNome.h"

#include <QByteArray>
#include <QTimer>
#include <cstdlib>
#include <rapidcsv.h>
#include <QDebug>

ListaNome::ListaNome(QString path, QObject *parent) :
  QAbstractListModel(parent)
{


  path_=path;
  dir_path_=path_.toStdString();

  data_.clear();
  unfilter_data_.clear();
}

int ListaNome::rowCount( const QModelIndex& parent) const
{
  if (parent.isValid())
    return 0;

  return data_.count();
}

QVariant ListaNome::data(const QModelIndex &index, int role) const
{
  if ( !index.isValid() )
    return QVariant();

  const EsData &data = data_.at(index.row());
  if ( role == NameRole ){
    return data.ex_name_;
  }
  else if ( role == PathRole )
    return path_;
  else
    return QVariant();
}


QHash<int, QByteArray> ListaNome::roleNames() const
{
  static QHash<int, QByteArray> mapping {
    {NameRole, "ex_name"},
    {PathRole, "path"}
  };
  return mapping;
}


void ListaNome::readFile(QString string)
{
  std::string nome_file=dir_path_+"/zone/"+string.toStdString()+".csv";

  try {
    rapidcsv::Document doc(nome_file);

    std::vector<std::string> col = doc.GetColumn<std::string>("ex_name");
    size_t elements=col.size();


    data_.clear();
    for (size_t idx=0;idx<elements;idx++)
    {

      QString ex_name=QString::fromStdString(doc.GetCell<std::string>(0,idx));
      data_ << EsData(ex_name);
    }

  } catch (std::exception& ex) {
    std::cout << "expection " << ex.what() << " while reading file " << nome_file << std::endl;
  }

  unfilter_data_=data_;
}


void ListaNome::fromList(QStringList list)
{
  data_.clear();
  for (int idx=0;idx<list.size();idx++)
  {

    QString ex_name=list.at(idx);
    data_ << EsData(ex_name);
  }
  unfilter_data_=data_;
}

void ListaNome::filterByName(QString string)
{
  data_.clear();
  for (const EsData& s: unfilter_data_)
  {
    if (s.ex_name_.contains(string,Qt::CaseInsensitive))
    {
      data_<<s;
    }
  }
}
