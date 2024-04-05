#include <logging.h>
#include <QDateTime>
#include <QFileInfo>

Q_LOGGING_CATEGORY(CUTIE_KEYBOARD, "cutie-keyboard", QtWarningMsg)

void cutieMessageHandler(QtMsgType type, const QMessageLogContext &context,
			 const QString &msg)
{
	QString file = QFileInfo(context.file).fileName();
	QString logStr = QString("%1: %2:%3 %4")
				 .arg(context.category, file,
				      QString::number(context.line), msg);
	QString timeStamp =
		QDateTime::currentDateTime().toString("MMM d HH:mm:ss:zzz");

	if (type == QtFatalMsg) {
		abort();
	}
	if (type == QtWarningMsg) {
		qCWarning(CUTIE_KEYBOARD) << timeStamp << "[Warning]" << logStr;
		return;
	}
	if (type == QtInfoMsg) {
		qCInfo(CUTIE_KEYBOARD) << timeStamp << "[Info]" << logStr;
		return;
	}
	if (type == QtDebugMsg) {
		qCDebug(CUTIE_KEYBOARD) << timeStamp << "[Debug]" << logStr;
		return;
	}
}