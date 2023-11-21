#ifndef LISTADATIUTENTI_H
#define LISTADATIUTENTI_H


#include <QAbstractListModel>
#include <rapidcsv.h>
#include <QColor>

#include <QDebug>
#include <memory>

class ListUserConfig  : public QObject
{
  Q_OBJECT

public:

    explicit ListUserConfig(QString path, QObject *parent = nullptr);

signals:
  void updated();

public slots:
    void readFile(QString filename);
    bool setValue(QString field, QString value);
    QString getValue(QString field);

private: //members
    std::shared_ptr<rapidcsv::Document> doc_;
    std::string dir_path_;
    QString path_;
    std::string  nome_file;

    int changed_;
};


#endif // LISTAESERCIZI_H
