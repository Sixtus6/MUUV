import 'package:flutter/material.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:muuv/model/user.dart';
import 'package:muuv/screens/home/rider/provider.dart';
import 'package:muuv/screens/home/user/index.dart';
import 'package:muuv/screens/home/user/provider.dart';
import 'package:muuv/screens/onboarding/index.dart';
import 'package:muuv/utils/helper.dart';
import 'package:muuv/widget/button.dart';
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
                      return (provider.placesPredictedList.isNotEmpty)
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
              height: SizeConfigs.getPercentageWidth(75),
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

                      return Column(
                        children: [
                          Container(
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
                                    ProfileContainer(
                                      data: provider.user!.phoneNumber,
                                      image: 'assets/icon/contact.png',
                                      title: 'Phone Number',
                                    ),

                                    ProfileContainer(
                                      data: provider.user!.address,
                                      image: 'assets/icon/house.png',
                                      title: 'Home Adress',
                                    ),
                                    ProfileContainer(
                                      data: provider
                                                  .userPickUpLocation!.locationName!
                                                  .toString()
                                                  .length <
                                              40
                                          ? "Loading......"
                                          : provider
                                                  .userPickUpLocation!.locationName!
                                                  .substring(0, 40) +
                                              ".....",
                                      image: 'assets/icon/fromloc.png',
                                      title: 'Current location',
                                    ),
                                    //  SizeConfigs.getPercentageWidth(3).toInt().height,
                                  ],
                                ),
                              )),

                                   SizeConfigs.getPercentageWidth(2).toInt().height,
                    CustomButton(
                        h: 11,
                        w: 22,
                        img: '',
                        text: 'Logout',
                        ontap: () async {
                        
                          await removeKey("user").then(
                              (value) => print("removed data from caxhe"));
                          toast("You've been logged out as a User");
                          OnboardingScreen().launch(context,
                              pageRouteAnimation: PageRouteAnimation.Fade,
                              isNewTask: true);
                        }),
                        ],
                      );

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

// ignore: non_constant_identifier_names
Future<dynamic> BottomModalRider(
  BuildContext context,
  RiderGoogleMapProvider provider,
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
      return Container(
        height: SizeConfigs.getPercentageWidth(85),
        child: Column(
          children: [
            AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              leading: Row(
                children: [
                  provider.status == "Online"
                      ? Switch.adaptive(
                          activeColor: ColorConfig.primary,
                          value: provider.status == "Online",
                          onChanged: (value) {
                            toast("You are Offline");
                            provider.setStatus("Offline");
                            provider.driverIsOffline();
                            Navigator.pop(context);
                          }).expand()
                      : Container(),
                ],
              ),
              title: Text(
                'Driver Profile',
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
            Consumer<RiderGoogleMapProvider>(
              builder: (BuildContext context, provider, _) {
                // print(data!.toJson().values.isNotEmpty);

                return Column(
                  children: [
                    Container(
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
                                data: provider.rider!.name,
                                image: 'assets/icon/user.png',
                                title: 'Name',
                              ),

                              ProfileContainer(
                                data: provider.rider!.emailAddress,
                                image: 'assets/icon/mail.png',
                                title: 'Email',
                              ),
                              ProfileContainer(
                                data: provider.rider!.phoneNumber,
                                image: 'assets/icon/contact.png',
                                title: 'Phone Number',
                              ),

                              ProfileContainer(
                                data: provider.rider!.address,
                                image: 'assets/icon/house.png',
                                title: 'Home Adress',
                              ),
                              ProfileContainer(
                                carColor: provider.rider!.carColor,
                                carModel: provider.rider!.carModel,
                                carPlate: provider.rider!.carPlateNumber,
                                data: "",
                                image: 'assets/icon/house.png',
                                title: 'Car Details',
                              ),
                            ],
                          ),
                        )),
                    SizeConfigs.getPercentageWidth(2).toInt().height,
                    CustomButton(
                        h: 11,
                        w: 22,
                        img: '',
                        text: 'Logout',
                        ontap: () async {
                          if (provider.status == "Online") {
                            toast("Toggle mode from online to offline");
                            return;
                          }
                          await removeKey("rider").then(
                              (value) => print("removed data from caxhe"));
                          toast("You've been logged out as a Driver");
                          OnboardingScreen().launch(context,
                              pageRouteAnimation: PageRouteAnimation.Fade,
                              isNewTask: true);
                        }),
                  ],
                );

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
