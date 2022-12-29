#include <ChiamataSistema.h>
#include <QDebug>
#include <iostream>
#include <stdlib.h>
#include <cstdlib>
#include <fstream>
#include <sstream> //std::stringstream

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
//  qDebug() << "chiamata = " <<system(string_.toStdString().c_str());
  qDebug() << "chiamata = " << execute(string_.toStdString()).c_str();
}


std::string SysCall::execute(std::string cmd)
{
  cmd=cmd+" > /tmp/tmp.cmd";
  std::system(cmd.c_str()); // execute the UNIX command "ls -l >test.txt"
  std::stringstream buffer;
  buffer<< std::ifstream("/tmp/tmp.cmd").rdbuf();
  std::string cmd_output=buffer.str();
  return  cmd_output;
}



int SysCall::getVolume()
{

  std::string cmd="amixer -c 1 -M -D pulse get Master | grep -m 1 -o -E [[:digit:]]+% | tr -d \"%\"";
  std::string cmd_out=execute(cmd);
  int volume=std::stoi(cmd_out);
//  qDebug() << "volume ="  << volume;
  return volume;
}

bool SysCall::isMuted()
{

  std::string cmd="pactl list sinks | grep Mute | grep yes";
  std::string cmd_out=execute(cmd);

  qDebug() << "cmd out="  << cmd_out.c_str();
  return cmd_out.length()==0;
}


