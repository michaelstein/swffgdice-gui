#include "ResultModel.h"

static QString imagePath(FaceType type)
{
	switch (type) {
	case SUCCESS: return QStringLiteral("qrc:/img/success.png");
	case ADVANTAGE: return QStringLiteral("qrc:/img/advantage.png");
	case TRIUMPH: return QStringLiteral("qrc:/img/triumph.png");
	case FAILURE: return QStringLiteral("qrc:/img/failure.png");
	case THREAT: return QStringLiteral("qrc:/img/threat.png");
	case DESPAIR: return QStringLiteral("qrc:/img/despair.png");
	case LIGHT: return QStringLiteral("qrc:/img/light.png");
	case DARK: return QStringLiteral("qrc:/img/dark.png");
	}
	return {};
}

class ResultModel::Private
{
public:
	Private(ResultModel *owner)
		: q(owner)
	{}

	ResultModel *q;
	swffgdice::Face data;
};

ResultModel::ResultModel(QObject *parent)
	: QAbstractListModel(parent), d(std::make_unique<Private>(this))
{
	d->data.success = 0;
	d->data.advantage = 0;
	d->data.triumph = 0;
	d->data.failure = 0;
	d->data.threat = 0;
	d->data.despair = 0;
	d->data.light = 0;
	d->data.dark = 0;
}

ResultModel::~ResultModel() = default;

void ResultModel::setModelData(swffgdice::Face face)
{
	beginResetModel();
	d->data = face;
	endResetModel();
}

void ResultModel::resetModel()
{
	beginResetModel();
	d->data.success = 0;
	d->data.advantage = 0;
	d->data.triumph = 0;
	d->data.failure = 0;
	d->data.threat = 0;
	d->data.despair = 0;
	d->data.light = 0;
	d->data.dark = 0;
	endResetModel();
}

int ResultModel::rowCount(const QModelIndex & parent) const
{
	return d->data.success + d->data.advantage + d->data.triumph + d->data.failure + d->data.threat + d->data.despair + d->data.light + d->data.dark;
}

QVariant ResultModel::data(const QModelIndex& index, int role) const
{
	if (role == ImageRole) {
		auto val = index.row();

		val -= d->data.success;
		if (val < 0)
			return imagePath(FaceType::SUCCESS);

		val -= d->data.failure;
		if (val < 0)
			return imagePath(FaceType::FAILURE);

		val -= d->data.advantage;
		if (val < 0)
			return imagePath(FaceType::ADVANTAGE);

		val -= d->data.threat;
		if (val < 0)
			return imagePath(FaceType::THREAT);

		val -= d->data.triumph;
		if (val < 0)
			return imagePath(FaceType::TRIUMPH);

		val -= d->data.despair;
		if (val < 0)
			return imagePath(FaceType::DESPAIR);

		val -= d->data.dark;
		if (val < 0)
			return imagePath(FaceType::DARK);

		val -= d->data.light;
		if (val < 0)
			return imagePath(FaceType::LIGHT);
	}
	return QVariant();
}

QHash<int, QByteArray> ResultModel::roleNames() const
{
	//auto roles = QAbstractListModel::roleNames();
	QHash<int, QByteArray> roles;
	roles[ImageRole] = "image";
	return roles;
}
