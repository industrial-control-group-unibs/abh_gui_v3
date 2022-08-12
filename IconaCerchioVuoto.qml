import QtQuick 2.0
import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1

Item {
        layer.enabled:true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 4
            radius: 4
            samples: 17
            color: "#40000000"
        }


        property string link: "PaginaMondi.qml"


        MouseArea
        {
            anchors.fill: parent
            onClicked: pageLoader.source=  link
        }


        width:125
        height:125
        Shape {
            id:borderSource_figma_10_390
            anchors.fill: parent
            visible: false
            ShapePath {
                joinStyle: ShapePath.MiterJoin
                strokeColor: "#ff2a211c"
                strokeWidth:18
                fillColor:"#ffd4c9bd"
                id: svgpath_figma_10_390
                fillRule: ShapePath.WindingFill
                PathSvg {
                    path: "M125 62.5C125 97.0178 97.0178 125 62.5 125C27.9822 125 0 97.0178 0 62.5C0 27.9822 27.9822 0 62.5 0C97.0178 0 125 27.9822 125 62.5Z"
                }
                }
            }
            Shape {
            id: borderMask_figma_10_390
            anchors.fill:parent
            layer.enabled: true
            visible: false
            ShapePath {
                fillColor: "black"
                strokeColor: "transparent"
                strokeWidth: 0
                joinStyle: ShapePath.MiterJoin
                fillRule: ShapePath.WindingFill
                PathSvg {
                    path: "M125 62.5C125 97.0178 97.0178 125 62.5 125C27.9822 125 0 97.0178 0 62.5C0 27.9822 27.9822 0 62.5 0C97.0178 0 125 27.9822 125 62.5Z"
                }
            }
        }
        OpacityMask {
            anchors.fill:parent
            source: borderSource_figma_10_390
            maskSource: borderMask_figma_10_390
        }

        Shape {
                layer.enabled:true
                layer.effect: DropShadow {
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 4
                    samples: 17
                    color: "#40000000"
                }
                width:83
                height:83
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                ShapePath {
                    strokeColor: "transparent"
                    strokeWidth:9
                    fillColor:"#ff2a211c"
                    id: svgpath_figma_10_391
                    fillRule: ShapePath.WindingFill
                    PathSvg {
                        path: "M83 41.5C83 64.4198 64.4198 83 41.5 83C18.5802 83 0 64.4198 0 41.5C0 18.5802 18.5802 0 41.5 0C64.4198 0 83 18.5802 83 41.5Z"
                    }
                }
            }
    }
