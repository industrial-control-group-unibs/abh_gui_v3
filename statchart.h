// StatChart.h

#ifndef StatChart_H
#define StatChart_H
#include <QtQuick/QQuickPaintedItem>
class StatChart : public QQuickPaintedItem
{
  Q_OBJECT
public:
  StatChart(QQuickItem *parent = 0);



  public slots:
    void paint(QPainter *painter);
    void addLine(QVector<double> x,QVector<double> y, QColor color, QColor fill_color);
    void setYmax(double y_max){m_y_max=y_max;}
    void setXmax(double x_max){m_x_max=x_max;}
private:
  qreal m_x_max=0.0;
  qreal m_y_max=0.0;

  std::vector<std::pair<std::pair<QColor,QColor>,
              std::pair<std::vector<double>,std::vector<double>>>> lines;

};
#endif
