/*
    ICONS: https://github.com/atomiclabs/cryptocurrency-icons/
*/

import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.3
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem
import QtQuick.LocalStorage 2.7

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'syncloud.klmhsb42'
    automaticOrientation: true

    //Colors
    property string frontColor:     "#000000"  // or "#000000" format
    property string backColor:      "#CFCFCF"    // or "#000000" format
    property string detailsColor:   "#949494"      // or "#000000" format
    property string accentColor:    "#CFCFCF"    // or "#000000" format

    //Properties
    property string iconAppRute: "../assets/logo.png"
    property string version: "1.0.0"  //version as a string (between inverted commas)


    width: units.gu(45)
    height: units.gu(75)

    function signin()
    {

        var user=username.text
        var pass=password.text
    var fetch = {
            "email": user,
            "password": pass
        }

    var postData = JSON.stringify(fetch);
    var doc = new XMLHttpRequest();
    doc.onreadystatechange = function() {
        if (doc.readyState == doc.DONE) {

            console.debug("Headers -->");
            console.debug(doc.getAllResponseHeaders ());
            console.debug("Last modified -->");
            console.debug(doc.getResponseHeader ("Last-Modified"));
            console.debug("code: " + doc.status);
            var serverResponse = doc.responseText;
            console.log(serverResponse);

            var result = JSON.parse(serverResponse);
            //console.log(result.message);
            if(result.success == false){
                restmessage.text = result.message;
                restmessage.visible = true;
                restmessage.color = "#ff0000";
            }
            else if (result.success == true){
                storeuserdata(result.data);
            }
        }
    }




    doc.open("POST", "https://api.syncloud.it/user");
    doc.setRequestHeader('Content-type', 'application/json');
    //doc.setRequestHeader( 'Authorization', 'Basic ' + user+':'+pass);
    //doc.setRequestHeader( 'Authorization', 'Basic ' + Qt.btoa( user + ':' + pass ) )


    doc.withCredentials = true;


    doc.send(postData);
    }


    function storeuserdata(userdata) {
                var db = LocalStorage.openDatabaseSync("QDeclarativeExampleDB", "1.0", "The Example QML SQL!", 1000000);


                console.log(userdata);

                db.transaction(
                    function(tx) {
                        // Create the database if it doesn't already exist
                        tx.executeSql('CREATE TABLE IF NOT EXISTS dataofuser(data JSON)');

                        console.log(userdata);

                        // Add (another) row
                        tx.executeSql('INSERT INTO dataofuser VALUES(?)', [ userdata ]);




                    }
                )


            refresh();


            }


    function getuserdata() {

        var returnval = {}
                var db = LocalStorage.openDatabaseSync("QDeclarativeExampleDB", "1.0", "The Example QML SQL!", 1000000);


                //console.log(userdata)

                db.transaction(
                    function(tx) {



                        var rs = tx.executeSql('SELECT * FROM dataofuser');

                        console.log(rs[0]);
                        returnval = rs;


                    }
                )

        console.log(returnval[0]);
        return returnval;


            }

    function signout() {
                var db = LocalStorage.openDatabaseSync("QDeclarativeExampleDB", "1.0", "The Example QML SQL!", 1000000);


                //console.log(userdata)

                db.transaction(
                    function(tx) {



                        tx.executeSql('DELETE FROM dataofuser');




                    }
                )

        refresh();


            }

    function refresh(){
        var theuserdata = getuserdata();
        //console.log(theuserdata);
        if(theuserdata){
            console.log(theuserdata[0]);
            loginfield.visible = false
            startpopup.visible = false
            mainPage.title = "SYNCLOUD"
        }
        else {
            console.log("signed out");
            loginfield.visible = true
            startpopup.visible = true
            mainPage.title = "Sign in"
        }
    }



    PageStack {
        id: pageStack
        Component.onCompleted: pageStack.push(mainPage)

        Page {
            id: mainPage
            Component.onCompleted: {refresh();}
            anchors.fill: parent
            header: PageHeader {
                id: header
                title: 'SYNCLOUD'
                StyleHints {
                    foregroundColor: frontColor
                    backgroundColor: backColor
                    dividerColor: detailsColor
                }
                trailingActionBar {
                    actions: [
                        Action {
                            iconName: "info"
                            text: "infos"

                            onTriggered: pageStack.push(Qt.resolvedUrl("About.qml"))
                        },
                        Action {
                            iconName: "settings"
                            text: "settings"

                            onTriggered: pageStack.push(Qt.resolvedUrl("Settings.qml"))
                        },
                        Action {
                            iconName: "reload"
                            text: "refresh"

                            onTriggered: getPrice()
                        },
                        Action {
                            iconName: "add"
                            text: "add"

                            onTriggered: getPrice()
                        }
                    ]
                }
            }
            Flickable {
                    anchors.fill: parent
                    contentHeight: configuration.childrenRect.height

                    Column {
                        id: configuration
                        anchors.fill: parent

                        ListItem.SingleValue {
                        }
                        ListItem.Standard {
                            text: i18n.tr("sub.syncloud.it")
                            enabled: true
                            /*
                            control: Switch {
                                id: enableAutomaticUpdates
                                checked: settings.automaticRefresh
                                onClicked: {
                                    if(settings.automaticRefresh)
                                        settings.automaticRefresh = false
                                    else
                                        settings.automaticRefresh = true
                                }
                            }
                            */
                        }



                    }



                }






            Rectangle {
                id: loginfield
              //width: 640
              //height: 480
                visible: true



              anchors { fill: parent}
              Column {
                anchors.centerIn: parent
                spacing: 16


                Column {
                  spacing: 4

                  Text { id: restmessage; text: ""; visible: false;   }



                }

                Column {
                  spacing: 4

                  TextField { id: username; placeholderText: qsTr("Username"); focus: true;  }



                }
                Column {
                  spacing: 4

                  TextField {id: password; placeholderText: qsTr("Password"); echoMode: TextInput.Password }
                }
                Row {
                  spacing: 16
                  anchors.horizontalCenter: parent.horizontalCenter
                  //Button { text: "Login"; onClicked: console.log(username.text,password.text) }
                  Button { text: "Login"; onClicked: signin() }



                }
              }
            }









            Rectangle {
                id: startpopup
                width: root.width
                height: root.height
              //anchors { fill: parent}
                z: 10000
                visible: true




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

                  Text {
                      width: parent.width
                      wrapMode: Text.WordWrap
                      horizontalAlignment: Text.AlignHCenter
                      text: i18n.tr("Build your own server. <a href='https://syncloud.org'>Learn more!</a>")
                      onLinkActivated: Qt.openUrlExternally(link)
                      linkColor: accentColor
                  }

                  Button {
                      width: parent.width
                      text: i18n.tr("SIGN UP")
                      onClicked: Qt.openUrlExternally("https://syncloud.it/register")
                      color: accentColor
                  }

                  Text {
                      width: parent.width
                      wrapMode: Text.WordWrap
                      horizontalAlignment: Text.AlignHCenter
                      text: i18n.tr("Already have an account? <a href='#'>Sign in!</a>")
                      onLinkActivated: {startpopup.visible = false;}
                      linkColor: accentColor
                  }
              }



            }






        }
    }

    Python {
        id: python

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('./'));

            importModule('cryptoprice', function() {
                console.log("-------------- python loaded");
            });
        }

        onError: {
            console.log('python error: ' + traceback);
        }
    }


}
