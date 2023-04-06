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
    void drawGrid(QPainter *painter, QColor color);
    void setYmax(double y_max){m_y_max=y_max;}
    void setXmax(double x_max){m_x_max=x_max;}
    void setYmin(double y_min){m_y_min=y_min;}
    void setXmin(double x_min){m_x_min=x_min;}
    void setYStep(double y_step){m_y_step=y_step;}
    void setXStep(double x_step){m_x_step=x_step;}
    void setGridColor(QColor color){m_grid_color=color;}
    void setBorder(double border){m_border=border;}
private:
    qreal m_x_max=0.0;
    qreal m_y_max=0.0;
    qreal m_x_min=0.0;
    qreal m_y_min=0.0;
    qreal m_x_step=1.0;
    qreal m_y_step=1.0;
    qreal m_border=0.85;
    QColor m_grid_color;
    int m_digit_x=0;
    int m_digit_y=1;
  std::vector<std::pair<std::pair<QColor,QColor>,
              std::pair<std::vector<double>,std::vector<double>>>> lines;

  QPointF conv(qreal x, qreal y);

};
#endif
