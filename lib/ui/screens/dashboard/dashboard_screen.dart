import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/screens/dashboard/event_item.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';
import '../../components/loading/container_with_loading.dart';
import '../../components/outputs/custom_title_text.dart';
import '../../components/outputs/custom_top_bar.dart';
import '../../loading_state_view_model.dart';
import '../../utils/spooker_sizes.dart';
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
      }, [artworks?.toString()]),
    );

    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      SizedBox(
        height: SpookerSize.m20,
      ),
      CustomTopBar(),
      ContainerWithLoading(
        child: snapshotArtworks.connectionState == ConnectionState.waiting ||
                viewModel.artworks == null
            ? SizedBox()
            : artworks!.when(success: (data) {
                if (data.isEmpty) {
                  return Center(child: Text("probando"));
                }
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(SpookerSize.m8),
                      child: CustomTextTitle(
                        titleText: SpookerStrings.artworksText,
                      ),
                    ),
                    Container(
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
                            return ArtworkItem(artwork: data[index]);
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }, failure: (e) {
                return Center(child: Text("Algo esta fallando"));
              }),
      ),
      Expanded(
          child: Container(
        child: ContainerWithLoading(
          child: snapshotEvents.connectionState == ConnectionState.waiting ||
                  viewModel.events == null
              ? SizedBox()
              : events!.when(success: (data) {
                  if (data.isEmpty) {
                    return Center(child: Text("probando"));
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: CustomTextTitle(
                          titleText: SpookerStrings.eventsText,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: SpookerSize.m10),
                          child: RefreshIndicator(
                            onRefresh: () async {
                              viewModel.fetchEvents();
                            },
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: data.length,
                              itemBuilder: (_, index) {
                                return EventItem(event: data[index]);
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }, failure: (e) {
                  return Center(child: Text("Algo esta fallando"));
                }),
        ),
      ))
    ])));
  }
}
