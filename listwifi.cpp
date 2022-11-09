
#include "listwifi.h"

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
  if ( role == Role_nome ){
    return data;
  }
  else
    return QString();
}


QHash<int, QByteArray> ListaWifi::roleNames() const
{
  static QHash<int, QByteArray> mapping {
    {Role_nome,"nome"}
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
  QDBusReply<QList<QDBusObjectPath> > result = interface.call("ListConnections");

  foreach (const QDBusObjectPath& connection, result.value()) {
    QString settingsPath=connection.path();

    QDBusInterface setting(NM_DBUS_SERVICE, settingsPath,
                           NM_DBUS_INTERFACE_SETTINGS_CONNECTION, QDBusConnection::systemBus());
    QDBusMessage result = setting.call("GetSettings");
    const QDBusArgument &dbusArg = result.arguments().at(0).value<QDBusArgument>();
    Connection connection2;
    dbusArg >> connection2;

    //    qDebug() << "id: " << connection2["connection"]["id"].toString();
    if (connection2["connection"]["type"].toString()=="802-11-wireless")
    {
//      qDebug() << "id: " << connection2["connection"];
      data_.push_back(connection2["connection"]["id"].toString());
    }

  }

}

