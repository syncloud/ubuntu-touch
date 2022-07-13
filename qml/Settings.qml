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
    title: "Settings"

    //Colors
    property string frontColor:     "#000000"  // or "#000000" format
    property string backColor:      "#CFCFCF"    // or "#000000" format
    property string detailsColor:   "#949494"      // or "#000000" format
    property string accentColor:    "#CFCFCF"    // or "#000000" format



    header: PageHeader {
        id: pageHeader
        title: i18n.tr("Settings")

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



            property var actions : {
                    //"signout": signout()
                    "signout": function(){ console.log("signout clicked!"); }
                }

            Component.onCompleted: initialize()

            function initialize() {
                aboutModel.append([
                    { category: i18n.tr("ACCOUNT"),
                      mainText: i18n.tr("Email"),
                      secondaryText: i18n.tr("example@company.com"),
                      link: ""
                    },
                    { category: i18n.tr("ACCOUNT"),
                      mainText: i18n.tr("Sign out from Syncloud"),
                      secondaryText: "Removes Syncloud account information",
                      //link: "",
                      label: "signout"

                    },
                    { category: i18n.tr("FEEDBACK"),
                      mainText: i18n.tr("Send log file"),
                      secondaryText: "Sends developers application log",
                      link: ""
                    },
                    { category: i18n.tr("ADVANCED"),
                      mainText: i18n.tr("Server"),
                      secondaryText: "syncloud.it"
                    },
                 ])
            }



        }


    }

    Rectangle {
        id: logout
        //anchors {fill: parent}
        z: 10000
        //Row {
          //spacing: 16
          //anchors.horizontalCenter: parent.horizontalCenter
          //Button { text: "Login"; onClicked: console.log(username.text,password.text) }
          Button { text: "Logout"; onClicked: signout() }
        //}
    }
}
