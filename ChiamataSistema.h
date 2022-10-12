#ifndef CHIAMATA_SISTEMA
#define CHIAMATA_SISTEMA

#include <QObject>
#include <QString>

class SysCall : public QObject
{
  Q_PROPERTY(QString string  READ string  WRITE setString NOTIFY stringChanged)
  Q_OBJECT
public:
  explicit SysCall(QObject *parent = nullptr);

  QString string() const;
  void setString(QString string);

public slots:
  void call();

signals:
  void portChanged();
  void hostChanged();
  void stringChanged();
protected:
  QString string_;

};


#endif // QML_TCP_REC
