#ifndef LISTAQUEUE_H
#define LISTAQUEUE_H


#include <QAbstractListModel>
#include <QColor>


class ListString : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        VectorRole = Qt::UserRole
    };

    explicit ListString(QObject *parent = nullptr);

    void appendIcon(bool flag){append_=flag;}
    int rowCount(const QModelIndex& parent) const override;
    QVariant data( const QModelIndex& index, int role = Qt::DisplayRole ) const override;
    QHash<int, QByteArray> roleNames() const override;


public slots:
    void fromList(QList<QStringList> data);
    void addRow(    QStringList row);
    void removeRow(  int row_idx);
    void changeValue(int row_idx,int col_idx, QString value);
    QString getValue(int row_idx,int col_idx);
    bool checkIfExistColumn(int col_idx, QString value);
private: //members
    QVector< QStringList > data_;
    bool append_;
};


#endif // LISTAESERCIZI_H
