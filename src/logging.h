#pragma once

#include <QLoggingCategory>

Q_DECLARE_LOGGING_CATEGORY(CUTIE_KEYBOARD)

void cutieMessageHandler(QtMsgType type, const QMessageLogContext &context,
			 const QString &msg);