import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/model/artwork.dart';
import 'package:spooker/ui/components/outputs/custom_tag_text.dart';
import 'package:spooker/ui/components/spooker_borders.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import '../../components/image/image.dart';

class ArtworkItem extends HookConsumerWidget {
  const ArtworkItem({Key? key, required this.artwork}) : super(key: key);
  final Artwork artwork;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(left: SpookerSize.m10),
      width: 150,
      height: 200,
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: SpookerSize.m10,
              ),
              SizedBox(
                height: SpookerSize.m180,
                width: SpookerSize.m150,
                child: ClipRRect(
                  borderRadius: SpookerBorders.borderRadiusAll,
                  child: networkImage(artwork.imagePath, fit: BoxFit.cover),
                ),
              ),
            ],
          ),
          TagText(tagText: artwork.userName)
        ],
      ),
      //onTap: () => router.push(DetailRoute(article: article)),
    );
  }
}
