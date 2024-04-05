#include <virtual-keyboard-v1.h>
#include <logging.h>

#include <QtGui/QGuiApplication>
#include <QtGui/qpa/qplatformnativeinterface.h>

QT_BEGIN_NAMESPACE

VirtualKeyboardManager::VirtualKeyboardManager()
	: QWaylandClientExtensionTemplate(/* Supported protocol version */ 1)
{
	connect(this, &VirtualKeyboardManager::activeChanged, this,
		&VirtualKeyboardManager::handleExtensionActive);
}

void VirtualKeyboardManager::handleExtensionActive()
{
	if (isActive() && !m_activated) {
		qCDebug(CUTIE_KEYBOARD)
			<< "VirtualKeyboardManager extension activated";
		m_activated = true;
	}
}

VirtualKeyboard::VirtualKeyboard(struct ::zwp_virtual_keyboard_v1 *wl_object)
	: QWaylandClientExtensionTemplate<VirtualKeyboard>(1)
	, QtWayland::zwp_virtual_keyboard_v1(wl_object)
{
}

QT_END_NAMESPACE