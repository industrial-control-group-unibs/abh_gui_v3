
//Generated by FigmaQML
import QtGraphicalEffects 1.0
import QtQuick 2.12
import QtQuick.Shapes 1.0

Rectangle {
    id: figma_0_62
    objectName: "Esercizi"
    x: 0
    y: 0
    width: 600
    height: 1000
    color: "#ff000000"
    clip: true
    // QML (SVG) supports only center borders, thus an extra mask is created for INSIDE
    Item {
        id: figma_0_63
        objectName: "Ellipse 1"
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 4
            radius: 4
            samples: 17
            color: "#40000000"
        }
        x: 45
        y: 145
        width: 200
        height: 200
        Shape {
            id: borderSource_figma_0_63
            anchors.fill: parent
            visible: false
            ShapePath {
                joinStyle: ShapePath.MiterJoin
                strokeColor: "#ffecf10f"
                strokeWidth: 10
                fillColor: "#ff000000"
                id: svgpath_figma_0_63
                fillRule: ShapePath.WindingFill
                PathSvg {
                    path: "M200 100C200 155.228 155.228 200 100 200C44.7715 200 0 155.228 0 100C0 44.7715 44.7715 0 100 0C155.228 0 200 44.7715 200 100Z"
                }
            }
        }
        Shape {
            id: borderMask_figma_0_63
            anchors.fill: parent
            layer.enabled: true
            visible: false
            ShapePath {
                fillColor: "black"
                strokeColor: "transparent"
                strokeWidth: 0
                joinStyle: ShapePath.MiterJoin
                fillRule: ShapePath.WindingFill
                PathSvg {
                    path: "M200 100C200 155.228 155.228 200 100 200C44.7715 200 0 155.228 0 100C0 44.7715 44.7715 0 100 0C155.228 0 200 44.7715 200 100Z"
                }
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: swipeView.currentIndex = swipeView.currentIndex + 1
        }
        OpacityMask {
            anchors.fill: parent
            source: borderSource_figma_0_63
            maskSource: borderMask_figma_0_63
        }
    }
    // QML (SVG) supports only center borders, thus an extra mask is created for INSIDE
    Item {
        id: figma_0_64
        objectName: "Ellipse 2"
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 4
            radius: 4
            samples: 17
            color: "#40000000"
        }
        x: 357
        y: 145
        width: 200
        height: 200
        Shape {
            id: borderSource_figma_0_64
            anchors.fill: parent
            visible: false
            ShapePath {
                joinStyle: ShapePath.MiterJoin
                strokeColor: "#ffecf10f"
                strokeWidth: 10
                fillColor: "#ff000000"
                id: svgpath_figma_0_64
                fillRule: ShapePath.WindingFill
                PathSvg {
                    path: "M200 100C200 155.228 155.228 200 100 200C44.7715 200 0 155.228 0 100C0 44.7715 44.7715 0 100 0C155.228 0 200 44.7715 200 100Z"
                }
            }
        }
        Shape {
            id: borderMask_figma_0_64
            anchors.fill: parent
            layer.enabled: true
            visible: false
            ShapePath {
                fillColor: "black"
                strokeColor: "transparent"
                strokeWidth: 0
                joinStyle: ShapePath.MiterJoin
                fillRule: ShapePath.WindingFill
                PathSvg {
                    path: "M200 100C200 155.228 155.228 200 100 200C44.7715 200 0 155.228 0 100C0 44.7715 44.7715 0 100 0C155.228 0 200 44.7715 200 100Z"
                }
            }
        }
        OpacityMask {
            anchors.fill: parent
            source: borderSource_figma_0_64
            maskSource: borderMask_figma_0_64
        }
    }
    // QML (SVG) supports only center borders, thus an extra mask is created for INSIDE
    Item {
        id: figma_0_65
        objectName: "Ellipse 3"
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 4
            radius: 4
            samples: 17
            color: "#40000000"
        }
        x: 225
        y: 434
        width: 150
        height: 150
        Shape {
            id: borderSource_figma_0_65
            anchors.fill: parent
            visible: false
            ShapePath {
                joinStyle: ShapePath.MiterJoin
                strokeColor: "#fff17b0f"
                strokeWidth: 10
                fillColor: "#ff000000"
                id: svgpath_figma_0_65
                fillRule: ShapePath.WindingFill
                PathSvg {
                    path: "M150 75C150 116.421 116.421 150 75 150C33.5786 150 0 116.421 0 75C0 33.5786 33.5786 0 75 0C116.421 0 150 33.5786 150 75Z"
                }
            }
        }
        Shape {
            id: borderMask_figma_0_65
            anchors.fill: parent
            layer.enabled: true
            visible: false
            ShapePath {
                fillColor: "black"
                strokeColor: "transparent"
                strokeWidth: 0
                joinStyle: ShapePath.MiterJoin
                fillRule: ShapePath.WindingFill
                PathSvg {
                    path: "M150 75C150 116.421 116.421 150 75 150C33.5786 150 0 116.421 0 75C0 33.5786 33.5786 0 75 0C116.421 0 150 33.5786 150 75Z"
                }
            }
        }
        OpacityMask {
            anchors.fill: parent
            source: borderSource_figma_0_65
            maskSource: borderMask_figma_0_65
        }
    }
    // QML (SVG) supports only center borders, thus an extra mask is created for INSIDE
    Item {
        id: figma_0_66
        objectName: "Ellipse 4"
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 4
            radius: 4
            samples: 17
            color: "#40000000"
        }
        x: 45
        y: 698
        width: 200
        height: 200
        Shape {
            id: borderSource_figma_0_66
            anchors.fill: parent
            visible: false
            ShapePath {
                joinStyle: ShapePath.MiterJoin
                strokeColor: "#ffecf10f"
                strokeWidth: 10
                fillColor: "#ff000000"
                id: svgpath_figma_0_66
                fillRule: ShapePath.WindingFill
                PathSvg {
                    path: "M200 100C200 155.228 155.228 200 100 200C44.7715 200 0 155.228 0 100C0 44.7715 44.7715 0 100 0C155.228 0 200 44.7715 200 100Z"
                }
            }
        }
        Shape {
            id: borderMask_figma_0_66
            anchors.fill: parent
            layer.enabled: true
            visible: false
            ShapePath {
                fillColor: "black"
                strokeColor: "transparent"
                strokeWidth: 0
                joinStyle: ShapePath.MiterJoin
                fillRule: ShapePath.WindingFill
                PathSvg {
                    path: "M200 100C200 155.228 155.228 200 100 200C44.7715 200 0 155.228 0 100C0 44.7715 44.7715 0 100 0C155.228 0 200 44.7715 200 100Z"
                }
            }
        }
        OpacityMask {
            anchors.fill: parent
            source: borderSource_figma_0_66
            maskSource: borderMask_figma_0_66
        }
    }
    Text {
        id: figma_0_67
        objectName: "Statistiche"
        x: 61
        y: 730
        width: 168
        height: 130
        color: "#ffecf10f"
        wrapMode: TextEdit.WordWrap
        text: "Statistiche"
        font.family: "MS Shell Dlg 2"
        font.italic: false
        font.letterSpacing: 0
        font.pixelSize: 24
        font.weight: Font.Normal
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    // QML (SVG) supports only center borders, thus an extra mask is created for INSIDE
    Item {
        id: figma_0_68
        objectName: "Ellipse 5"
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 4
            radius: 4
            samples: 17
            color: "#40000000"
        }
        x: 359
        y: 695
        width: 200
        height: 200
        Shape {
            id: borderSource_figma_0_68
            anchors.fill: parent
            visible: false
            ShapePath {
                joinStyle: ShapePath.MiterJoin
                strokeColor: "#ffecf10f"
                strokeWidth: 10
                fillColor: "#ff000000"
                id: svgpath_figma_0_68
                fillRule: ShapePath.WindingFill
                PathSvg {
                    path: "M200 100C200 155.228 155.228 200 100 200C44.7715 200 0 155.228 0 100C0 44.7715 44.7715 0 100 0C155.228 0 200 44.7715 200 100Z"
                }
            }
        }
        Shape {
            id: borderMask_figma_0_68
            anchors.fill: parent
            layer.enabled: true
            visible: false
            ShapePath {
                fillColor: "black"
                strokeColor: "transparent"
                strokeWidth: 0
                joinStyle: ShapePath.MiterJoin
                fillRule: ShapePath.WindingFill
                PathSvg {
                    path: "M200 100C200 155.228 155.228 200 100 200C44.7715 200 0 155.228 0 100C0 44.7715 44.7715 0 100 0C155.228 0 200 44.7715 200 100Z"
                }
            }
        }
        OpacityMask {
            anchors.fill: parent
            source: borderSource_figma_0_68
            maskSource: borderMask_figma_0_68
        }
    }
    Text {
        id: figma_0_69
        objectName: "Community"
        x: 375
        y: 727
        width: 168
        height: 130
        color: "#ffecf10f"
        wrapMode: TextEdit.WordWrap
        text: "Community"
        font.family: "MS Shell Dlg 2"
        font.italic: false
        font.letterSpacing: 0
        font.pixelSize: 24
        font.weight: Font.Normal
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    Text {
        id: figma_0_70
        objectName: "Allenamento Guidato"
        x: 375
        y: 180
        width: 168
        height: 130
        color: "#ffecf10f"
        wrapMode: TextEdit.WordWrap
        text: "Allenamento Guidato"
        font.family: "MS Shell Dlg 2"
        font.italic: false
        font.letterSpacing: 0
        font.pixelSize: 24
        font.weight: Font.Normal
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    Text {
        id: figma_0_71
        objectName: "Esercizi"
        x: 65
        y: 180
        width: 168
        height: 130
        color: "#ffecf10f"
        wrapMode: TextEdit.WordWrap
        text: "Esercizi"
        font.family: "MS Shell Dlg 2"
        font.italic: false
        font.letterSpacing: 0
        font.pixelSize: 24
        font.weight: Font.Normal
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    Text {
        id: figma_0_72
        objectName: "Obiettivi"
        x: 225
        y: 432
        width: 150
        height: 150
        color: "#fff17b0f"
        wrapMode: TextEdit.WordWrap
        text: "Obiettivi"
        font.family: "MS Shell Dlg 2"
        font.italic: false
        font.letterSpacing: 0
        font.pixelSize: 18
        font.weight: Font.Normal
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
