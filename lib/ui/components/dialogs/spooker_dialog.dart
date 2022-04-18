import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/spooker_borders.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

class SpookerDialog extends HookConsumerWidget {
  SpookerDialog(this.form, this.titleForm);

  final List<Widget> form;
  final String titleForm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> newForm = [
      Stack(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Text(
                titleForm,
                textAlign: TextAlign.center,
                style: SpookerFonts.commonGrayBold,
              )),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                'X',
                style: SpookerFonts.commonGrayBold,
              ),
            ),
          )
        ],
      ),
    ];
    newForm.addAll(form);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: SpookerBorders.m10Border),
      elevation: 0,
      backgroundColor: SpookerColors.transparent,
      child: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.7,
              margin: EdgeInsets.all(SpookerSize.m10),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: SpookerColors.completeLight,
                  borderRadius: SpookerBorders.m10Border,
                  boxShadow: [
                    BoxShadow(
                        color: SpookerColors.completeDark,
                        offset: Offset(0, 10),
                        blurRadius: SpookerSize.m30),
                  ]),
              child: Padding(
                padding: EdgeInsets.all(SpookerSize.m20),
                child: Column(children: newForm),
              )),
        ],
      ),
    );
  }
}
