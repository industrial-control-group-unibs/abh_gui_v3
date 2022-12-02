#ifndef LISTAUTENTI_H
#define LISTAUTENTI_H


#include <QAbstractListModel>
#include <QColor>

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
      Role_coloreUtente
    };

    explicit ListaUtenti(QString path, QObject *parent = nullptr);

    int rowCount(const QModelIndex& parent) const override;
    QVariant data( const QModelIndex& index, int role = Qt::DisplayRole ) const override;
    QHash<int, QByteArray> roleNames() const override;



public slots:
    void readFile();
    void removeUser(QString name);
    void addUser(std::vector<QString> dati);
    void saveColor(QString user_name, QString coloreBordo, QString coloreSfondo, QString coloreUtente);


private: //members
    QVector< Utente > data_;
    std::string dir_path_;
    QString path_;
    int roles_;
};


#endif // LISTAZONE_H
