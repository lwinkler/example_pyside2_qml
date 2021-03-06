// Copyright (c) 2019 Laurent Winkler
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)


import QtQuick 2.12
import QtQuick.Controls 2.12
// import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

import "js/jsUtils.js" as JsUtils

Item {
	width: 640  // to override
	height: 480 // to override
	// color: "white"

	ListView {
		id: localPatientsView
		model: pyStockListModel
		anchors.fill: parent
		spacing: 8
		interactive: true
		flickableDirection: Flickable.VerticalFlick

		delegate: StockElement {
			model: object
		}
	}
}

