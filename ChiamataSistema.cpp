#include <ChiamataSistema.h>
#include <QDebug>
#include <iostream>
#include <stdlib.h>

SysCall::SysCall(QObject *parent)
  : QObject(parent)
{
}


QString SysCall::string() const
{
  return string_;
}
void SysCall::setString(QString string)
{
  string_=string;
}


void SysCall::call()
{
  qDebug() << "chiamata = " <<system(string_.toStdString().c_str());
}

