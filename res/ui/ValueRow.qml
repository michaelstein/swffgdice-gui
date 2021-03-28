import QtQuick
import QtQuick.Controls

Item {
	id: root

	property var imageName: "ability"
	property alias text: edit.text

	function value() {
		return parseInt(edit.text)
	}

	Image {
		id: dec
		source: "qrc:/img/" + imageName + "_dec.png"
		anchors.top: parent.top
		anchors.left: parent.left
		anchors.bottom: parent.bottom
		width: root.height

		transform: Rotation {
			origin.x: root.height / 2
			origin.y: root.height / 2
			angle: 180
		}

		MouseArea {
			anchors.fill: parent
			onClicked: {
				var val = parseInt(edit.text)
				edit.text = (val - 1) + ""
			}
		}
	}

	Image {
		id: inc
		source: "qrc:/img/" + imageName + "_inc.png"
		anchors.top: parent.top
		anchors.right: parent.right
		anchors.bottom: parent.bottom
		width: root.height

		MouseArea {
			anchors.fill: parent
			onClicked: {
				var val = parseInt(edit.text)
				edit.text = (val + 1) + ""
			}
		}
	}

	TextInput {
		id: edit
		anchors.top: parent.top
		anchors.left: dec.right
		anchors.right: inc.left
		anchors.bottom: parent.bottom
		anchors.leftMargin: rowMargin
		anchors.rightMargin: rowMargin
		font.pointSize: root.height * 0.6
		inputMethodHints: Qt.ImhDigitsOnly
		text: "0"
		horizontalAlignment: TextInput.AlignHCenter
		verticalAlignment: TextInput.AlignVCenter
	}
}