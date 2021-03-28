import QtQuick
import QtQuick.Controls
import mstein.swffgdice

ApplicationWindow {
	id: root
	width: 370
	height: 750
	visible: true
	color: "#FFFFFF"

	property var rowSize: 70
	property var rowMargin: 10

	App {
		id: engine
	}

	header: Rectangle {
		height: rowSize
		color: "#8099fc"

		Text {
			anchors.fill: parent
			anchors.margins: 10
			fontSizeMode: Text.VerticalFit
			minimumPixelSize: 10
			font.pixelSize: 72
			font.weight: Font.Bold
			color: "#FFFFFF"
			text: "SW FFG Dice Roller"
		}
	}

	footer: Rectangle {
		height: rowMargin + 40 + rowMargin + 40 + rowMargin
		color: "#8099fc"

		Button {
			id: btnRoll
			anchors.top: parent.top
			anchors.left: parent.left
			anchors.topMargin: rowMargin
			anchors.leftMargin: rowMargin
			width: (parent.width / 2) - (rowMargin / 2)
			height: 40
			text: "Roll"
			onClicked: {
				var a = ability.text + "a"
				var p = proficiency.text + "p"
				var b = boost.text + "b"
				var d = difficulty.text + "d"
				var c = challenge.text + "c"
				var s = setback.text + "s"
				var f = force.text + "f"
				engine.roll(a+p+b+d+c+s+f)
			}
		}

		Button {
			id: btnReset
			anchors.top: parent.top
			anchors.left: btnRoll.right
			anchors.right: parent.right
			anchors.topMargin: rowMargin
			anchors.leftMargin: rowMargin
			anchors.rightMargin: rowMargin
			height: 40
			text: "Clear"
			onClicked: {
				ability.text = "0"
				proficiency.text = "0"
				boost.text = "0"
				difficulty.text = "0"
				challenge.text = "0"
				setback.text = "0"
				force.text = "0"
				engine.resetModel()
			}
		}

		Rectangle {
			anchors.top: btnRoll.bottom
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.bottom: parent.bottom
			anchors.topMargin: rowMargin
			anchors.leftMargin: rowMargin
			anchors.rightMargin: rowMargin
			anchors.bottomMargin: rowMargin
			color: "#FFFFFF"

			Row {
				anchors.fill: parent
				anchors.margins: 5

				Repeater {
					model: engine.model()
					Image {
						width: 30
						height: 30
						source: image
					}
				}
			}
		}
	}

	Flickable {
		anchors.fill: parent
		contentWidth: parent.width
		contentHeight: (rowSize + rowMargin) * 7 + rowMargin

		ValueRow {
			id: ability
			anchors.top: parent.top
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.topMargin: rowMargin
			anchors.leftMargin: rowMargin
			anchors.rightMargin: rowMargin
			height: rowSize
			imageName: "ability"
		}

		ValueRow {
			id: proficiency
			anchors.top: ability.bottom
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.topMargin: rowMargin
			anchors.leftMargin: rowMargin
			anchors.rightMargin: rowMargin
			height: rowSize
			imageName: "proficiency"
		}

		ValueRow {
			id: boost
			anchors.top: proficiency.bottom
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.topMargin: rowMargin
			anchors.leftMargin: rowMargin
			anchors.rightMargin: rowMargin
			height: rowSize
			imageName: "boost"
		}

		ValueRow {
			id: difficulty
			anchors.top: boost.bottom
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.topMargin: rowMargin
			anchors.leftMargin: rowMargin
			anchors.rightMargin: rowMargin
			height: rowSize
			imageName: "difficulty"
		}

		ValueRow {
			id: challenge
			anchors.top: difficulty.bottom
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.topMargin: rowMargin
			anchors.leftMargin: rowMargin
			anchors.rightMargin: rowMargin
			height: rowSize
			imageName: "challenge"
		}

		ValueRow {
			id: setback
			anchors.top: challenge.bottom
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.topMargin: rowMargin
			anchors.leftMargin: rowMargin
			anchors.rightMargin: rowMargin
			height: rowSize
			imageName: "setback"
		}

		ValueRow {
			id: force
			anchors.top: setback.bottom
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.margins: rowMargin
			height: rowSize
			imageName: "force"
		}

	}

}
