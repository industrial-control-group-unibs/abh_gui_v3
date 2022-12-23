
#include "ListaUtenti.h"

#include <QByteArray>
#include <QTimer>
#include <cstdlib>
#include <rapidcsv.h>

ListaUtenti::ListaUtenti(QString path, QObject *parent) :
  QAbstractListModel(parent)
{


  roles_=roleNames().size();

  path_=path;
  dir_path_=path_.toStdString();

  readFile();
}

int ListaUtenti::rowCount( const QModelIndex& parent) const
{
  if (parent.isValid())
    return 0;

  return data_.count();
}

QVariant ListaUtenti::data(const QModelIndex &index, int role) const
{
  if ( !index.isValid() )
    return QVariant();

  const Utente &data = data_.at(index.row());
  if ( role == Role_nome ){
    return data.fields_[0];
  }
  else if ( role == Role_cognome )
    return data.fields_[1];
  else if ( role == Role_data_nascita )
    return data.fields_[2];
  else if ( role == Role_peso )
    return data.fields_[3];
  else if ( role == Role_altezza )
    return data.fields_[4];
  else if ( role == Role_mail )
    return data.fields_[5];
  else if ( role == Role_telefono )
    return data.fields_[6];
  else if ( role == Role_indirizzo )
    return data.fields_[7];
  else if ( role == Role_professione )
    return data.fields_[8];
  else if ( role == Role_social_media )
    return data.fields_[9];
  else if ( role == Role_stato )
    return data.fields_[10];
  else if ( role == Role_foto )
    return data.fields_[11];
  else if ( role == Role_id )
    return data.fields_[12];
  else if ( role == Role_coloreBordo )
    return data.fields_[13];
  else if ( role == Role_coloreSfondo )
    return data.fields_[14];
  else if ( role == Role_coloreUtente )
    return data.fields_[15];
  else
    return QVariant();
}

void ListaUtenti::addUser(std::vector<QString> dati)
{
  data_.pop_back();
  data_ << Utente(dati);

  std::string nome_file=dir_path_+"/utenti.csv";
  rapidcsv::Document doc(nome_file);
  std::vector<std::string> row(roles_);
  for (size_t ifield=0;ifield<dati.size();ifield++)
  {
    row[ifield]=dati.at(ifield).toStdString();
  }
  row[12]=std::to_string(doc.GetRowCount())+"_"+row[0]+"_"+row[1];
  row[13]="#c6aa76";
  row[14]="#2A211B";
  row[15]="#8c177b";

  doc.InsertRow(doc.GetRowCount(),row);
  doc.Save(nome_file);

  std::vector<QString> fields(roles_);
  data_ << Utente(fields);

}

void ListaUtenti::editUser(QString identifier, QVector<QString> dati)
{
  std::string id=identifier.toStdString();


  std::string nome_file=dir_path_+"/utenti.csv";
  rapidcsv::Document doc(nome_file);
  std::vector<std::string> row(roles_);


  std::vector<std::string> col = doc.GetColumn<std::string>("id");
  for (size_t ifield=0;ifield<col.size();ifield++)
  {

    if (!col.at(ifield).compare(id))
    {
      for (long idx=0;idx<dati.size();idx++)
      {
        doc.SetCell(idx,ifield,dati.at(idx).toStdString());
      }
    }
  }

  doc.Save(nome_file);

  std::vector<QString> fields(roles_);
  data_ << Utente(fields);

}

QVector<QString> ListaUtenti::getUser(QString name)
{
  std::string nome=name.toStdString();
  std::string nome_file=dir_path_+"/utenti.csv";
  rapidcsv::Document doc(nome_file);


  QVector<QString> dati;

  std::vector<std::string> col = doc.GetColumn<std::string>("id");
  for (size_t ifield=0;ifield<col.size();ifield++)
  {
    if (!col.at(ifield).compare(nome))
    {
      std::vector<std::string> row=doc.GetRow<std::string>(ifield);
      for (int idx=0;idx<12;idx++)
      {
        dati.push_back(QString().fromStdString(row.at(idx)));
      }

    }
  }
  return dati;
}



QHash<int, QByteArray> ListaUtenti::roleNames() const
{
  static QHash<int, QByteArray> mapping {
    {Role_nome           ,"nome"},
    {Role_cognome        ,"cognome"},
    {Role_data_nascita   ,"data_nascita"},
    {Role_peso           ,"peso"},
    {Role_altezza        ,"altezza"},
    {Role_mail           ,"mail"},
    {Role_telefono       ,"telefono"},
    {Role_indirizzo      ,"indirizzo"},
    {Role_professione    ,"professione"},
    {Role_social_media   ,"social_media"},
    {Role_stato          ,"stato"},
    {Role_id             ,"identifier"},
    {Role_foto           ,"foto"},
    {Role_coloreBordo    ,"coloreBordo"},
    {Role_coloreSfondo   ,"coloreSfondo"},
    {Role_coloreUtente   ,"coloreUtente"}
  };
  return mapping;
}


void ListaUtenti::removeUser(QString name)
{
  std::string nome=name.toStdString();
  std::string nome_file=dir_path_+"/utenti.csv";
  rapidcsv::Document doc(nome_file);

  std::vector<std::string> col = doc.GetColumn<std::string>("id");
  for (size_t ifield=0;ifield<col.size();ifield++)
  {
    if (!col.at(ifield).compare(nome))
    {
      doc.RemoveRow(ifield);
      break;
    }
  }
  doc.Save(nome_file);

}
void ListaUtenti::readFile()
{

  std::string nome_file=dir_path_+"/utenti.csv";
  rapidcsv::Document doc(nome_file);

  std::vector<std::string> col = doc.GetColumn<std::string>("nome");
  size_t elements=col.size();


  data_.clear();
  for (size_t idx=0;idx<elements;idx++)
  {
    std::vector<QString> fields(roles_);
    for (size_t ifield=0;ifield<fields.size();ifield++)
      fields.at(ifield)=QString::fromStdString(doc.GetCell<std::string>(ifield,idx));
    data_ << Utente(fields);
  }
  std::vector<QString> fields(roles_);
  data_ << Utente(fields);

}

void ListaUtenti::saveColor(QString user_name, QString coloreBordo, QString coloreSfondo, QString coloreUtente)
{
  std::string nome=user_name.toStdString();
  std::string nome_file=dir_path_+"/utenti.csv";
  rapidcsv::Document doc(nome_file);

  std::vector<std::string> col = doc.GetColumn<std::string>("nome");
  for (size_t ifield=0;ifield<col.size();ifield++)
  {
    if (!col.at(ifield).compare(nome))
    {
      doc.SetCell<std::string>(13,ifield,coloreBordo.toStdString());
      doc.SetCell<std::string>(14,ifield,coloreSfondo.toStdString());
      doc.SetCell<std::string>(15,ifield,coloreUtente.toStdString());
      break;
    }
  }
  doc.Save(nome_file);
}
