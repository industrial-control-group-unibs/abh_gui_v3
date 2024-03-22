import QtGraphicalEffects 1.12
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.1

IconaRettangolo
{

    id:component

    property string image

    property string name: ""

    Titolo
    {
        text:component.name
        fontSize: 30
        z: 20
    }
    Image {
        id: immagine1
        fillMode: Image.Stretch
        visible: true
        z: component.z-2
        mipmap: true
        asynchronous: true
        anchors
        {
            fill: parent
            margins: component.margin
        }
        source: component.image

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Item {
                width: immagine1.width
                height: immagine1.height
                Rectangle {
                    anchors.fill: parent
                    radius: component.radius-0*component.bordo-component.margin
                }
            }
        }
    }


}
