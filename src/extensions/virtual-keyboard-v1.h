#ifndef VIRTUAL_KEYBOARD_V1
#define VIRTUAL_KEYBOARD_V1

#include <QtWaylandClient/QWaylandClientExtension>
#include <QtGui/QWindow>
#include <QtQml/QQmlEngine>

#include "qwayland-virtual-keyboard-unstable-v1.h"

QT_BEGIN_NAMESPACE

class VirtualKeyboard;

class VirtualKeyboardManager
	: public QWaylandClientExtensionTemplate<VirtualKeyboardManager>,
	  public QtWayland::zwp_virtual_keyboard_manager_v1

{
	Q_OBJECT

	QML_ELEMENT
    public:
	VirtualKeyboardManager();

    public slots:
	void handleExtensionActive();

    private:
	bool m_activated = false;
};

class VirtualKeyboard : public QWaylandClientExtensionTemplate<VirtualKeyboard>,
			public QtWayland::zwp_virtual_keyboard_v1 {
	Q_OBJECT
    public:
	VirtualKeyboard(struct ::zwp_virtual_keyboard_v1 *wl_object);

    signals:

    protected:
};

QT_END_NAMESPACE
#endif //VIRTUAL_KEYBOARD_V1