import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/model/event.dart';
import 'package:spooker/ui/components/main_screen_extension.dart';

import '../../components/outputs/custom_tag_text.dart';
import '../../components/spooker_borders.dart';
import '../../utils/spooker_colors.dart';
import '../../utils/spooker_fonts.dart';
import '../../utils/spooker_sizes.dart';

class EventItem extends HookConsumerWidget {
  const EventItem(this._event, {this.isTag = true});

  final Event _event;
  final bool isTag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        context.showEventDetail(_event);
      },
      child: Container(
        padding: EdgeInsets.only(right: SpookerSize.m5),
        margin: EdgeInsets.only(bottom: SpookerSize.m20),
        height: SpookerSize.m150,
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: SpookerSize.m10),
              width: SpookerSize.m120,
              height: SpookerSize.m30,
              decoration: BoxDecoration(
                  color: SpookerColors.spookerBlue,
                  borderRadius: SpookerBorders.borderTag),
              child: Text(
                "#${_event.tag}",
                style: SpookerFonts.s12MediumLightGray,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: SpookerSize.m10),
              width: SpookerSize.m14,
              height: SpookerSize.m2,
              decoration: BoxDecoration(color: SpookerColors.spookerBlue),
            ),
            Container(
              margin: EdgeInsets.only(top: SpookerSize.m10),
              width: SpookerSize.m5,
              height: SpookerSize.m150,
              decoration: BoxDecoration(
                  gradient: SpookerColors.rightGradient,
                  borderRadius: SpookerBorders.borderRadiusLeft),
            ),
            // Card con informacion
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: SpookerSize.m10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: SpookerColors.lightGray),
                      borderRadius: SpookerBorders.borderRadiusRight,
                      color: SpookerColors.completeLight,
                      boxShadow: [
                        BoxShadow(
                          color: SpookerColors.lightGray,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(2, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Wrap(
                        children: [
                          Column(
                            children: [
                              Text(_event.name,
                                  textAlign: TextAlign.center,
                                  style: SpookerFonts.s24BoldBlueCommon),
                              Text(_event.date,
                                  textAlign: TextAlign.center,
                                  style: SpookerFonts.s14MediumDarkBlue),
                              Text(_event.hour,
                                  textAlign: TextAlign.center,
                                  style: SpookerFonts.s14MediumDarkBlue),
                              Text(_event.place,
                                  textAlign: TextAlign.center,
                                  style: SpookerFonts.s14RegularBlueCommon),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  getTagView()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTagView() {
    if (isTag) {
      return Align(
          alignment: Alignment.topCenter,
          child: TagText('@${_event.username}'));
    } else {
      return SizedBox();
    }
  }
}
