import 'package:flutter/material.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:muuv/screens/home/user/provider.dart';
import 'package:muuv/widget/constant.dart';
import 'package:muuv/widget/placetitle.dart';
import 'package:muuv/widget/textfield.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

Future<dynamic> BottomModal(
    BuildContext context, UserGoogleMapProvider provider, bool search) {
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
          : Container();
    },
  );
}
