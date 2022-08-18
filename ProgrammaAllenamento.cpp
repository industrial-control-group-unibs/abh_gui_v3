#include <ProgrammaAllenamento.h>
#include <QDebug>
#include <iostream>

namespace abh {

ProgrammaAllenamento::ProgrammaAllenamento(QObject *parent)
{
  completed_=true;
}
void ProgrammaAllenamento::readFile(QString string)
{

  workoutName_=string;
  std::string nome_file=dir_path_.toStdString()+"/"+string.toStdString()+".csv";

  try {
    doc_.reset(new rapidcsv::Document(nome_file));

    int r=doc_->GetRowCount();
    int c=doc_->GetColumnCount();

    std::cout << "read " << r << " x " << c << std::endl;

    idx=0;

    completed_=false;
    updateField();

  }
  catch (...)
  {
    std::cerr<<nome_file<<std::endl;

  }
}

void ProgrammaAllenamento::updateField()
{
  name_=QString::fromStdString(doc_->GetCell<std::string>(0,idx));
  power_=doc_->GetCell<int>(1,idx);
  reps_= doc_->GetCell<int>(2,idx);
  sets_= doc_->GetCell<int>(3,idx);
  rest_= doc_->GetCell<int>(4,idx);
  maxPosSpeed_ = doc_->GetCell<double>(5,idx);
  maxNegSpeed_ = doc_->GetCell<double>(6,idx);
}

void ProgrammaAllenamento::next()
{
  idx++;
  if (idx>=doc_->GetRowCount())
  {
    idx=0;
    completed_=true;
  }
  else
  {
    completed_=false;
    updateField();
  }
}
}
