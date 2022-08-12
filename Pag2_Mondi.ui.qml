
//Generated by FigmaQML
import QtGraphicalEffects 1.0
import QtQuick 2.12
import QtQuick.Shapes 1.0

Rectangle {
    id: figma_0_31
    objectName: "Mondi"
    x: 0
    y: 0
    width: 600
    height: 1000
    color: "#ff000000"
    clip: true
    // QML (SVG) supports only center borders, thus an extra mask is created for INSIDE
    Item {
        id: figma_0_32
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

        MouseArea {
            anchors.fill: parent
            onClicked: swipeView.currentIndex = swipeView.currentIndex + 1
        }
        Shape {
            id: borderSource_figma_0_32
            anchors.fill: parent
            visible: false
            ShapePath {
                joinStyle: ShapePath.MiterJoin
                strokeColor: "#ffecf10f"
                strokeWidth: 10
                fillColor: "#ff060606"
                id: svgpath_figma_0_32
                fillRule: ShapePath.WindingFill
                PathSvg {
                    path: "M200 100C200 155.228 155.228 200 100 200C44.7715 200 0 155.228 0 100C0 44.7715 44.7715 0 100 0C155.228 0 200 44.7715 200 100Z"
                }
            }
        }
        Shape {
            id: borderMask_figma_0_32
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
            source: borderSource_figma_0_32
            maskSource: borderMask_figma_0_32
        }
    }
    // QML (SVG) supports only center borders, thus an extra mask is created for INSIDE
    Item {
        id: figma_0_33
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
            id: borderSource_figma_0_33
            anchors.fill: parent
            visible: false
            ShapePath {
                joinStyle: ShapePath.MiterJoin
                strokeColor: "#ff0ff126"
                strokeWidth: 10
                fillColor: "#ff000000"
                id: svgpath_figma_0_33
                fillRule: ShapePath.WindingFill
                PathSvg {
                    path: "M200 100C200 155.228 155.228 200 100 200C44.7715 200 0 155.228 0 100C0 44.7715 44.7715 0 100 0C155.228 0 200 44.7715 200 100Z"
                }
            }
        }
        Shape {
            id: borderMask_figma_0_33
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
            source: borderSource_figma_0_33
            maskSource: borderMask_figma_0_33
        }
    }
    // QML (SVG) supports only center borders, thus an extra mask is created for INSIDE
    Item {
        id: figma_0_34
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
            id: borderSource_figma_0_34
            anchors.fill: parent
            visible: false
            ShapePath {
                joinStyle: ShapePath.MiterJoin
                strokeColor: "#fff17b0f"
                strokeWidth: 10
                fillColor: "#ff000000"
                id: svgpath_figma_0_34
                fillRule: ShapePath.WindingFill
                PathSvg {
                    path: "M150 75C150 116.421 116.421 150 75 150C33.5786 150 0 116.421 0 75C0 33.5786 33.5786 0 75 0C116.421 0 150 33.5786 150 75Z"
                }
            }
        }
        Shape {
            id: borderMask_figma_0_34
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
            source: borderSource_figma_0_34
            maskSource: borderMask_figma_0_34
        }
    }
    // QML (SVG) supports only center borders, thus an extra mask is created for INSIDE
    Item {
        id: figma_0_35
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
            id: borderSource_figma_0_35
            anchors.fill: parent
            visible: false
            ShapePath {
                joinStyle: ShapePath.MiterJoin
                strokeColor: "#ff2f0ff1"
                strokeWidth: 10
                fillColor: "#ff060606"
                id: svgpath_figma_0_35
                fillRule: ShapePath.WindingFill
                PathSvg {
                    path: "M200 100C200 155.228 155.228 200 100 200C44.7715 200 0 155.228 0 100C0 44.7715 44.7715 0 100 0C155.228 0 200 44.7715 200 100Z"
                }
            }
        }
        Shape {
            id: borderMask_figma_0_35
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
            source: borderSource_figma_0_35
            maskSource: borderMask_figma_0_35
        }
    }
    Text {
        id: figma_0_36
        objectName: "Meditazione"
        x: 61
        y: 730
        width: 168
        height: 130
        color: "#ff2f0ff1"
        wrapMode: TextEdit.WordWrap
        text: "Meditazione"
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
        id: figma_0_37
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
            id: borderSource_figma_0_37
            anchors.fill: parent
            visible: false
            ShapePath {
                joinStyle: ShapePath.MiterJoin
                strokeColor: "#fff10fda"
                strokeWidth: 10
                fillColor: "#ff060606"
                id: svgpath_figma_0_37
                fillRule: ShapePath.WindingFill
                PathSvg {
                    path: "M200 100C200 155.228 155.228 200 100 200C44.7715 200 0 155.228 0 100C0 44.7715 44.7715 0 100 0C155.228 0 200 44.7715 200 100Z"
                }
            }
        }
        Shape {
            id: borderMask_figma_0_37
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
            source: borderSource_figma_0_37
            maskSource: borderMask_figma_0_37
        }
    }
    Text {
        id: figma_0_38
        objectName: "EXTRA"
        x: 375
        y: 727
        width: 168
        height: 130
        color: "#fff10fda"
        wrapMode: TextEdit.WordWrap
        text: "EXTRA"
        font.family: "MS Shell Dlg 2"
        font.italic: false
        font.letterSpacing: 0
        font.pixelSize: 24
        font.weight: Font.Normal
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    Text {
        id: figma_0_39
        objectName: "Nutrizione"
        x: 375
        y: 180
        width: 168
        height: 130
        color: "#ff0ff126"
        wrapMode: TextEdit.WordWrap
        text: "Nutrizione"
        font.family: "MS Shell Dlg 2"
        font.italic: false
        font.letterSpacing: 0
        font.pixelSize: 24
        font.weight: Font.Normal
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    Text {
        id: figma_0_40
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
        id: figma_0_41
        objectName: "PROFILO"
        x: 225
        y: 432
        width: 150
        height: 150
        color: "#fff17b0f"
        wrapMode: TextEdit.WordWrap
        text: "PROFILO"
        font.family: "MS Shell Dlg 2"
        font.italic: false
        font.letterSpacing: 0
        font.pixelSize: 18
        font.weight: Font.Normal
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
