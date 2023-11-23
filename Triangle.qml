import QtQuick
import QtQuick.Shapes

Shape {
    id: root
    ShapePath {
        strokeWidth: 3
        strokeColor: "black"
        fillColor: "black"
        startX: 0; startY: 0
        PathLine { x: root.width / 2; y: root.width / 2}
        PathLine { x: root.width; y: 0 }
        PathLine { x: 0; y: 0 }
    }
}
