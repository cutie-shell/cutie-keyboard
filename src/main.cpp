#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QMetaEnum>
#include <QObject>
#include <QIcon>
#include <cutiekeyboard.h>
#include <input-method-v2.h>

int main(int argc, char *argv[])
{
	QGuiApplication app(argc, argv);
	CutieKeyboard keyboard;

	return app.exec();
}
