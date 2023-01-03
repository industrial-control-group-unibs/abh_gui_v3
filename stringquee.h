#ifndef STRINGQUEE_H
#define STRINGQUEE_H

#include <QObject>
#include <queue>
class StringQuee: public QObject
{
  Q_OBJECT
  //Q_PROPERTY(QString         top           READ    front                             NOTIFY topChanged)



public:
  StringQuee();
public slots:
  QString front       () const ;
  void push(QString string);
  QString pop();

//signals:
//  void topChanged();
protected:
  QStringList data;
  int max_size=10;
};
#endif
