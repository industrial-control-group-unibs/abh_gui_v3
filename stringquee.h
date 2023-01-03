#ifndef STRINGQUEE_H
#define STRINGQUEE_H

#include <QObject>
#include <queue>
class StringQuee: public QObject
{
  Q_OBJECT
  Q_PROPERTY(QString         top           READ    top                             NOTIFY topChanged)



public:
  StringQuee();
  QString top       () const {return data.front();}
public slots:
  void push(QString string);
  QString pop();

signals:
  void topChanged();
protected:
  QStringList data;
  int max_size=10;
};
#endif
