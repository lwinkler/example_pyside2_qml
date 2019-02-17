// Copyright (c) 2019 Laurent Winkler
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)


import QtQuick 2.12
import QtQuick.Controls 2.12
// import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

// import "js/jsUtils.js" as JsUtils

Item {
	width: 640  // to override
	height: 480 // to override

	property int projectIndex


	// layout for buttons and listView

	ListView {
		id: localPatientsView
        model: pyStockListModel
		spacing: 2
		Layout.fillWidth: true
		Layout.fillHeight: true
		interactive: true
		flickableDirection: Flickable.VerticalFlick
		// boundsBehavior: Flickable.StopAtBounds

		delegate: Column {
			spacing: 2
			width: parent.width

			RectangleListElementStyled {
				property bool showJson : false

				id: stockElement
				height: uploadRow.height // width set by element itself

				Row {
					// List of all local patients
					id: uploadRow
					width: parent.width
					spacing: 2

					Image {
						source: "icons/info.png"
						MouseArea {
							anchors.fill: parent
							onClicked: {
								stockElement.showJson = ! stockElement.showJson;
							}
						}
					}

					Label {
						y: (parent.height - height) / 2
						text: stockElement.showJson ?
									JsUtils.limitString(json, 500)
									: display
						verticalAlignment: Text.AlignHCenter
					}
				}
			}
		}
	}
}

