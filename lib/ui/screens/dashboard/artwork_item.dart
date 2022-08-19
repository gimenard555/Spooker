import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/model/artwork.dart';
import 'package:spooker/ui/components/outputs/custom_tag_text.dart';
import 'package:spooker/ui/components/spooker_borders.dart';
import 'package:spooker/ui/screens/profile/profile_screen.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import '../../components/image/image.dart';
import '../artwork/artwork_detail.dart';

class ArtworkItem extends HookConsumerWidget {
  ArtworkItem(this._artwork);

  final Artwork _artwork;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(left: SpookerSize.m10),
      width: SpookerSize.m150,
      height: SpookerSize.m200,
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArtworkDetail(_artwork)),
              );
            },
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: SpookerSize.m20),
                  height: SpookerSize.m180,
                  width: SpookerSize.m150,
                  child: ClipRRect(
                    borderRadius: SpookerBorders.m30Border,
                    child: networkImage(_artwork.imagePath, fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProfileScreen(profileId: _artwork.userId)),
              );
            },
            child: Wrap(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: TagText('@${_artwork.username}'),
                ),
              ],
            ),
          ),
        ],
      ),
      //onTap: () => router.push(DetailRoute(article: article)),
    );
  }
}
