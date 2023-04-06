// StatChart.cpp

#include "statchart.h"
#include <QPainter>
#include <math.h>
#include <iomanip>
#include <sstream>


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
  m_y_max=m_y_step*std::ceil((double)(m_y_max/m_y_step));

  std::pair<std::pair<QColor,QColor>,
      std::pair<std::vector<double>,std::vector<double>>> p;
  p.first.first=color;
  p.first.second=fill_color;
  p.second.first=px;
  p.second.second=py;
  lines.push_back(p);


  update();
}


QPointF StatChart::conv(qreal x, qreal y)
{
  qreal margin=(1.0-m_border)/2.0;

  qreal xx=width()*(margin+m_border*x);
  qreal yy=height()-height()*(margin+m_border*y);
  return QPointF(xx,yy);
}

void StatChart::drawGrid(QPainter *painter, QColor color)
{
  m_y_max=m_y_step*std::ceil((double)(m_y_max/m_y_step));
  if (m_y_max<=m_y_min)
    m_y_max=m_y_min+m_y_step;

  /* Painting StatChart path*/
  painter->setRenderHints(QPainter::Antialiasing, true);
  painter->setPen(QPen(color, 6, Qt::SolidLine,
                       Qt::RoundCap, Qt::RoundJoin));
  painter->setBrush(QBrush(Qt::transparent));
  painter->setOpacity(1.0);

  for (qreal x=m_x_min;x<=m_x_max;x+=m_x_step)
  {
    QLineF line(conv((x-m_x_min)/(m_x_max-m_x_min),0),conv((x-m_x_min)/(m_x_max-m_x_min),1));
    painter->setPen(QPen(color, 1, Qt::SolidLine, Qt::RoundCap));
    painter->drawLine(line);

    std::stringstream stream;
    stream << std::fixed << std::setprecision(m_digit_x) << x;
    std::string str = stream.str();

//    std::string str=std::to_string(std::round(x * std::pow(10,m_digit_x)) / std::pow(10,m_digit_x));
    painter->drawText(QPointF(line.x1(),height()),QString().fromStdString(str));
  }

  for (qreal y=m_y_min;y<=m_y_max;y+=m_y_step)
  {
    QLineF line(conv(0,y/(m_y_max-m_y_min)),conv(1,y/(m_y_max-m_y_min)));
    painter->setPen(QPen(color, 1, Qt::SolidLine, Qt::RoundCap));
    painter->drawLine(line);

    std::stringstream stream;
    stream << std::fixed << std::setprecision(m_digit_y) << y;
    std::string str = stream.str();
    //std::string str=std::to_string(std::round(y * std::pow(10,m_digit_y)) / std::pow(10,m_digit_y));
    painter->drawText(QPointF(0,line.y1()),QString().fromStdString(str));
  }

}

void StatChart::paint(QPainter *painter)
{

  for (size_t idx=0;idx<lines.size();idx++)
  {

    const std::pair<std::pair<QColor,QColor>,
        std::pair<std::vector<double>,std::vector<double>>>& p= lines.at(idx);

    const std::vector<double>& x=p.second.first;
    const std::vector<double>& y=p.second.second;
    QColor color=p.first.first;
    QColor fill_color=p.first.second;

    QPainterPath areapath;

    areapath.setFillRule(Qt::OddEvenFill);
    areapath.moveTo(conv((x.at(0)-m_x_min)/(m_x_max-m_x_min),(y.at(0)-m_y_min)/(m_y_max-m_y_min)));
    for(size_t i=1; i < x.size(); i++)
    {
      areapath.lineTo(conv((x.at(i)-m_x_min)/(m_x_max-m_x_min),(y.at(i)-m_y_min)/(m_y_max-m_y_min)));
    }


    /* Painting StatChart path*/
    painter->setRenderHints(QPainter::Antialiasing, true);
    painter->setPen(QPen(color, 6, Qt::SolidLine,
                         Qt::RoundCap, Qt::RoundJoin));
    painter->setBrush(QBrush(Qt::transparent));
    //    painter->setBrush(QColor("red"));
    painter->setOpacity(1.0);
    painter->drawPath(areapath);

    QPolygonF polygon;
    for(size_t i=0; i < x.size(); i++)
    {
      m_y_max=std::max(m_y_max,y[idx]);
      polygon << conv((x.at(i)-m_x_min)/(m_x_max-m_x_min),(y.at(i)-m_y_min)/(m_y_max-m_y_min));
    }
    polygon << conv((x.back()-m_x_min)/(m_x_max-m_x_min),0);
    polygon << conv((x.at(0)-m_x_min)/(m_x_max-m_x_min),0);
    polygon << conv((x.at(0)-m_x_min)/(m_x_max-m_x_min),(y.at(0)-m_y_min)/(m_y_max-m_y_min));
    painter->setBrush(QBrush(fill_color));
    painter->setPen(QPen(Qt::transparent, 1, Qt::SolidLine,
                         Qt::RoundCap, Qt::RoundJoin));
    painter->drawPolygon(polygon,Qt::WindingFill);
    painter->setBrush(QBrush(Qt::transparent));


  }


  drawGrid(painter,m_grid_color);
}
