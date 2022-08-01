import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

import '../../../gen/assets.gen.dart';
import '../spooker_borders.dart';

typedef OnOptionSelected = void Function(String optionSelected);

class SpinnerView extends HookConsumerWidget {
  SpinnerView(this._spinnerName, this._itemsName, this._onOptionSelected);

  final String _spinnerName;
  final List<String> _itemsName;
  final OnOptionSelected _onOptionSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final optionSelected = ref.watch(onOptionSelectedProvider);
    optionSelected.option = _itemsName[0];
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: SpookerSize.m20, horizontal: SpookerSize.zero),
            alignment: Alignment.centerLeft,
            child: Text(
              _spinnerName,
              textAlign: TextAlign.left,
              style: SpookerFonts.s14RegularDark,
            ),
          ),
        ),
        Expanded(
            child: Container(
          padding: EdgeInsets.symmetric(
              vertical: SpookerSize.zero, horizontal: SpookerSize.m20),
          decoration: BoxDecoration(
            border: Border.all(
              width: SpookerSize.m3,
              color: SpookerColors.blueCommonTextColor,
            ),
            borderRadius: SpookerBorders.m30Border,
          ),
          margin: EdgeInsets.all(SpookerSize.m10),
          alignment: Alignment.centerRight,
          child: DropdownButton<String>(
            dropdownColor: SpookerColors.completeLight,
            borderRadius: SpookerBorders.m30Border,
            icon: Assets.images.backArrow.image(),
            elevation: SpookerSize.m2.toInt(),
            underline: Container(
              height: SpookerSize.zero,
            ),
            value: optionSelected.option,
            onChanged: (newValue) {
              optionSelected.option = newValue!;
              _onOptionSelected(newValue);
            },
            items: _itemsName.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: SpookerFonts.s14RegularDark,
                ),
              );
            }).toList(),
          ),
        ))
      ],
    );
  }
}

final onOptionSelectedProvider =
    ChangeNotifierProvider((ref) => OptionSelected());

class OptionSelected extends ChangeNotifier {
  String _option = '';

  String get option => _option;

  set option(String option) {
    _option = option;

  }
}
