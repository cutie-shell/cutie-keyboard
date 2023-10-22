#ifndef CUTIEKEYBOARD_H
#define CUTIEKEYBOARD_H

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <LayerShellQt6/shell.h>
#include <LayerShellQt6/window.h>

#include <input-method-v2.h>

class CutieKeyboard : public QQuickView
{
    Q_OBJECT

public:
    explicit CutieKeyboard(QQuickView *parent = Q_NULLPTR);

public Q_SLOTS:
    void showKeyboard();
    void hideKeyboard();

private slots:

private:
    QSize m_screenSize;
    LayerShellQt::Window *m_lsWindow = nullptr;
    InputMethodManagerV2 *m_inputMgr = nullptr;

};

#endif //CUTIEKEYBOARD_H