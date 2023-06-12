#ifndef LISTWIFI_H
#define LISTWIFI_H


///////////////////////7
#include <QtDBus/QDBusConnection>
#include <QtDBus/QDBusInterface>
#include <QtDBus/QDBusMetaType>
#include <QtDBus/QDBusReply>
#include <QtCore/QList>
#include <QtCore/QMap>
#include <QtCore/QString>
#include <QtCore/QDebug>
#include <QtNetwork/QHostAddress>
#include <arpa/inet.h>

#include <nm-dbus-interface.h>


#include <QAbstractListModel>
#include <QColor>

typedef QMap<QString, QVariantMap> Connection;
Q_DECLARE_METATYPE(Connection)
Q_DECLARE_METATYPE(QList<uint>);
Q_DECLARE_METATYPE(QList<QList<uint> >);

const QString NM_SETTING_CONNECTION_SETTING_NAME = "connection";
const QString NM_SETTING_CONNECTION_ID = "id";
const QString NM_SETTING_CONNECTION_UUID = "uuid";


class ListaWifi : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
      Role_nome = Qt::UserRole,
      Role_uuid
    };

    explicit ListaWifi(QObject *parent = nullptr);

    int rowCount(const QModelIndex& parent) const override;
    QVariant data( const QModelIndex& index, int role = Qt::DisplayRole ) const override;
    QHash<int, QByteArray> roleNames() const override;


public slots:
    void readList();


private: //members
    QVector< QString > data_;
    QVector< QString > uuid_;
    int roles_;
};




#endif // LISTWIFI_H
