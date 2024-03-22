#include "cutiekeyboard.h"

CutieKeyboard::CutieKeyboard(QQuickView *parent)
	: QQuickView(parent)
{
	QScreen *screen = QGuiApplication::primaryScreen();
	m_screenSize = screen->size();
	m_keyboardHeight = m_screenSize.height() * 0.36;

	LayerShellQt::Shell::useLayerShell();

	m_lsWindow = LayerShellQt::Window::get(this);
	m_lsWindow->setLayer(LayerShellQt::Window::LayerOverlay);
	m_lsWindow->setAnchors(LayerShellQt::Window::AnchorBottom);
	m_lsWindow->setKeyboardInteractivity(
		LayerShellQt::Window::KeyboardInteractivityNone);
	m_lsWindow->setScope("cutie-keyboard");
	this->resize(m_screenSize.width(), m_keyboardHeight);
	this->setResizeMode(QQuickView::SizeRootObjectToView);
	this->setSource(QUrl("qrc:/qml/Keyboard.qml"));
	this->setColor(QColor(Qt::transparent));

	m_inputMgr = static_cast<InputMethodManagerV2 *>(
		this->findChild<QObject *>("inputMgr"));

	connect(m_inputMgr, &InputMethodManagerV2::inputMethodActivated, this,
		&CutieKeyboard::showKeyboard);
	connect(m_inputMgr, &InputMethodManagerV2::exclZoneChanged, this,
		&CutieKeyboard::onExclZoneChanged);

	m_lsWindow->setExclusiveZone(m_inputMgr->get_exclZone());
}

void CutieKeyboard::showKeyboard()
{
	QQuickView::show();
	m_inputMgr->set_exclZone(m_keyboardHeight);
}

void CutieKeyboard::onExclZoneChanged()
{
	m_lsWindow->setExclusiveZone(m_inputMgr->get_exclZone());
}