import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/main_screen_extension.dart';

import '../../components/loading/container_with_loading.dart';
import '../../components/outputs/empty_view.dart';
import '../../loading_state_view_model.dart';
import '../../utils/spooker_strings.dart';
import '../dashboard/event_item.dart';
import '../profile/profile_view_model.dart';

class UserEventPageView extends HookConsumerWidget {
  UserEventPageView({this.profileId = SpookerStrings.EMPTY});

  final String profileId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(profileViewModel);
    final events = ref.watch(profileViewModel.select((value) => value.events));

    final snapshotEvents = useFuture(
      useMemoized(() {
        return ref
            .read(loadingStateProvider)
            .whileLoading(() => viewModel.getEvents(userId: profileId));
      }, [events?.toString()]),
    );

    return ContainerWithLoading(
      snapshotEvents.connectionState == ConnectionState.waiting ||
              viewModel.events == null
          ? SizedBox()
          : events!.when(success: (data) {
              if (data.isEmpty) {
                return EmptyView(SpookerStrings.eventsText.toLowerCase());
              }
              return Container(
                height: double.infinity,
                width: double.infinity,
                child: RefreshIndicator(
                  onRefresh: () async {
                    viewModel.getEvents(userId: profileId);
                  },
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: data.length,
                    itemBuilder: (_, index) {
                      return EventItem(data[index], isTag: false);
                    },
                  ),
                ),
              );
            }, failure: (e) {
              context.showErrorDialog(SpookerErrorStrings.dialogWrong);
              return EmptyView(SpookerStrings.eventsText.toLowerCase(),);
            },),
    );
  }
}
