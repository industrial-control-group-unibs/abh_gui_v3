
#include "listwifi.h"
#include <ctime>
#include <iostream>

ListaWifi::ListaWifi(QObject *parent) :
  QAbstractListModel(parent)
{
  readList();
}

int ListaWifi::rowCount( const QModelIndex& parent) const
{
  if (parent.isValid())
    return 0;

  return data_.count();
}

QVariant ListaWifi::data(const QModelIndex &index, int role) const
{
  if ( !index.isValid() )
    return QString();

  const QString &data = data_.at(index.row());
  const QString &uuid = uuid_.at(index.row());
  if ( role == Role_nome ){
    return data;
  }
  else if ( role == Role_uuid ){
    return uuid;
  }
  else
    return QString();
}


QHash<int, QByteArray> ListaWifi::roleNames() const
{
  static QHash<int, QByteArray> mapping {
    {Role_nome,"nome"},
    {Role_uuid,"uuid"},
    {Role_known,"known"}
  };

  return mapping;
}


void ListaWifi::readList()
{
  data_.clear();




  QDBusInterface interface(
        NM_DBUS_SERVICE,
        NM_DBUS_PATH_SETTINGS,
        NM_DBUS_INTERFACE_SETTINGS,
        QDBusConnection::systemBus());


  Connection settings;

  // Call ListConnections D-Bus method
  interface.call("RequestScan");
  QDBusReply<QList<QDBusObjectPath> > result = interface.call("ListConnections");

  int now = std::time(nullptr);;

  foreach (const QDBusObjectPath& connection, result.value()) {

    QString settingsPath=connection.path();

    QDBusInterface setting(NM_DBUS_SERVICE, settingsPath,
                           NM_DBUS_INTERFACE_SETTINGS_CONNECTION, QDBusConnection::systemBus());
    QDBusMessage result = setting.call("GetSettings");
    const QDBusArgument &dbusArg = result.arguments().at(0).value<QDBusArgument>();
    Connection connection2;
    dbusArg >> connection2;

    if (connection2["connection"]["type"].toString()=="802-11-wireless")
    {
      data_.push_back(connection2["connection"]["id"].toString());
      uuid_.push_back(connection2["connection"]["uuid"].toString());

      if (connection2["connection"]["timestamp"].toInt()> (now -60*5))
      {
        known_.push_back(true);
      }
      else
        known_.push_back(false);
    }

  }



}

