import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/model/artwork.dart';
import 'package:spooker/ui/components/spooker_borders.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import '../../components/image/image.dart';

class ArtworkItem extends HookConsumerWidget {
  const ArtworkItem({Key? key, required this.artwork}) : super(key: key);
  final Artwork artwork;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 200,
      child: Card(
        margin: EdgeInsets.only(
            left: SpookerSize.miniMargin, top: SpookerSize.miniMargin),
        shape: RoundedRectangleBorder(
            borderRadius: SpookerBorders.borderRadiusAll),
        elevation: 4,
        color: SpookerColors.lightGray,
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: ClipRRect(
                borderRadius: SpookerBorders.borderRadiusTop,
                child: networkImage(artwork.imagePath, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                artwork.userName,
                style: SpookerFonts.artworkItemText,
              ),
            ),
          ],
        ),
      ),

      //onTap: () => router.push(DetailRoute(article: article)),
    );
  }
}
