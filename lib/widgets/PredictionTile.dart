import 'package:cached_network_image/cached_network_image.dart';
import 'package:experttrack/brand-colors.dart';
import 'package:experttrack/datamodels/prediction.dart';
import 'package:flutter/material.dart';

class PredictionTile extends StatelessWidget {
  final Prediction prediction;

  PredictionTile({this.prediction});

  @override
  Widget build(BuildContext context) {
    String url1 = (prediction.avatar != null)
        ? prediction.avatar
        : 'https://res.cloudinary.com/expert-tracker/image/upload/v1609371504/expertbo_iy2uj5.png';
    String urli =
        "https://res.cloudinary.com/expert-tracker/image/upload/v1609260805/photo5983544056929694458_rxlhvp.jpg";
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              CircleAvatar(
                maxRadius: 20,
                backgroundImage: CachedNetworkImageProvider(
                  prediction.avatar,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prediction.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      prediction.profession,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12, color: BrandColors.colorDimText),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
