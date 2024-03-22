#ifndef CUTIEKEYBOARD_H
#define CUTIEKEYBOARD_H

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <LayerShellQt6/shell.h>
#include <LayerShellQt6/window.h>

#include <input-method-v2.h>

class CutieKeyboard : public QQuickView {
	Q_OBJECT

    public:
	explicit CutieKeyboard(QQuickView *parent = Q_NULLPTR);

    public Q_SLOTS:
	void showKeyboard();
	void onExclZoneChanged();

    private slots:

    private:
	QSize m_screenSize;
	LayerShellQt::Window *m_lsWindow = nullptr;
	InputMethodManagerV2 *m_inputMgr = nullptr;

	/*
		Setting m_keyboardHeight should end up in settings at one point.
		The user should decide how tall he wants the keayboard.
	*/
	int m_keyboardHeight;
};

#endif //CUTIEKEYBOARD_H