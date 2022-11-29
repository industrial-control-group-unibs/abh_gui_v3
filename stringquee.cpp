#include "stringquee.h"

StringQuee::StringQuee()
{
}
void StringQuee::push(QString string)
{
  queue_.push(string);
  front_=queue_.front();
}

void StringQuee::pop()
{
  queue_.pop();
  if (queue_.size()==0)
    front_="";
}
