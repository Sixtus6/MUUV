import 'package:flutter/material.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:muuv/model/user.dart';
import 'package:muuv/screens/home/user/index.dart';
import 'package:muuv/screens/home/user/provider.dart';
import 'package:muuv/utils/helper.dart';
import 'package:muuv/widget/constant.dart';
import 'package:muuv/widget/placetitle.dart';
import 'package:muuv/widget/profile.dart';
import 'package:muuv/widget/textfield.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

Future<dynamic> BottomModal(
  BuildContext context,
  UserGoogleMapProvider provider,
  bool search,
) {
  return showModalBottomSheet(
    backgroundColor: Colors.grey.shade100,
    context: context,
    isDismissible: false,
    enableDrag: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0),
      ),
    ),
    isScrollControlled: true,
    builder: (BuildContext context) {
      return search
          ? Container(
              height: SizeConfigs.getPercentageWidth(
                  170), // Adjust height as needed
              //  padding: EdgeInsets.all(1),
              child: Column(
                children: [
                  AppBar(
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    title: Text(
                      'Search & Set Destination',
                      style: TextStyle(color: ColorConfig.secondary),
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: ColorConfig.primary,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: SizeConfigs.getPercentageWidth(3),
                        left: SizeConfigs.getPercentageWidth(3)),
                    child: CustomTextField(
                      icon: Icons.location_pin,
                      isEmail: false,
                      text: 'Search Destination Here',
                      myController: userSearchController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field cannot be empty';
                        }
                        return null;
                      },
                      onchange: (p0) {
                        provider.findPlaceAutoCompleSearch(
                            userSearchController.text);
                        return null;
                      },
                    ),
                  ),
                  Consumer<UserGoogleMapProvider>(
                    builder: (context, provider, _) {
                      return (provider.placesPredictedList.length > 0)
                          ? ListView.separated(
                              itemBuilder: (BuildContext context, int index) {
                                return PlacePredictionTile(
                                  predictedPlaces:
                                      provider.placesPredictedList[index],
                                );
                              },
                              itemCount: provider.placesPredictedList.length,
                              physics: ClampingScrollPhysics(),
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider(
                                  height: SizeConfigs.getPercentageWidth(1),
                                  thickness: 2,
                                  color: ColorConfig.primary,
                                );
                              },
                            ).expand()
                          : Container();
                    },
                  ),
                ],
                // mainAxisSize: MainAxisSize.min,
              ),
            )
          : Container(
              height: SizeConfigs.getPercentageWidth(80),
              child: Column(
                children: [
                  AppBar(
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    title: Text(
                      'User Profile',
                      style: TextStyle(color: ColorConfig.secondary),
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: ColorConfig.primary,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Consumer<UserGoogleMapProvider>(
                    builder: (BuildContext context, provider, _) {
                      // print(data!.toJson().values.isNotEmpty);

                      return Container(
                          decoration: BoxDecoration(
                              color: ColorConfig.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              )),
                          // padding: EdgeInsets.all(
                          //     SizeConfigs.getPercentageWidth(10)),
                          margin: EdgeInsets.only(
                              left: SizeConfigs.getPercentageWidth(4),
                              right: SizeConfigs.getPercentageWidth(4)),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                //   SizeConfigs.getPercentageWidth(3).toInt().height,
                                ProfileContainer(
                                  data: provider.user!.name,
                                  image: 'assets/icon/user.png',
                                  title: 'Name',
                                ),

                                ProfileContainer(
                                  data: provider.user!.emailAddress,
                                  image: 'assets/icon/mail.png',
                                  title: 'Email',
                                ),
                                //  SizeConfigs.getPercentageWidth(3).toInt().height,
                              ],
                            ),
                          ));

                      // return ListView.builder(
                      //   itemCount: 1,
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return ProfileContainer();
                      //   },
                      //   physics: ClampingScrollPhysics(),
                      // );
                    },
                  ),
                ],
              ),
            );
    },
  );
}
