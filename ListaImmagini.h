#ifndef LISTAZONE_H
#define LISTAZONE_H


#include <QAbstractListModel>
#include <QColor>

struct Immagine {
    Immagine() {}
    Immagine( const QString& ex_name, const QString& image_name)
        : ex_name_(ex_name), image_name_(image_name) {}
    QString ex_name_;
    QString image_name_;
};

class ListaImmagini : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        NameRole = Qt::UserRole,
        ImageRole,
        PathRole
    };

    void appendIcon(bool flag){append_=flag;}
    explicit ListaImmagini(QString path, QObject *parent = nullptr);

    int rowCount(const QModelIndex& parent) const override;
    QVariant data( const QModelIndex& index, int role = Qt::DisplayRole ) const override;
    QHash<int, QByteArray> roleNames() const override;

public slots:
    bool readFile(QString string);


private: //members
    QVector< Immagine > data_;
    std::string dir_path_;
    QString path_;
    bool append_;
};


#endif // LISTAZONE_H
