#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QMetaEnum>
#include <QObject>
#include <QIcon>
#include <cutiekeyboard.h>
#include <input-method-v2.h>

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    QIcon::setThemeName("default");
    QIcon::setThemeSearchPaths(QStringList("/usr/share/icons"));

    CutieKeyboard keyboard;

    return app.exec();
}
