import QtQuick
import QtQuick.Controls
import Cutie
import CutieIM

Item {
    id: mainView
    anchors.fill: parent
    anchors.margins: 5
    focus: false
    
    InputMethodManagerV2{
          id: inputMgr
          objectName: "inputMgr"
    }

    property double rowSpacing:     0.01 * width  // horizontal spacing between keyboard
    property double columnSpacing:  0.02 * height // vertical   spacing between keyboard
    property bool   shift:          false
    property bool   ctrl:           false
    property bool   alt:            false
    property double columns:        10
    property double rows:           5

    MouseArea {anchors.fill: parent} // don't allow touches to pass to MouseAreas underneath
    
    Loader {
        id: kbdLayout
        source: "layouts/en_US.qml"
    }

    Rectangle {
        anchors.fill: parent
        anchors.bottom: parent.bottom
        color: "transparent"

        Flickable {
            id: view
            anchors.fill: parent

            topMargin: 5

            contentWidth: keyboard.width
            contentHeight: keyboard.height+1

            onContentYChanged: {
                if(contentY < -keyboard.height/3)
                    inputMgr.hideKeyboard()
            }

            onMovementEnded: {
                if(contentY != -5)
                    contentY = -5
            }

            Item { // keys
                id: keyboard

                width: mainView.width
                height: mainView.height
                
                Column {
                    spacing: columnSpacing

                    Item {
                        width: mainView.width
                        height: keyboard.height * 0.65 / rows

                        PageIndicator {
                            id: numberIndicator
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: numberSwipe.top
                            count: numberSwipe.count
                            currentIndex: numberSwipe.currentIndex

                            delegate: Rectangle {
                                implicitWidth: mainView.width/numberSwipe.count
                                implicitHeight: 2
                                color: index === numberSwipe.currentIndex ? Atmosphere.accentColor : Atmosphere.secondaryColor

                                required property int index
                            }
                        }

                        SwipeView {
                            id: numberSwipe
                            anchors.fill: parent
                            Row { // 1234567890
                                spacing: rowSpacing
                                opacity: SwipeView.isCurrentItem ? 1 : 0
                                Behavior on opacity {
                                    OpacityAnimator {
                                        duration: 300
                                    }
                                }
                                width: childrenRect.width
                                Repeater {
                                    model: shift ? kbdLayout.item.row1_model_shift : kbdLayout.item.row1_model
                                    
                                    delegate: KeyButton {
                                        text: keyCode == "SPACE" ? kbdLayout.item.layout : 
                                            shift && capitalization ? displayText.toUpperCase() : displayText
                                        width: keyWidth * keyboard.width / columns - rowSpacing
                                        height: keyboard.height * 0.65 / rows - columnSpacing
                                        checked: displayText == "\u21E7" && mainView.shift || 
                                                    displayText == "Ctrl" && mainView.ctrl ||
                                                    displayText == "Alt" && mainView.alt
                                        onPressAndHold: {
                                            mainView.pressed(text)
                                        }

                                        onReleased: {
                                            mainView.released(text)
                                        }
                                    }
                                }
                            }

                            Row { // 1234567890
                                spacing: rowSpacing
                                opacity: SwipeView.isCurrentItem ? 1 : 0
                                Behavior on opacity {
                                    OpacityAnimator {
                                        duration: 300
                                    }
                                }
                                width: childrenRect.width
                                Repeater {
                                    model: kbdLayout.item.row1B_model
                                    
                                    delegate: KeyButton {
                                        text: displayText == "" ? kbdLayout.item.layout : shift && capitalization ? displayText.toUpperCase() : displayText
                                        width: keyWidth * keyboard.width / columns - rowSpacing
                                        height: keyboard.height * 0.65 / rows - columnSpacing
                                        checked: displayText == "\u21E7" && mainView.shift || 
                                                    displayText == "Ctrl" && mainView.ctrl ||
                                                    displayText == "Alt" && mainView.alt
                                        onPressAndHold: {
                                            mainView.pressed(text)
                                        }

                                        onReleased: {
                                            mainView.released(text)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    Item {
                        width: mainView.width
                        height: keyboard.height * 1.05 / rows * 3 - columnSpacing
                        anchors.topMargin: columnSpacing

                        PageIndicator {
                            id: symbolIndicator
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: symbolSwipe.top
                            count: symbolSwipe.count
                            currentIndex: symbolSwipe.currentIndex

                            delegate: Rectangle {
                                implicitWidth: mainView.width/symbolSwipe.count
                                implicitHeight: 2
                                color: index === symbolSwipe.currentIndex ? Atmosphere.accentColor : Atmosphere.secondaryColor

                                required property int index
                            }
                        }

                        SwipeView {
                            id: symbolSwipe
                            anchors.fill: parent

                            Column {
                                opacity: SwipeView.isCurrentItem ? 1 : 0
                                spacing: columnSpacing

                                Behavior on opacity {
                                    OpacityAnimator {
                                        duration: 300
                                    }
                                }

                                Row { // qwertyuiop
                                    spacing: rowSpacing
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    width: childrenRect.width
                                    Repeater {
                                        model: kbdLayout.item.row2_model
                                        
                                        delegate: KeyButton {
                                            text: displayText == "" ? kbdLayout.item.layout : shift && capitalization ? displayText.toUpperCase() : displayText
                                            width: keyWidth * keyboard.width / columns - rowSpacing
                                            height: keyboard.height * 1.05/ rows - columnSpacing
                                            checked: displayText == "\u21E7" && mainView.shift || 
                                                        displayText == "Ctrl" && mainView.ctrl ||
                                                        displayText == "Alt" && mainView.alt
                                            onPressAndHold: {
                                                mainView.pressed(text)
                                            }

                                            onReleased: {
                                                mainView.released(text)
                                            }
                                        }
                                    }
                                }
                                
                                Row { // asdfghjkl
                                    spacing: rowSpacing
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    width: childrenRect.width
                                    Repeater {
                                        model: kbdLayout.item.row3_model
                                        
                                        delegate: KeyButton {
                                            text: displayText == "" ? kbdLayout.item.layout : shift && capitalization ? displayText.toUpperCase() : displayText
                                            width: keyWidth * keyboard.width / columns - rowSpacing
                                            height: keyboard.height * 1.05/ rows - columnSpacing
                                            checked: displayText == "\u21E7" && mainView.shift || 
                                                        displayText == "Ctrl" && mainView.ctrl ||
                                                        displayText == "Alt" && mainView.alt
                                            onPressAndHold: {
                                                mainView.pressed(text)
                                            }

                                            onReleased: {
                                                mainView.released(text)
                                            }
                                        }
                                    }
                                }
                                
                                Row { // zxcvbnm
                                    spacing: rowSpacing
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    width: childrenRect.width
                                    Repeater {
                                        model: kbdLayout.item.row4_model
                                        
                                        delegate: KeyButton {
                                            text: displayText == "" ? kbdLayout.item.layout : shift && capitalization ? displayText.toUpperCase() : displayText
                                            width: keyWidth * keyboard.width / columns - rowSpacing
                                            height: keyboard.height * 1.05 / rows - columnSpacing
                                            checked: displayText == "\u21E7" && mainView.shift || 
                                                        displayText == "Ctrl" && mainView.ctrl ||
                                                        displayText == "Alt" && mainView.alt
                                            onPressAndHold: {
                                                mainView.pressed(text)
                                            }

                                            onReleased: {
                                                mainView.released(text)
                                            }
                                        }
                                    }
                                }
                            }

                            Column {
                                opacity: SwipeView.isCurrentItem ? 1 : 0
                                spacing: columnSpacing

                                Behavior on opacity {
                                    OpacityAnimator {
                                        duration: 300
                                    }
                                }

                                Row { // qwertyuiop
                                    spacing: rowSpacing
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    width: childrenRect.width
                                    Repeater {
                                        model: kbdLayout.item.row2B_model
                                        
                                        delegate: KeyButton {
                                            text: displayText == "" ? kbdLayout.item.layout : shift && capitalization ? displayText.toUpperCase() : displayText
                                            width: keyWidth * keyboard.width / columns - rowSpacing
                                            height: keyboard.height * 1.05/ rows - columnSpacing
                                            checked: displayText == "\u21E7" && mainView.shift || 
                                                        displayText == "Ctrl" && mainView.ctrl ||
                                                        displayText == "Alt" && mainView.alt
                                            onPressAndHold: {
                                                mainView.pressed(text)
                                            }

                                            onReleased: {
                                                mainView.released(text)
                                            }
                                        }
                                    }
                                }
                                
                                Row { // asdfghjkl
                                    spacing: rowSpacing
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    width: childrenRect.width
                                    Repeater {
                                        model: kbdLayout.item.row3B_model
                                        
                                        delegate: KeyButton {
                                            text: displayText == "" ? kbdLayout.item.layout : shift && capitalization ? displayText.toUpperCase() : displayText
                                            width: keyWidth * keyboard.width / columns - rowSpacing
                                            height: keyboard.height * 1.05/ rows - columnSpacing
                                            checked: displayText == "\u21E7" && mainView.shift || 
                                                        displayText == "Ctrl" && mainView.ctrl ||
                                                        displayText == "Alt" && mainView.alt
                                            onPressAndHold: {
                                                mainView.pressed(text)
                                            }

                                            onReleased: {
                                                mainView.released(text)
                                            }
                                        }
                                    }
                                }
                                
                                Row { // zxcvbnm
                                    spacing: rowSpacing
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    width: childrenRect.width
                                    Repeater {
                                        model: kbdLayout.item.row4B_model
                                        
                                        delegate: KeyButton {
                                            text: displayText == "" ? kbdLayout.item.layout : shift && capitalization ? displayText.toUpperCase() : displayText
                                            width: keyWidth * keyboard.width / columns - rowSpacing
                                            height: keyboard.height * 1.05/ rows - columnSpacing
                                            checked: displayText == "\u21E7" && mainView.shift || 
                                                        displayText == "Ctrl" && mainView.ctrl ||
                                                        displayText == "Alt" && mainView.alt
                                            onPressAndHold: {
                                                mainView.pressed(text)
                                            }

                                            onReleased: {
                                                mainView.released(text)
                                            }
                                        }
                                    }
                                }
                            }
                        }

                    }
                    
                    Row {
                        spacing: rowSpacing
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: childrenRect.width
                        Repeater {
                            model: shift ? kbdLayout.item.row5_model_shift : kbdLayout.item.row5_model
                            
                            delegate: KeyButton {
                                text: displayText == "" ? kbdLayout.item.layout : shift && capitalization ? displayText.toUpperCase() : displayText
                                width: keyWidth * keyboard.width / columns - rowSpacing
                                height: keyboard.height * 1.05/ rows - columnSpacing
                                checked: displayText == "\u21E7" && mainView.shift || 
                                displayText == "Ctrl" && mainView.ctrl ||
                                displayText == "Alt" && mainView.alt
                                onPressAndHold: {
                                    mainView.pressed(text)
                                }

                                onReleased: {
                                    mainView.released(text)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    signal pressed(string text)
    signal released(string text)

    onPressed: {
        if(text == '\u21B5') //ENTER
            inputMgr.sendFunctionKey(Qt.Key_Enter, 1)
        else if(text == kbdLayout.item.layout) //SPACE
            inputMgr.sendFunctionKey(Qt.Key_Space, 1)
        else if(text == '\u21E6') //BACKSPACE
            inputMgr.sendFunctionKey(Qt.Key_Backspace, 1)
        else if(text == '\u21D1') //UP
            inputMgr.sendFunctionKey(Qt.Key_Up, 1)
        else if(text == '\u21D3') //DOWN
            inputMgr.sendFunctionKey(Qt.Key_Down, 1)
        else if(text == '\u21D0') //LEFT
            inputMgr.sendFunctionKey(Qt.Key_Left, 1)
        else if(text == '\u21D2') //RIGHT
            inputMgr.sendFunctionKey(Qt.Key_Right, 1)
        else if(text == '\u21E5') //TAB 
            inputMgr.sendFunctionKey(Qt.Key_Tab, 1)
    }

    onReleased: {
        if(text == '\u21B5') //ENTER
        {
            inputMgr.sendFunctionKey(Qt.Key_Enter, 1)
            inputMgr.sendFunctionKey(Qt.Key_Enter, 0)
        }
        else if(text == kbdLayout.item.layout) //SPACE
        {
            inputMgr.sendFunctionKey(Qt.Key_Space, 1)
            inputMgr.sendFunctionKey(Qt.Key_Space, 0)
        }
        else if(text == '\u21E6') //BACKSPACE
        {
            inputMgr.sendFunctionKey(Qt.Key_Backspace, 1)
            inputMgr.sendFunctionKey(Qt.Key_Backspace, 0)
        }
        else if(text == '\u21D1') //UP
        {
            inputMgr.sendFunctionKey(Qt.Key_Up, 1)
            inputMgr.sendFunctionKey(Qt.Key_Up, 0)
        }
        else if(text == '\u21D3') //DOWN
        {
            inputMgr.sendFunctionKey(Qt.Key_Down, 1)
            inputMgr.sendFunctionKey(Qt.Key_Down, 0)
        }
        else if(text == '\u21D0') //LEFT
        {
            inputMgr.sendFunctionKey(Qt.Key_Left, 1)
            inputMgr.sendFunctionKey(Qt.Key_Left, 0)
        }
        else if(text == '\u21D2') //RIGHT
        {
            inputMgr.sendFunctionKey(Qt.Key_Right, 1)
            inputMgr.sendFunctionKey(Qt.Key_Right, 0)
        }
        else if(text == '\u21E5') //TAB
        {
            inputMgr.sendFunctionKey(Qt.Key_Tab, 1)
            inputMgr.sendFunctionKey(Qt.Key_Tab, 0)
        }
        else if(text == '\u21E7')
            shift = !shift
        else if(text == 'Ctrl')
            ctrl = !ctrl
        else if(text == 'Alt')
            alt = !alt
        else {
            if(ctrl){
                inputMgr.sendEvent(text, Qt.ControlModifier);
            } else if(alt){
                inputMgr.sendEvent(text, Qt.AltModifier);
            } else {
                inputMgr.sendString(text);
            }
            shift = false
            ctrl = false
            alt = false
        }
    }
}
