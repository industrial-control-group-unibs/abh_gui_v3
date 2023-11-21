#ifndef LISTAUTENTI_H
#define LISTAUTENTI_H


#include <QAbstractListModel>
#include <QColor>
#include <memory>
struct Utente {
    Utente() {}
    Utente( const std::vector<QString>& fields)
        : fields_(fields){}
    std::vector<QString> fields_;
};

class ListaUtenti : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
      Role_nome = Qt::UserRole,
      Role_id,
      Role_cognome,
      Role_data_nascita ,
      Role_peso ,
      Role_altezza  ,
      Role_mail,
      Role_telefono,
      Role_indirizzo,
      Role_professione    ,
      Role_social_media  ,
      Role_stato,
      Role_foto,
      Role_coloreBordo,
      Role_coloreSfondo,
      Role_coloreUtente,
      Role_coloreLed,
      Role_password,
      Role_storePwd,
      Role_Workout
    };


    explicit ListaUtenti(QString path,
                         std::string template_path,
                         QObject *parent = nullptr);

    int rowCount(const QModelIndex& parent) const override;
    QVariant data( const QModelIndex& index, int role = Qt::DisplayRole ) const override;
    QHash<int, QByteArray> roleNames() const override;

    void setDefaultColor(QStringList default_colors);


public slots:
    void readFile();
    void removeUser(QString identifier);
    QString addUser(std::vector<QString> dati);
    void editUser(QString identifier, QVector<QString> dati);
    QVector<QString> getUser(QString identifier);
    void saveColor(QString identifier, QString coloreBordo, QString coloreSfondo, QString coloreUtente, QString coloreLed);
    void savePassword(QString identifier, QString pwd);
    QString getPassword(QString identifier);

    void saveStorePassword(QString identifier, QString store_pwd);
    bool getStorePassword(QString identifier);


    void saveWorkout(QString identifier, QString workout);
    QString getWorkout(QString identifier);

    void createStatFile(QString user_id);
private: //members
    QVector< Utente > data_;
    std::string dir_path_;
    std::string template_path_;
    QString path_;
    int roles_;
    QStringList default_colors_;
};


#endif // LISTAZONE_H
