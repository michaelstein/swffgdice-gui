#pragma once
#include <memory>
#include <QtCore/QAbstractListModel>
#include "swffgdice/lib.h"

enum FaceType {
	NONE,
	SUCCESS,
	ADVANTAGE,
	TRIUMPH,
	FAILURE,
	THREAT,
	DESPAIR,
	LIGHT,
	DARK
};

class ResultModel : public QAbstractListModel
{
	Q_OBJECT

public:
	enum FaceRoles {
		ImageRole = Qt::UserRole + 1,
	};

	ResultModel(QObject *parent = nullptr);
	~ResultModel();

	void setModelData(swffgdice::Face face);
	void resetModel();

	int rowCount(const QModelIndex& parent = QModelIndex()) const;
	QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const;
	QHash<int, QByteArray> roleNames() const;

private:
	class Private;
	std::unique_ptr<Private> d;

};
