
#include "ListStringQueue.h"

#include <QByteArray>
#include <QTimer>
#include <cstdlib>
#include <rapidcsv.h>
#include <QDebug>

ListString::ListString(QObject *parent) :
  QAbstractListModel(parent)
{


  append_=false;
  data_.clear();
}

int ListString::rowCount( const QModelIndex& parent) const
{
  if (parent.isValid())
    return 0;

  return data_.count();
}

QVariant ListString::data(const QModelIndex &index, int role) const
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


QHash<int, QByteArray> ListString::roleNames() const
{
  static QHash<int, QByteArray> mapping {
    {VectorRole, "vector"}
  };
  return mapping;
}


void ListString::fromList(QList< QStringList > data)
{
  data_.clear();
  for (int idx=0;idx<data.size();idx++)
    data_.push_back(data[idx]);
}


void ListString::addRow(QStringList row)
{
  data_.push_back(row);
}


void ListString::removeRow(int row_idx)
{
  if (row_idx<0)
    return;
  if (row_idx>=(int)data_.size())
    return;
  data_.remove(row_idx);
}

void ListString::changeValue(int row_idx, int col_idx, QString value)
{
  if (row_idx<0)
    return;
  if (row_idx>=(int)data_.size())
    return;

  if (col_idx<0)
    return;
  if (col_idx>=(int)data_.at(row_idx).size())
    return;

  data_[row_idx][col_idx]=value;
}


QString ListString::getValue(int row_idx,int col_idx)
{
  if (row_idx<0)
    return QString();
  if (row_idx>=(int)data_.size())
    return QString();

  if (col_idx<0)
    return QString();
  if (col_idx>=(int)data_.at(row_idx).size())
    return QString();
  return data_[row_idx][col_idx];
}


bool ListString::checkIfExistColumn(int col_idx, QString value)
{
  if (data_.size()==0)
    return 0;

  if (col_idx<0)
    return false;
  if (col_idx>=(int)data_.at(0).size())
    return false;

  for (int row_idx=0;row_idx<data_.size();row_idx++)
  {
    if (data_[row_idx][col_idx]==value)
      return true;
  }
  return false;
}
