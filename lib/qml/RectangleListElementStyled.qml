// Copyright (c) 2019 Laurent Winkler
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

import QtQuick 2.12

Rectangle {
	// https://material.io/tools/color/#!/?view.left=0&view.right=0&primary.color=2962FF
	property bool errorState : false

	color: errorState ? "red" : "#2962ff"
	radius: 5

	anchors {
		left: parent.left
		right: parent.right
		margins: 3
	}
}
