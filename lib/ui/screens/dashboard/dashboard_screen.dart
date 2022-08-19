import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/main_screen_extension.dart';
import 'package:spooker/ui/screens/dashboard/event_item.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';
import '../../../gen/assets.gen.dart';
import '../../components/loading/container_with_loading.dart';
import '../../components/outputs/custom_title_text.dart';
import '../../components/outputs/custom_top_bar.dart';
import '../../components/outputs/empty_view.dart';
import '../../loading_state_view_model.dart';
import '../../utils/spooker_colors.dart';
import '../../utils/spooker_sizes.dart';
import '../profile/profile_screen.dart';
import '../reminder/reminders_screen.dart';
import 'artwork_item.dart';
import 'dashboard_view_model.dart';

class DashboardScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(dashboardViewModelProvider);
    final artworks =
        ref.watch(dashboardViewModelProvider.select((value) => value.artworks));
    final events =
        ref.watch(dashboardViewModelProvider.select((value) => value.events));

    final snapshotArtworks = useFuture(
      useMemoized(() {
        return ref
            .read(loadingStateProvider)
            .whileLoading(() => viewModel.fetchArtworks());
      }, [artworks?.toString()]),
    );

    final snapshotEvents = useFuture(
      useMemoized(() {
        return ref
            .read(loadingStateProvider)
            .whileLoading(() => viewModel.fetchEvents());
      }, [events?.toString()]),
    );

    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        Container(
            margin: EdgeInsets.symmetric(
                horizontal: SpookerSize.m10, vertical: SpookerSize.m5),
            child: CustomTopBar(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            }, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RemindersScreen()),
              );
            })),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: SpookerSize.m20, vertical: SpookerSize.m10),
          child: CustomTextTitle(
            titleText: SpookerStrings.artworksText,
          ),
        ),
        ContainerWithLoading(
          snapshotArtworks.connectionState == ConnectionState.waiting ||
                  viewModel.artworks == null
              ? SizedBox()
              : artworks!.when(success: (data) {
                  if (data.isEmpty) {
                    return EmptyView();
                  }
                  return Container(
                    height: SpookerSize.m200,
                    width: double.infinity,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        viewModel.fetchArtworks();
                      },
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (_, index) {
                          return ArtworkItem(data[index]);
                        },
                      ),
                    ),
                  );
                }, failure: (e) {
                  context.showErrorDialog(SpookerErrorStrings.dialogWrong);
                  return EmptyView();
                }),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: SpookerSize.m20, vertical: SpookerSize.m20),
          child: CustomTextTitle(
            titleText: SpookerStrings.eventsText,
          ),
        ),
        Expanded(
          child: ContainerWithLoading(
            snapshotEvents.connectionState == ConnectionState.waiting ||
                    viewModel.events == null
                ? SizedBox()
                : events!.when(success: (data) {
                    if (data.isEmpty) {
                      return EmptyView();
                    }
                    return Container(
                      padding: EdgeInsets.all(SpookerSize.m10),
                      height: double.infinity,
                      width: double.infinity,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          viewModel.fetchEvents();
                        },
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: data.length,
                          itemBuilder: (_, index) {
                            return EventItem(data[index]);
                          },
                        ),
                      ),
                    );
                  }, failure: (e) {
                    context.showErrorDialog(SpookerErrorStrings.dialogWrong);
                    return EmptyView();
                  }),
          ),
        )
      ])),
      floatingActionButton: FloatingActionButton(
        backgroundColor: SpookerColors.spookerBlue,
        child: Assets.images.add.image(),
        onPressed: () {
          context.showOptions();
        },
      ),
    );
  }
}
