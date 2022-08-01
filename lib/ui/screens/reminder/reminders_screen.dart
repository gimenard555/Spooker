import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/main_screen_extension.dart';
import 'package:spooker/ui/screens/reminder/reminder_item.dart';

import '../../../gen/assets.gen.dart';
import '../../components/loading/container_with_loading.dart';
import '../../components/outputs/empty_view.dart';
import '../../components/top_bar_view.dart';
import '../../loading_state_view_model.dart';
import '../../utils/spooker_colors.dart';
import '../../utils/spooker_strings.dart';
import 'reminder_view_model.dart';
import 'new_reminder_screen.dart';

class RemindersScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(reminderViewModelProvider);
    final reminders =
        ref.watch(reminderViewModelProvider.select((value) => value.reminders));

    final snapshot = useFuture(
      useMemoized(() {
        return ref
            .read(loadingStateProvider)
            .whileLoading(() => viewModel.fetchReminders());
      }, [reminders.toString()]),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBarView(SpookerStrings.reminders),
            Expanded(
              child: ContainerWithLoading(
                snapshot.connectionState == ConnectionState.waiting ||
                        viewModel.reminders == null
                    ? SizedBox()
                    : reminders!.when(success: (data) {
                        if (data.isEmpty) {
                          return EmptyView();
                        }
                        return Container(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              viewModel.fetchReminders();
                            },
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: data.length,
                              itemBuilder: (_, index) {
                                return ReminderItem(data[index]);
                              },
                            ),
                          ),
                        );
                      }, failure: (e) {
                        context
                            .showErrorDialog(SpookerErrorStrings.dialogWrong);
                        return EmptyView();
                      }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: SpookerColors.spookerBlue,
        child: Assets.images.add.image(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewReminderScreen()),
          );
        },
      ),
    );
  }
}
