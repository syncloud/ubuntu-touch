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
    property string iconAppRute: "../assets/logo.png"
    property string version: "1.0.0"  //version as a string (between inverted commas)
    property string license: "<a href='https://opensource.org/licenses/MIT'>MIT</a>"
                             //"<a href='http://www.gnu.org/licenses/gpl-3.0.en.html'>GPL3</a>"
                             //"<a href='https://opensource.org/licenses/MIT'>MIT</a>"
                             //"<a href='https://creativecommons.org/licenses/by-sa/4.0/'>CC By-SA</a>"
                             //etc

    header: PageHeader {
        id: pageHeader
        title: i18n.tr("About")

        StyleHints {
            foregroundColor: frontColor
            backgroundColor: backColor
            dividerColor: detailsColor
        }
    }

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
                    text: i18n.tr("Version %1. Under License %2").arg(version).arg(license)
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
                    { category: i18n.tr("About Syncloud"),
                      mainText: i18n.tr("Source"),
                      secondaryText: i18n.tr("hosted at Github"),
                      link: "https://github.com/syncloud"
                    },
                    { category: i18n.tr("Support"),
                      mainText: i18n.tr("Issues & Wishes"),
                      secondaryText: "",
                      link: "https://github.com/syncloud"
                    },
                    { category: i18n.tr("Support"),
                      mainText: i18n.tr("Mail"),
                      secondaryText: "",
                      link: "mailto:syncloud@syncloud.it"
                    },
                    { category: i18n.tr("Maintainer"),
                      mainText: i18n.tr("Maintainer"),
                      secondaryText: "Vor- u. Nachname"
                    },
                    { category: i18n.tr("Maintainer"),
                      mainText: i18n.tr("Our Work"),
                      secondaryText: i18n.tr("hosted at Github"),
                      link: "https://github.com/syncloud"
                    },
                    { category: i18n.tr("Donations"),
                      mainText: "Our Store",
                      secondaryText: i18n.tr("Support us"),
                      link: "https://shop.syncloud.org/support-development"
                    },
                 ])
            }
        }
    }
}
