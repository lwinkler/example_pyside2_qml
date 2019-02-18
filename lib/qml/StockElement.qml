// Copyright (c) 2019 Laurent Winkler
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)


import QtQuick 2.12
import QtQuick.Controls 2.12

import "js/jsUtils.js" as JsUtils

RectangleListElementStyled {
    property bool showJson : false
    property bool showTransactions : true
    property var model

    id: stockElement
    height: childrenRect.height

    Column {
        anchors {
            left: parent.left
            right: parent.right
        }
        spacing: 3
        Row {
            id: stockRow
            anchors {
                left: parent.left
                right: parent.right
            }
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

            Image {
                source: "icons/info.png"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        stockElement.showTransactions = ! stockElement.showTransactions;
                    }
                }
            }

            Label {
                y: (parent.height - height) / 2
                text: stockElement.showJson ?
                            JsUtils.limitString(json, 500)
                            : display + " transactions: " + transactions.length
                verticalAlignment: Text.AlignHCenter
            }
        }

        ListView {
            model: transactions
            height: childrenRect.height
            visible: stockElement.showTransactions
            anchors {
                left: parent.left
                right: parent.right
            }
            spacing: 2
            interactive: true
            flickableDirection: Flickable.VerticalFlick

            delegate: RectangleListElementStyled {
                id: transactionElement
                height: childrenRect.height
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: 8
                }
                color: "red"
                Row {
                    anchors {
                        left: parent.left
                        right: parent.right
                        margins: 5
                    }
                    Label {
                        id: transactionContent
                        text: display
                        height: 30
                        verticalAlignment: Text.AlignHCenter
                    }
                }
            }
        }
    }
}
