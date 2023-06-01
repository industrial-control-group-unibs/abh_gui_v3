
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
  else if ( role == Role_password )
    return data.fields_[16];
  else if ( role == Role_storePwd )
    return data.fields_[17];
  else if ( role == Role_Workout )
    return data.fields_[18];
  else
    return QVariant();
}

void ListaUtenti::setDefaultColor(QStringList default_colors)
{
  default_colors_=default_colors;
}



QString ListaUtenti::addUser(std::vector<QString> dati)
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
  row[13]=default_colors_[0].toStdString();
  row[14]=default_colors_[1].toStdString();
  row[15]=default_colors_[2].toStdString();
  row[16]="9999";
  row[17]="false";
  row[18]="";


  doc.InsertRow(doc.GetRowCount(),row);
  doc.Save(nome_file);
  std::vector<QString> fields(roles_);
  data_ << Utente(fields);


  createStatFile(QString().fromStdString( row[12]));
  return QString().fromStdString( row[12]);

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
    {Role_coloreUtente   ,"coloreUtente"},
    {Role_password       ,"password"},
    {Role_storePwd       ,"store_pwd"},
    {Role_Workout       ,"workout"}
  };
  return mapping;
}


void ListaUtenti::removeUser(QString name)
{
  std::string nome=name.toStdString();

  std::string nome_file=dir_path_+"/utenti.csv";
  try {
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
  } catch (std::exception& ex) {
    std::cout << "expection " << ex.what() << " while reading file " << nome_file << std::endl;
  }

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

void ListaUtenti::saveColor(QString identifier, QString coloreBordo, QString coloreSfondo, QString coloreUtente)
{
  std::string nome=identifier.toStdString();
  std::string nome_file=dir_path_+"/utenti.csv";
  rapidcsv::Document doc(nome_file);

  std::vector<std::string> col = doc.GetColumn<std::string>("id");
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



void ListaUtenti::savePassword(QString identifier, QString pwd)
{
  std::string nome=identifier.toStdString();
  std::string nome_file=dir_path_+"/utenti.csv";
  rapidcsv::Document doc(nome_file);

  std::vector<std::string> col = doc.GetColumn<std::string>("id");
  for (size_t ifield=0;ifield<col.size();ifield++)
  {
    if (!col.at(ifield).compare(nome))
    {
      doc.SetCell<std::string>(16,ifield,pwd.toStdString());
      break;
    }
  }
  doc.Save(nome_file);
}



QString ListaUtenti::getPassword(QString identifier)
{
  std::string nome=identifier.toStdString();
  std::string nome_file=dir_path_+"/utenti.csv";
  rapidcsv::Document doc(nome_file);


  QVector<QString> dati;

  std::vector<std::string> col = doc.GetColumn<std::string>("id");
  for (size_t ifield=0;ifield<col.size();ifield++)
  {
    if (!col.at(ifield).compare(nome))
    {
      std::vector<std::string> row=doc.GetRow<std::string>(ifield);
      return QString().fromStdString(row.at(16));
    }
  }
  return QString("");
}



void ListaUtenti::saveStorePassword(QString identifier, QString store_pwd)
{
  std::string nome=identifier.toStdString();
  std::string nome_file=dir_path_+"/utenti.csv";
  rapidcsv::Document doc(nome_file);

  std::vector<std::string> col = doc.GetColumn<std::string>("id");
  for (size_t ifield=0;ifield<col.size();ifield++)
  {
    if (!col.at(ifield).compare(nome))
    {
      doc.SetCell<std::string>(17,ifield,store_pwd.toStdString());
      break;
    }
  }
  doc.Save(nome_file);
}



bool ListaUtenti::getStorePassword(QString identifier)
{
  std::string nome=identifier.toStdString();
  std::string nome_file=dir_path_+"/utenti.csv";
  rapidcsv::Document doc(nome_file);


  QVector<QString> dati;

  std::vector<std::string> col = doc.GetColumn<std::string>("id");
  for (size_t ifield=0;ifield<col.size();ifield++)
  {
    if (!col.at(ifield).compare(nome))
    {
      std::vector<std::string> row=doc.GetRow<std::string>(ifield);
      std::string store_pwd=row.at(17);
      return (!store_pwd.compare("true"));
    }
  }
  return false;
}





void ListaUtenti::saveWorkout(QString identifier, QString workout)
{
  std::string nome=identifier.toStdString();
  std::string nome_file=dir_path_+"/utenti.csv";
  rapidcsv::Document doc(nome_file);

  std::vector<std::string> col = doc.GetColumn<std::string>("id");
  for (size_t ifield=0;ifield<col.size();ifield++)
  {
    if (!col.at(ifield).compare(nome))
    {
      doc.SetCell<std::string>(18,ifield,workout.toStdString());
      break;
    }
  }
  doc.Save(nome_file);

}



QString ListaUtenti::getWorkout(QString identifier)
{
  std::string nome=identifier.toStdString();
  std::string nome_file=dir_path_+"/utenti.csv";
  rapidcsv::Document doc(nome_file);


  QVector<QString> dati;

  std::vector<std::string> col = doc.GetColumn<std::string>("id");
  for (size_t ifield=0;ifield<col.size();ifield++)
  {
    if (!col.at(ifield).compare(nome))
    {
      std::vector<std::string> row=doc.GetRow<std::string>(ifield);
      return QString().fromStdString(row.at(18));
    }
  }
  return QString("");
}


void ListaUtenti::createStatFile(QString user_id)
{
  std::string stat_file_name_=dir_path_+"/../utenti/stat_"+user_id.toStdString()+".csv";
  std::unique_ptr<rapidcsv::Document> stat_doc;
  stat_doc.reset(new rapidcsv::Document(dir_path_+"/../utenti/stat_template.csv"));
  stat_doc->Save(stat_file_name_);


  std::string aw_file_name_=dir_path_+"/../utenti/ACTIVEWORKOUT_"+user_id.toStdString()+".csv";
  std::unique_ptr<rapidcsv::Document> aw_doc;
  stat_doc.reset(new rapidcsv::Document(dir_path_+"/../utenti/ACTIVEWORKOUT_template.csv"));
  stat_doc->Save(aw_file_name_);

  std::string custom_file_name_=dir_path_+"/../utenti/CUSTOMWORKOUT_"+user_id.toStdString()+".csv";
  std::unique_ptr<rapidcsv::Document> custom_doc;
  custom_doc.reset(new rapidcsv::Document(dir_path_+"/../utenti/SESSION_template.csv"));
  custom_doc->Save(custom_file_name_);

}
