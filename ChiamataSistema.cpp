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
  execute(string_.toStdString());
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

  std::string cmd="amixer  -M -D pulse get Master | grep -m 1 -o -E [[:digit:]]+% | tr -d \"%\"";
  std::string cmd_out=execute(cmd);
  int volume;
  try {
    volume=std::stoi(cmd_out);
  } catch () {
    volume=50;
  }


  return volume;
}

bool SysCall::isMuted()
{

  std::string cmd="pactl list sinks | grep 'Mute\\|Muto' | grep 'yes\\|sì'";
  std::string cmd_out=execute(cmd);

  return cmd_out.length()==0;
}


