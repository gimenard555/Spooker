import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model/artwork.dart';
import '../../components/image/image.dart';
import '../../components/spooker_borders.dart';
import '../../utils/spooker_sizes.dart';
import 'artwork_detail.dart';

class UserArtworkItem extends HookConsumerWidget {
  UserArtworkItem(this._artwork);

  final Artwork _artwork;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ArtworkDetail(_artwork)),
          );
        },
        child: Container(
          margin: EdgeInsets.all(SpookerSize.m2),
          height: SpookerSize.m150,
          width: SpookerSize.m150,
          child: ClipRRect(
            borderRadius: SpookerBorders.m30Border,
            child: networkImage(_artwork.imagePath, fit: BoxFit.cover),
          ),
        ));
  }
}
