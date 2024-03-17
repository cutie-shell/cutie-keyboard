import QtQuick
import QtQuick.Controls
import Cutie

CutieButton {
    id: root
    font.pixelSize: 24
    palette.buttonText: Atmosphere.textColor

    icon.name: mainView.isDialPad && root.text == "\u21B5" ? "call-start-symbolic" : ""
    icon.height: height * 0.8
    icon.width: height * 0.8
    icon.color: "white"

    background: Rectangle {
        id: backgroundRect
        anchors.fill: parent
        radius: mainView.isDialPad ? 25 : 5
        color: mainView.isDialPad && icon.name == "call-start-symbolic" ? "green" : Atmosphere.primaryColor
        border.color: Atmosphere.secondaryColor
        border.width: 1
        Rectangle {
            anchors.fill: parent
            radius: 5
            color: root.checked ? Atmosphere.accentColor : Atmosphere.secondaryColor
            opacity: if(root.text == "\u21E6" || 
                            root.text == "\u21E5" || 
                            root.text == "\u21B5" || 
                            root.text == "\u21E7" &&
                            mainView.inputMgr.purpose != 4) {
                        root.pressed || root.checked ? 1 : .5
                    } else {
                        root.pressed || root.checked ? .75 : 0
                    }
        }
    }
}