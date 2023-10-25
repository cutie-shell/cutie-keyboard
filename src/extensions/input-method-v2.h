#ifndef INPUT_METHOD_V2_H
#define INPUT_METHOD_V2_H

#include <QtWaylandClient/QWaylandClientExtension>
#include <QtGui/QWindow>
#include <QtQml/QQmlEngine>

#include "qwayland-input-method-unstable-v2.h"

QT_BEGIN_NAMESPACE

class InputMethodV2;

class InputMethodManagerV2 : public QWaylandClientExtensionTemplate<InputMethodManagerV2>
	, public QtWayland::zwp_input_method_manager_v2

{
	Q_OBJECT
	QML_ELEMENT
public:
	InputMethodManagerV2();

	Q_INVOKABLE void hideKeyboard();
	Q_INVOKABLE void pressed(QString string);
	Q_INVOKABLE void released();

public slots:
	void handleExtensionActive();
	void handleImActivated();
	
signals:
	void inputMethodActivated();
	void inputMethodDeactivated();

protected:

private:
	InputMethodV2 *m_inputmethod;

	bool m_activated = false;
	bool m_hidden = true;
};

class InputMethodV2 : public QWaylandClientExtensionTemplate<InputMethodV2>
	, public QtWayland::zwp_input_method_v2
{
	Q_OBJECT
public:
	InputMethodV2(struct ::zwp_input_method_v2 *wl_object);
	uint32_t serial = 0;

signals:
	void inputMethodActivated();
	void inputMethodDeactivated();

protected:
	void zwp_input_method_v2_activate() override;
	void zwp_input_method_v2_deactivate() override;
	void zwp_input_method_v2_surrounding_text(const QString &text, uint32_t cursor, uint32_t anchor) override;
	void zwp_input_method_v2_text_change_cause(uint32_t cause) override;
	void zwp_input_method_v2_content_type(uint32_t hint, uint32_t purpose) override;
	void zwp_input_method_v2_done() override;
	void zwp_input_method_v2_unavailable() override;

};

QT_END_NAMESPACE
#endif //INPUT_METHOD_V2_