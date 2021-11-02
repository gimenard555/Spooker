import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'form_text_field_states.dart';

class FormTextFieldView extends StatelessWidget {
  FormTextFieldView();

  /*final String hintText;
  final bool isPassword;
  final bool isNumber;
  final ErrorType error;
  final int lenght;
  final TextEditingController textController;*/

  @override
  Widget build(BuildContext context) {
    return HookBuilder(builder: (context) {
      final FormTextFieldViewModel provider =
          context.read(formTextStateProvider);
    });
  }
}
