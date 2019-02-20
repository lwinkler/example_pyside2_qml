// Copyright (c) 2019 Laurent Winkler
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

// import "js/jsUtils.js" as JsUtils


ApplicationWindow {

	title: "Trading Transfer"
	visible: true
	id: page
	width: 1280; height: 960

	Material.theme: Material.Dark
	// Material.accent: Material.Purple

    ListModel {
        id: availableStocks
        ListElement {
            symbol: "GOOGL"
            price: 1000.3
        }
        ListElement {
            symbol: "AMZN"
            price: 1208.2
        }
    }

    Column {
		spacing: 2

		Row {

			spacing: 5


			Button {
				text: qsTr("&Refresh views")
				onClicked: {
					pyTradingClient.refreshStocks();
				}
			}
            Button {
                text: qsTr("Add &stock")
                onClicked: {
                    var component = Qt.createComponent("NewStock.qml")
                    var window    = component.createObject(page, {stocks: availableStocks})
                    window.show()
                }
            }

            ComboBox {
                id: transactionStock
                model: availableStocks
                textRole: "symbol"
                width: 200
                // onCurrentIndexChanged: console.debug(cbItems.get(currentIndex).text + ", " + cbItems.get(currentIndex).color)
            }

            Button {
                text: qsTr("Add &transaction")
                onClicked: {

                }
            }
		}

		TradingView {
			id: tradingView
			width: page.width
            // anchors.bottom: page.height
            height: page.height // TODO: Not fully correct
		}
    }
}

