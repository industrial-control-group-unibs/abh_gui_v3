#include "stringquee.h"
#include <QDebug>

StringQuee::StringQuee()
{
}
void StringQuee::push(QString string)
{
  data.push_front(string);

  qDebug() << " List of pages";
  for (int idx=0;idx<data.size();idx++)
    qDebug()<< "- " << data.at(idx);

  while (data.size()>max_size)
  {
    data.pop_back();
  }
}

QString StringQuee::pop()
{
  QString str("");
  if (data.size()>0)
  {
    str=data.front();
    if (data.size()>1)
      data.pop_front();
  }

  return str;

}

QString StringQuee::front() const
{
  QString str= data.front();
  qDebug() << " this is front " << str;
  return str;
}
