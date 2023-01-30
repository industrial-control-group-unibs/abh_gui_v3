
#include "ListStringCSV.h"

#include <QByteArray>
#include <QTimer>
#include <cstdlib>
#include <rapidcsv.h>
#include <QDebug>

ListStringCSV::ListStringCSV(QString path, QObject *parent) :
  QAbstractListModel(parent)
{


  path_=path;
  dir_path_=path_.toStdString();

  append_=false;
  data_.clear();
}

int ListStringCSV::rowCount( const QModelIndex& parent) const
{
  if (parent.isValid())
    return 0;

  return data_.count();
}

QVariant ListStringCSV::data(const QModelIndex &index, int role) const
{
  if ( !index.isValid() )
    return QVariant();

  const QStringList &data = data_.at(index.row());
  if ( role == VectorRole ){
    return data;
  }
  else
    return QVariant();
}


QHash<int, QByteArray> ListStringCSV::roleNames() const
{
  static QHash<int, QByteArray> mapping {
    {VectorRole, "vector"}
  };
  return mapping;
}


void ListStringCSV::readFile(QString filename)
{

  std::string nome_file=dir_path_+"/"+filename.toStdString()+".csv";
  try {
    rapidcsv::Document doc(nome_file);


  data_.clear();
  for (size_t idx=0;idx<doc.GetRowCount();idx++)
  {
    QStringList lista;
    for (size_t ic=0;ic<doc.GetColumnCount();ic++)
    {
      QString str=QString::fromStdString(doc.GetCell<std::string>(ic,idx));
      lista.push_back(str);
    }
    data_ << lista;
  }

  if (append_)
  {
    QStringList lista;
    lista.push_back("+");
    for (size_t ic=1;ic<doc.GetColumnCount();ic++)
    {
      QString str("");
      lista.push_back(str);
    }
    data_ << lista;
  }
  } catch (...) {
    qDebug() << "the file does not exist = " << nome_file.c_str();
  }
}


void ListStringCSV::addRow(QString filename, QStringList row)
{
  std::string nome_file=dir_path_+"/"+filename.toStdString()+".csv";
  rapidcsv::Document doc(nome_file);


  std::vector<std::string> csv_row(row.size());

  for (int ifield=0;ifield<row.size();ifield++)
  {
    csv_row[ifield]=row.at(ifield).toStdString();
  }

  doc.InsertRow(doc.GetRowCount(),csv_row);
  doc.Save(nome_file);
  readFile(filename);
}


void ListStringCSV::removeRow(QString filename, int row_idx)
{
  std::string nome_file=dir_path_+"/"+filename.toStdString()+".csv";
  rapidcsv::Document doc(nome_file);

  if (row_idx<0)
    return;
  if (row_idx>=(int)doc.GetRowCount())
    return;
  doc.RemoveRow(row_idx);
  doc.Save(nome_file);
  readFile(filename);
}

void ListStringCSV::changeValue(QString filename, int row_idx, int col_idx, QString value)
{
  std::string nome_file=dir_path_+"/"+filename.toStdString()+".csv";
  rapidcsv::Document doc(nome_file);

  if (row_idx<0)
    return;
  if (row_idx>=(int)doc.GetRowCount())
    return;

  if (col_idx<0)
    return;
  if (col_idx>=(int)doc.GetColumnCount())
    return;


  doc.SetCell(col_idx,row_idx,value.toStdString());
  doc.Save(nome_file);
  readFile(filename);

}


QString ListStringCSV::getValue(QString filename, int row_idx,int col_idx)
{
  std::string nome_file=dir_path_+"/"+filename.toStdString()+".csv";
  rapidcsv::Document doc(nome_file);
  QString str;
  if (row_idx<0)
    return str;
  if (row_idx>=(int)doc.GetRowCount())
    return str;

  if (col_idx<0)
    return str;
  if (col_idx>=(int)doc.GetColumnCount())
    return str;
  std::string tmp=doc.GetCell<std::string>(col_idx,row_idx);
  str.fromStdString(tmp);
  return str;
}


bool ListStringCSV::checkIfExistColumn(QString filename, int col_idx, QString value)
{
  std::string nome_file=dir_path_+"/"+filename.toStdString()+".csv";
  rapidcsv::Document doc(nome_file);


  if (col_idx<0)
    return false;
  if (col_idx>=(int)doc.GetColumnCount())
    return false;

  std::vector<std::string> col=doc.GetColumn<std::string>(col_idx);

  return (std::find(col.begin(),col.end(),value.toStdString())!=col.end());
}

int ListStringCSV::getRowIndex(QString filename,int col_idx,QString value)
{
  std::string nome_file=dir_path_+"/"+filename.toStdString()+".csv";
  rapidcsv::Document doc(nome_file);

  if (col_idx<0)
    return -1;
  if (col_idx>=(int)doc.GetColumnCount())
    return -1;
  if (!checkIfExistColumn(filename,col_idx,value))
    return -1;

  std::vector<std::string> col=doc.GetColumn<std::string>(col_idx);
  for (int idx=0;idx<(int)col.size();idx++)
  {
    if (!col.at(idx).compare(value.toStdString()))
      return idx;
  }
  return -1;
}

