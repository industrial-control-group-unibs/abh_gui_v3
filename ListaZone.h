#ifndef LISTAZONE_H
#define LISTAZONE_H


#include <QAbstractListModel>
#include <QColor>

struct Zona {
    Zona() {}
    Zona( const QString& ex_name, const QString& image_name)
        : ex_name_(ex_name), image_name_(image_name) {}
    QString ex_name_;
    QString image_name_;
};

class ListaZona : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        NameRole = Qt::UserRole,
        ImageRole,
        PathRole
    };

    explicit ListaZona(QObject *parent = nullptr);

    int rowCount(const QModelIndex& parent) const override;
    QVariant data( const QModelIndex& index, int role = Qt::DisplayRole ) const override;
    QHash<int, QByteArray> roleNames() const override;


public slots:
    void readFile(QString string);


private: //members
    QVector< Zona > data_;
    std::string dir_path_;
    QString path_;
};


#endif // LISTAZONE_H
