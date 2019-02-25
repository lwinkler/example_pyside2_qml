import QtQuick 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
	property var stocks

	id: root
	width: 300
	height: 200

	Column {
		// anchors.si
		Grid {
			rows: 2
			columns: 2
			Label {
				text: qsTr("Symbol")
				verticalAlignment: Text.AlignVCenter
			}

			TextField {
				id: symbol
                inputMethodHints: Qt.ImhUppercaseOnly
			}

			Label {
				text: qsTr("Price")
			}

			TextField {
				id: price
                inputMethodHints: Qt.ImhFormattedNumbersOnly
			}
		}
		Row {
			Button {
				text: qsTr("Create")
				onClicked: {
					stocks.append({"symbol": symbol.text, "price": parseFloat(price.text)})
					close();
				}
			}
			Button {
				text: qsTr("Cancel")
				onClicked: {
					close();
				}
			}
		}
	}
}
