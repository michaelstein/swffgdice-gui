#pragma once
#include <memory>
#include <QtCore/QObject>
#include "ResultModel.h"

class App : public QObject
{
	Q_OBJECT

public:
	App(QObject *parent = nullptr);
	~App();

	Q_INVOKABLE void roll(QString str);
	Q_INVOKABLE ResultModel* model();
	Q_INVOKABLE void resetModel();

private:
	class Private;
	std::unique_ptr<Private> d;
};
