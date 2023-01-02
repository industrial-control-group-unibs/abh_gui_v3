#ifndef LISTAESERCIZI_H
#define LISTAESERCIZI_H


#include <QAbstractListModel>
#include <QColor>

struct EsData {
    EsData() {}
    EsData( const QString& ex_name)
        : ex_name_(ex_name) {}
    QString ex_name_;
};





class ListaEsercizi : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        NameRole = Qt::UserRole,
        PathRole
    };

    explicit ListaEsercizi(QString path, QObject *parent = nullptr);

    int rowCount(const QModelIndex& parent) const override;
    QVariant data( const QModelIndex& index, int role = Qt::DisplayRole ) const override;
    QHash<int, QByteArray> roleNames() const override;


public slots:
    void readFile(QString string);

    void fromList(QStringList list);

private: //members
    QVector< EsData > data_;
    std::string dir_path_;
    QString path_;
};


#endif // LISTAESERCIZI_H
