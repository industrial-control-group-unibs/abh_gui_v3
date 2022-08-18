#ifndef LISTAESERCIZI_H
#define LISTAESERCIZI_H


#include <QAbstractListModel>
#include <QColor>

struct Data {
    Data() {}
    Data( const QString& ex_name/*, const QString& ex_code, const QString& image_name*/)
        : ex_name_(ex_name)/*, ex_code_(ex_code), image_name_(image_name)*/ {}
    QString ex_name_;
    QString ex_code_;
    QString image_name_;
};

class ListaEsercizi : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        NameRole = Qt::UserRole,
//        CodeRole,
//        ImageRole,
        PathRole
    };

    explicit ListaEsercizi(QObject *parent = nullptr);

    int rowCount(const QModelIndex& parent) const override;
    QVariant data( const QModelIndex& index, int role = Qt::DisplayRole ) const override;
    QHash<int, QByteArray> roleNames() const override;


public slots:
    void readFile(QString string);


private: //members
    QVector< Data > data_;
    std::string dir_path_;
    QString path_;
};


#endif // LISTAESERCIZI_H
