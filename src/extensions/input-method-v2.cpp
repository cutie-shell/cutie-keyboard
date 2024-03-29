#include "input-method-v2.h"

#include <QtGui/QGuiApplication>
#include <QtGui/qpa/qplatformnativeinterface.h>
#include <QQuickView>

QT_BEGIN_NAMESPACE

InputMethodManagerV2::InputMethodManagerV2()
	: QWaylandClientExtensionTemplate(/* Supported protocol version */ 1)
{
	m_inputmethod = nullptr;
	connect(this, &InputMethodManagerV2::activeChanged, this,
		&InputMethodManagerV2::handleExtensionActive);
}

void InputMethodManagerV2::handleExtensionActive()
{
	if (isActive() && !m_activated) {
		m_activated = true;
		if (m_inputmethod == nullptr) {
			void *seat = QGuiApplication::platformNativeInterface()
					     ->nativeResourceForIntegration(
						     "wl_seat");
			auto *obj = QtWayland::zwp_input_method_manager_v2::
				get_input_method(
					static_cast<struct ::wl_seat *>(seat));
			m_inputmethod = new InputMethodV2(obj);
		}
		connect(m_inputmethod, &InputMethodV2::inputMethodActivated,
			this, &InputMethodManagerV2::handleImActivated);
		connect(m_inputmethod, &InputMethodV2::inputMethodDeactivated,
			this, &InputMethodManagerV2::inputMethodDeactivated);
		connect(m_inputmethod, &InputMethodV2::contentTypeChanged, this,
			&InputMethodManagerV2::onContentTypeChanged);
	}
}

void InputMethodManagerV2::hideKeyboard()
{
	if (!m_hidden) {
		m_hidden = true;
		emit inputMethodDeactivated();
		m_purpose = 0;
		emit purposeChanged();
	}
}

void InputMethodManagerV2::handleImActivated()
{
	if (m_hidden)
		m_hidden = false;
	emit inputMethodActivated();
}

void InputMethodManagerV2::pressed(QString string)
{
	m_inputmethod->commit_string(string);
}

void InputMethodManagerV2::released()
{
	m_inputmethod->commit(m_inputmethod->serial);
}

int InputMethodManagerV2::get_purpose()
{
	return m_purpose;
}

void InputMethodManagerV2::onContentTypeChanged(uint32_t hint, uint32_t purpose)
{
	if (m_purpose != purpose) {
		m_purpose = purpose;
		emit purposeChanged();
	}
}

InputMethodV2::InputMethodV2(struct ::zwp_input_method_v2 *wl_object)
	: QWaylandClientExtensionTemplate<InputMethodV2>(1)
	, QtWayland::zwp_input_method_v2(wl_object)
{
}

void InputMethodV2::zwp_input_method_v2_activate()
{
	emit inputMethodActivated();
}

void InputMethodV2::zwp_input_method_v2_deactivate()
{
	emit inputMethodDeactivated();
}

void InputMethodV2::zwp_input_method_v2_surrounding_text(const QString &text,
							 uint32_t cursor,
							 uint32_t anchor)
{
}

void InputMethodV2::zwp_input_method_v2_text_change_cause(uint32_t cause)
{
}

void InputMethodV2::zwp_input_method_v2_content_type(uint32_t hint,
						     uint32_t purpose)
{
	emit contentTypeChanged(hint, purpose);
}

void InputMethodV2::zwp_input_method_v2_done()
{
	serial += 1;
}

void InputMethodV2::zwp_input_method_v2_unavailable()
{
	emit inputMethodDeactivated();
}

QT_END_NAMESPACE