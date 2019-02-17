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
		}

		TradingView {
			id: tradingView
			width: page.width
			height: page.height // TODO: Not fully correct
		}
	}
}

