#ifndef LISTACSV_H
#define LISTACSV_H


#include <QAbstractListModel>
#include "ListStringQueue.h"
#include <QColor>

#include <QDebug>

class ListStringCSV : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        VectorRole = Qt::UserRole
    };

    explicit ListStringCSV(QString path, QObject *parent = nullptr);

    int rowCount(const QModelIndex& parent) const override;
    QVariant data( const QModelIndex& index, int role = Qt::DisplayRole ) const override;
    QHash<int, QByteArray> roleNames() const override;




public slots:
    void readFile(QString filename);
    bool rename(QString oldname, QString newname, bool replace=false);
    void appendIcon(bool flag){      append_=flag;    }
    void addRow(QString filename, QStringList row);
    void removeRow(QString filename, int row_idx);
    void removeRowByName(QString filename, QString name);

    void changeValue(QString filename, int row_idx,int col_idx, QString value);
    QStringList uniqueElementsOfColumn(QString filename, QString col_name);
    QString getValue(QString filename, int row_idx,int col_idx);
    QString getValue(int row_idx,int col_idx);

    bool checkIfExistColumn(QString filename, int col_idx, QString value);

    // return row index
    int getRowIndex(QString filename,int col_idx,QString value);
private: //members
    QVector< QStringList > data_;
    std::string dir_path_;
    QString path_;
    bool append_;
};


#endif // LISTAESERCIZI_H
