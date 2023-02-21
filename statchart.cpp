// StatChart.cpp

#include "statchart.h"
#include <QPainter>
using namespace std;

StatChart::StatChart(QQuickItem *parent)
  : QQuickPaintedItem(parent)
{
}

void StatChart::addLine(QVector<double> x,QVector<double> y, QColor color, QColor fill_color)
{
  assert(x.size()==y.size());
  std::vector<double> px(x.size());
  std::vector<double> py(x.size());

  for (size_t idx=0;idx<px.size();idx++)
  {
    m_x_max=std::max(m_x_max,x[idx]);
    m_y_max=std::max(m_y_max,y[idx]);
    px.at(idx)=x[idx];
    py.at(idx)=y[idx];
  }

  std::pair<std::pair<QColor,QColor>,
      std::pair<std::vector<double>,std::vector<double>>> p;
  p.first.first=color;
  p.first.second=fill_color;
  p.second.first=px;
  p.second.second=py;
  lines.push_back(p);
  update();
}


void StatChart::paint(QPainter *painter)
{

  qDebug() << "paint" ;
  for (size_t idx=0;idx<lines.size();idx++)
  {
    qDebug() << "line "<<idx ;


    const std::pair<std::pair<QColor,QColor>,
        std::pair<std::vector<double>,std::vector<double>>>& p= lines.at(idx);

    const std::vector<double>& x=p.second.first;
    const std::vector<double>& y=p.second.second;
    QColor color=p.first.first;
    QColor fill_color=p.first.second;

    QPainterPath areapath;

    areapath.setFillRule(Qt::OddEvenFill);
    areapath.moveTo(x.at(0)*width()/m_x_max,(m_y_max-y.at(0))*height()/m_y_max);
    for(size_t i=1; i < x.size(); i++)
    {
      areapath.lineTo(x.at(i)*width()/m_x_max,(m_y_max-y.at(i))*height()/m_y_max);
    }


    /* Painting StatChart path*/
    painter->setRenderHints(QPainter::Antialiasing, true);
    painter->setPen(QPen(color, 6, Qt::SolidLine,
                         Qt::RoundCap, Qt::RoundJoin));
    painter->setBrush(QBrush(Qt::transparent));
    //    painter->setBrush(QColor("red"));
    painter->setOpacity(1.0);
    painter->drawPath(areapath);

    QPolygon polygon;
    for(size_t i=0; i < x.size(); i++)
    {
      polygon << QPoint(x.at(i)*width()/m_x_max,(m_y_max-y.at(i))*height()/m_y_max);
    }
    polygon << QPoint(x.back()*width()/m_x_max, height());
    polygon << QPoint(x.at(0)*width()/m_x_max, height());
    polygon << QPoint(x.at(0)*width()/m_x_max, (m_y_max-y.at(0))*height()/m_y_max);
    painter->setBrush(QBrush(fill_color));
    painter->setPen(QPen(Qt::transparent, 1, Qt::SolidLine,
                         Qt::RoundCap, Qt::RoundJoin));
    painter->drawPolygon(polygon,Qt::WindingFill);
    painter->setBrush(QBrush(Qt::transparent));


  }
}
