import 'dart:async';


import 'package:trii/data/models/UserModel2.dart';
import 'package:trii/data/networking/api.dart';
import 'package:trii/generated/l10n.dart';


import 'package:trii/app/app_constants.dart';
import 'package:trii/redux2/app/app_state.dart';
import 'package:trii/redux2/settingApp/settingsHomeActions.dart';
import 'package:trii/redux2/settingApp/store.dart';
import 'package:trii/redux2/store.dart';
import 'package:trii/routes/assets_routes.dart';

import 'package:trii/styles/colors.dart';
import 'package:trii/styles/style.dart';

import 'package:trii/utils/adapt_screen.dart';
import 'package:trii/widget/card/cardInicio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:redux/redux.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux/redux.dart';

//import 'package:sign_in_with_apple/sign_in_with_apple.dart';
//import 'package:google_sign_in/google_sign_in.dart';

import 'dart:convert';
import 'dart:math';

import 'dart:math';
import 'dart:ui';

import '../../styles/colors.dart';
class usersListPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  usersListPage({Key key}) : super(key: key);

  @override
  _usersListState createState() => _usersListState();
}

var _store;
class _usersListState extends State<usersListPage> {
  final String apiKey = '6ed5914d0446030f513756c4a11ab46d';
  TextStyle moneyStyle;
  TextStyle titleStyle;
  final bool revealWeather = false;
  String search = "";

  @override
  Widget build(BuildContext context) {
    AdaptScreen.initAdapt(context);
    moneyStyle = TextStyle(
        color: AppColors.fontColor,
        fontSize: AdaptScreen.screenWidth() * 0.09,
        fontWeight: FontWeight.bold);
    titleStyle = TextStyle(
        color: AppColors.fontColor, fontSize: AdaptScreen.screenWidth() * 0.05);

    return



      Scaffold(
      body: StoreProvider<AppStateHome>(
        //ReduxSignUp.store,
          store: ReduxHome.store,
          child: StoreConnector<AppStateHome, dynamic>(
              distinct: true,
              converter: (store) => store.state.postsState,
              onInit: (store) {
                _store = store;
              },
              builder: (context, value) {
                return RefreshIndicator(
                    onRefresh: () {

                      /*var action = RefreshItemsAction();
                  Redux.store
                      .dispatch(UpdateUserInfo(state.userState.user, action));
                  return action.completer.future;*/
                    },
                    child:Stack(children: <Widget>[
                      Positioned(
                          top: -60.0, right: -35, child: _decorationBox()),
                      Container(
                        padding: EdgeInsets.all(15.0),
                      ),

                      ListView(


                        children: [
                          Container(
                            child: Center(
                              child: Image(
                                image: AssetImage(AssetsRoutes.loginIcon),
                                height: 200.0,
                                color: Colors.white,

                              ),
                            ),
                          ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            child: TextField(

                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Buscar',
                              ),

                              onChanged: (String text) {
                                search = text;
                                setState(() {

                                });
                              },


                            ),
                          ),
                          ReduxHome.store.state.postsState.dataUserList == null ?Text("No resullt", style: AppStyle().styleText(16, Colors.black, false)): ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:  ReduxHome.store.state.postsState.dataUserList.results.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                              
                               Result dataUser = ReduxHome.store.state.postsState.dataUserList.results[index];
                                

                                if (search
                                    .trim()
                                    .length == 0
                                ) {
                                  return AppCard().widgetCardHome(
                                      context, dataUser);
                                } else {
                                  if (dataUser.name
                                      .toLowerCase()
                                      .contains(search)) {
                                    return AppCard().widgetCardHome(
                                        context, dataUser);
                                  } else {
                                    return SizedBox();
                                  }
                                }
                              }
                          )
                        ],
                      ),
                    ]));
              })),
      floatingActionButton: SpeedDial(
        marginEnd: 18,
        marginBottom: 20,

        icon: Icons.add,
        activeIcon: Icons.close,

        buttonSize: 60.0,
        visible: true,

        closeManually: false,

        renderOverlay: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        // orientation: SpeedDialOrientation.Up,
        // childMarginBottom: 2,
        // childMarginTop: 2,
        children: [
          SpeedDialChild(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.red,
            label: "Recargar lista",
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              refreshList();
            },
          ),


        ],
      ),
    );
  }



  Widget _decorationBox() {
    return Transform.rotate(
        angle: -pi / 5.0,
        child: Container(
          height: 360.0,
          width: 360.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80.0),
              gradient: LinearGradient(colors: [
                AppColors.mainColor,
                AppColors.main2Color,
              ])),
        ));
  }
  refreshList(){
    asinc() async {
      Store<AppState> store =
      await createStore(api: API());


      store.dispatch(getListUserAction(
        context,
      ));
    }

    asinc();
  }


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshList();
  }
}



class RefreshItemsAction {
  final Completer<Null> completer;

  RefreshItemsAction({Completer completer})
      : this.completer = completer ?? Completer<Null>();
}
