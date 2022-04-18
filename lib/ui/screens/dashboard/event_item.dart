import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/model/event.dart';
import '../../components/outputs/custom_tag_text.dart';
import '../../components/spooker_borders.dart';
import '../../utils/spooker_colors.dart';
import '../../utils/spooker_fonts.dart';
import '../../utils/spooker_sizes.dart';

class EventItem extends HookConsumerWidget {
  const EventItem({Key? key, required this.event}) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(bottom: SpookerSize.m10),
      height: SpookerSize.m120,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(top: SpookerSize.m10),
            width: SpookerSize.m120,
            height: SpookerSize.m30,
            decoration: BoxDecoration(
                color: SpookerColors.spookerBlue,
                borderRadius: SpookerBorders.borderTag),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  "#${event.tags.toUpperCase()}",
                  style: SpookerFonts.tagText,
                )),
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
            height: SpookerSize.m120,
            decoration: BoxDecoration(
                gradient: SpookerColors.rightGradient,
                borderRadius: SpookerBorders.borderRadiusLeft),
          ),
          // Card con informacion
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: SpookerSize.m10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: DecoratedBox(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: SpookerColors.lightGray,
                                      blurRadius: 4,
                                      spreadRadius: 4,
                                      offset: Offset(4, 4),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          SpookerBorders.borderRadiusRight,
                                      color: SpookerColors.completeLight),
                                  height: SpookerSize.m110,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: SpookerSize.m30,
                                      ),
                                      Text(event.date,
                                          textAlign: TextAlign.center,
                                          style: SpookerFonts.eventDateText),
                                      Text(event.name,
                                          textAlign: TextAlign.center,
                                          style: SpookerFonts.eventNameText),
                                      Text(event.description,
                                          textAlign: TextAlign.center,
                                          style: SpookerFonts
                                              .eventDescriptionText),
                                    ],
                                  ),
                                ))),
                      ],
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: TagText(tagText: event.userName),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
