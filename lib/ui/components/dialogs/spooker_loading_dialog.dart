import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/spooker_colors.dart';
import '../../utils/spooker_sizes.dart';
import '../spooker_borders.dart';

class LoadingDialog extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
        backgroundColor: SpookerColors.transparent,
        insetPadding: EdgeInsets.all(SpookerSize.m20),
        elevation: SpookerSize.zero,
        shape: RoundedRectangleBorder(borderRadius: SpookerBorders.m30Border),
        child: Container(
          width: SpookerSize.m300,
          height: SpookerSize.m300,
          color: SpookerColors.transparent,
          child: CircularProgressIndicator(
            strokeWidth: SpookerSize.m20,
            valueColor:
                AlwaysStoppedAnimation<Color>(SpookerColors.spookerGreen),
          ),
        ));
  }
}
