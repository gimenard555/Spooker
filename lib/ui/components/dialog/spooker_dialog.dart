import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

class SpookerDialog extends HookConsumerWidget {
  SpookerDialog(this.form, this.titleForm);

  final List<Widget> form;
  final String titleForm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SpookerSize.borderRadius)),
      elevation: 0,
      backgroundColor: SpookerColors.transparent,
      child: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.7,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: SpookerColors.completeLight,
                  borderRadius: BorderRadius.circular(SpookerSize.borderRadius),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 10),
                        blurRadius: 30),
                  ]),
              child: Padding(
                padding: EdgeInsets.all(SpookerSize.paddingSize),
                child: Column(children: getWholeData(context)),
              )),
        ],
      ),
    );
  }

  List<Widget> getWholeData(BuildContext context) {
    form.insertAll(
      0,
      [
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
      ],
    );
    return form;
  }
}
