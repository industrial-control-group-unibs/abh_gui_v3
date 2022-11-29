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
  QString top       () const {return front_;}
public slots:
  void push(QString string);
  void pop();

signals:
  void topChanged();
protected:
  std::queue<QString> queue_;
  QString front_;
};
#endif
