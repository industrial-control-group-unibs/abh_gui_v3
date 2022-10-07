// areachart.cpp

#include "areachart.h"
#include <QPainter>
using namespace std;

//vector<int> xpos({0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110,115,120,125,130,135,140,145,150,155,160,165,170,175,180,185,190,195});
//vector<int> ypos({140,150,140,170,160,160,170,190,220,140,150,150,190,170,160,180,160,150,170,180,140,150,130,170,140,150,170,190,180,160,150,150,190,150,170,180,160,150,170,200});

//#define X_SHIFT  20
//#define X_AXIS_YCOR 200

AreaChart::AreaChart(QQuickItem *parent)
  : QQuickPaintedItem(parent)
{
  m_chdata = 0;
  decimantion=20;
  idec=0;
  x.resize(1000);
  y.resize(1000);

  recompute();

}

void AreaChart::recompute()
{
  width_=width();
  height_=height();
  for (size_t idx=0;idx<x.size();idx++)
  {
    x.at(idx)=double(width())*double(idx)/double(x.size());
    y.at(idx)=height()*.5;
  }
}

qreal AreaChart::chdata() const
{
  return m_chdata;
}

qreal AreaChart::max() const
{
  return m_max;
}

QColor AreaChart::color() const
{
  return m_color;
}
void AreaChart::setColor(const QColor& c)
{
  m_color=c;
}


void AreaChart::setchdata(const qreal &chdata)
{
  if(idec++ == decimantion)
  {
    idec=0;
    m_chdata = chdata;
    update();
    emit chdataChanged();
  }

}

void AreaChart::setMax(const qreal &max)
{
  m_max=max;
}

void AreaChart::paint(QPainter *painter)
{

  if (width_!=width() or height_!=height())
  {

    recompute();
  }

  std::rotate(y.begin(),y.begin()+1,y.end()); /*Rotating the plot points everytime when update() is called.*/
  y.back()=height()*0.5*(1-m_chdata/m_max);

  QPainterPath areapath;

  areapath.setFillRule(Qt::OddEvenFill);
  areapath.moveTo(x.at(0),y.at(0));
  for(size_t i=1; i < x.size(); i++)
  {
    areapath.lineTo(x.at(i)/*+X_SHIFT*/,y.at(i));
  }

  /* Painting areachart path*/
  painter->setRenderHints(QPainter::Antialiasing, true);
  painter->setPen(QPen(m_color, 2, Qt::SolidLine,
                       Qt::RoundCap, Qt::RoundJoin));
  //    painter->setBrush(QColor("red"));
  painter->setOpacity(0.5);
  painter->drawPath(areapath);
}
