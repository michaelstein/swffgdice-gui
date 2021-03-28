#include "App.h"
#include <swffgdice/lib.h>

class App::Private
{
public:
	Private(App *owner)
		: q(owner)
	{}

	App *q;

	ResultModel model;
};

App::App(QObject *parent)
	: QObject(parent)
	, d(std::make_unique<Private>(this))
{
}

App::~App() = default;

void App::roll(QString str)
{
	const auto args = str.toStdString();
	const auto res = swffgdice::roll(args.c_str());
	d->model.setModelData(res);
}

ResultModel* App::model()
{
	return &d->model;
}

void App::resetModel()
{
	d->model.resetModel();
}
