// Copyright (c) 2019 Laurent Winkler
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)


import QtQuick 2.12
import QtQuick.Controls 2.12

import "js/jsUtils.js" as JsUtils

RectangleListElementStyled {
    property bool showJson : false
    property var model

    id: stockElement
    height: 200 // stockRow.height // width set by element itself

    Column {
        Row {
            id: stockRow
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
                            : display + " transactions: " + object.transactions.length
                verticalAlignment: Text.AlignHCenter
            }
        }
        Row {
            width: stockElement.width
            y: stockRow.height

            ListModel {
                id: object1
                ListElement {
                    display: "AAA"
                }
                ListElement {
                    display: "AAA"
                }
            }

            Column {
                ListView {
                    model: transactions
                    width: parent.width
                    spacing: 2
                    interactive: true
                    flickableDirection: Flickable.VerticalFlick

                    delegate: RectangleListElementStyled {
                        height: 50
                        width: parent.width
                        color: "red"
                        //text: display
                    }
                }
            }
        }
    }
}
