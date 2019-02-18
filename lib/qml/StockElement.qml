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
    height: childrenRect.height // stockRow.height // width set by element itself

    Column {
        anchors {
            left: parent.left
            right: parent.right
        }
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

            Label {
                y: (parent.height - height) / 2
                text: stockElement.showJson ?
                            JsUtils.limitString(json, 500)
                            : display + " transactions: " + transactions.length
                verticalAlignment: Text.AlignHCenter
            }
        }
        Row {
            anchors {
                left: parent.left
                right: parent.right
            }
            // y: stockRow.height
            // color: "green"
            height: childrenRect.height

            ListModel {
                id: object1
                ListElement {
                    display: "AAA"
                }
                ListElement {
                    display: "AAA + BBBBB"
                }
            }

            /*Column {
                anchors {
                    left: parent.left
                    right: parent.right
                }*/
                ListView {
                    model: transactions
                    height: childrenRect.height
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    spacing: 2
                    interactive: true
                    flickableDirection: Flickable.VerticalFlick

                    delegate: // Row {
                        //height: 40
                        RectangleListElementStyled {
                            id: transactionElement
                            height: childrenRect.height
                            anchors {
                                left: parent.left
                                right: parent.right
                            }
                            color: "red"
                            opacity: 0.5
                            TextArea {
                                id: transactionContent
                                text: display
                                // height: 40
                            }
                        }
                    //}
                }
            }
        }
    }
//}
