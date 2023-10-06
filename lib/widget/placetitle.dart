import 'package:flutter/material.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:muuv/key/key.dart';
import 'package:muuv/model/direction.dart';
import 'package:muuv/model/predictedPlaces.dart';
import 'package:muuv/screens/home/user/provider.dart';
import 'package:muuv/utils/helper.dart';
import 'package:muuv/widget/progress.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class PlacePredictionTile extends StatefulWidget {
  final PredictedPlaces? predictedPlaces;
  PlacePredictionTile({this.predictedPlaces});

  @override
  State<PlacePredictionTile> createState() => _PlacePredictionTileState();
}

class _PlacePredictionTileState extends State<PlacePredictionTile> {
  
  

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: ColorConfig.scaffold),
        onPressed: () {
      Provider.of<UserGoogleMapProvider>(context, listen: false).getPlaceDirectionDetails(widget.predictedPlaces!.place_id, context);

        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.map,
                color: ColorConfig.primary,
              ),
              SizeConfigs.getPercentageWidth(11).toInt().width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.predictedPlaces!.main_text!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: ColorConfig.secondary),
                  ),
                  Text(
                    widget.predictedPlaces!.secondary_text!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: ColorConfig.secondary),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
