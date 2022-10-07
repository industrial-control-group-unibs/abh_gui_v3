// areachart.h

#ifndef AREACHART_H
#define AREACHART_H
#include <QtQuick/QQuickPaintedItem>
class AreaChart : public QQuickPaintedItem
{
  Q_OBJECT
  Q_PROPERTY(qreal chdata READ chdata WRITE setchdata NOTIFY chdataChanged)
  Q_PROPERTY(qreal max READ max WRITE setMax NOTIFY maxChanged)
  Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)
public:
  AreaChart(QQuickItem *parent = 0);

  qreal chdata() const;
  void setchdata(const qreal &chdata);

  qreal max() const;
  void setMax(const qreal& max);


  QColor color() const;
  void setColor(const QColor& c);


  void paint(QPainter *painter);
signals:
  void chdataChanged();
  void maxChanged();
  void colorChanged();
private:
  QColor m_color;
  qreal m_chdata;
  qreal m_max;
  std::vector<double> x;
  std::vector<double> y;
  int decimantion;
  int idec;

  void recompute();
  qreal width_;
  qreal height_;
};
#endif
