import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../event/user_event_page_view.dart';
import '../profile/profile_view_model.dart';

class SpookerScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _viewModel = ref.watch(profileViewModel);
    _viewModel.getProfile();
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: UserEventPageView(profileId: _viewModel.user?.id ?? ''),
        ),
      ),
    );
  }
}
