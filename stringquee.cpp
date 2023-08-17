#include "stringquee.h"
#include <QDebug>

StringQuee::StringQuee()
{
}
void StringQuee::push(QString string)
{
  data.push_front(string);



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
  return str;
}

QString StringQuee::popIfMe(QString string)
{
  while (true)
  {
    QString str= data.front();
    if (str==string)
      pop();
    else
      return str;
  }
}
