/*
 * About template
 * By Joan CiberSheep using base file from uNav
 *
 * uNav is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * uNav is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
    id: aboutPage
    title: "About"

    //Colors
    property string frontColor:     "#000000"  // or "#000000" format
    property string backColor:      "#CFCFCF"    // or "#000000" format
    property string detailsColor:   "#949494"      // or "#000000" format
    property string accentColor:    "#CFCFCF"    // or "#000000" format

    //Properties
    property string iconAppRute: "assets/logo.png"
    property string version: "1.0.0"  //version as a string (between inverted commas)
    property string license: "<a href='https://syncloud.org'>Learn more!</a>"
    property string signin: "<a href='https://syncloud.org'>Sign in!</a>"



    ScrollView {
        width: parent.width
        height: parent.height
        contentItem: aboutView
    }

    ListView {
        id: aboutView
        anchors.fill: parent
        section.property: "category"
        section.criteria: ViewSection.FullString

        section.delegate: ListItemHeader {
            title: section
        }

        header: Item {
            width: parent.width

            Column {
                id: listViewHeader
                width: parent.width
                spacing: units.gu(2)

                anchors{
                    top: parent.top
                    topMargin: units.gu(8)
                }

                UbuntuShape {
                    width: units.gu(20)
                    height: width
                    aspect: UbuntuShape.Flat
                    anchors.horizontalCenter: parent.horizontalCenter

                    source: Image {
                        sourceSize.width: parent.width
                        sourceSize.height: parent.height
                        source: iconAppRute
                    }
                }

                Label {
                    width: parent.width
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    text: i18n.tr("Syncloud")
                    font.bold: true
                }

                Label {
                    width: parent.width
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    text: i18n.tr("Build your own server. %1").arg(license)
                    onLinkActivated: Qt.openUrlExternally(link)
                    linkColor: accentColor
                }

                Label {
                    width: parent.width
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    text: i18n.tr("SIGN UP")
                    onLinkActivated: Qt.openUrlExternally(link)
                    linkColor: accentColor
                }

                Label {
                    width: parent.width
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    text: i18n.tr("Already have an account? %1").arg(signin)
                    onLinkActivated: Qt.openUrlExternally(link)
                    linkColor: accentColor
                }
            }

            Component.onCompleted: height = listViewHeader.height + units.gu(20)
        }

        model: aboutModel

        delegate: ListItem {
            height: storiesDelegateLayout.height
            divider.visible: false
            highlightColor: highlightColor

            ListItemLayout {
                id: storiesDelegateLayout
                title.text: mainText
                subtitle.text: secondaryText
                ProgressionSlot { name: link !== "" ? "next" : ""}
            }

            onClicked: model.link !== "" ? Qt.openUrlExternally(model.link) : null
        }

        ListModel {
            id: aboutModel

            Component.onCompleted: initialize()

            function initialize() {
                aboutModel.append([
                    { category: i18n.tr("About CryptoPrice"),
                      mainText: i18n.tr("Source"),
                      secondaryText: i18n.tr("hosted at Gitlab"),
                      link: "https://github.com/klmhsb42/syncloud-ub-touch"
                    },
                    { category: i18n.tr("Support"),
                      mainText: i18n.tr("Issues & Wishes"),
                      secondaryText: "",
                      link: "https://github.com/klmhsb42/syncloud-ub-touch/issues"
                    },
                    { category: i18n.tr("Support"),
                      mainText: i18n.tr("Mail"),
                      secondaryText: "",
                      link: "mailto:info@syncloud.it"
                    },
                    { category: i18n.tr("Maintainer"),
                      mainText: i18n.tr("Maintainer"),
                      secondaryText: "Name Name"
                    },
                    { category: i18n.tr("Maintainer"),
                      mainText: i18n.tr("My Work"),
                      secondaryText: i18n.tr("hosted at Github"),
                      link: "https://github.com/klmhsb42/"
                    },
                    { category: i18n.tr("Donations"),
                      mainText: "Liberapay",
                      secondaryText: i18n.tr("Support our work"),
                      link: ""
                    },
                 ])
            }
        }
    }
}
