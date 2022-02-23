import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../components/loading/container_with_loading.dart';
import '../../components/outputs/custom_title_text.dart';
import '../../loading_state_view_model.dart';
import 'artwork_item.dart';
import 'dashboard_view_model.dart';

class DashboardScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(dashboardViewModelProvider);
    final artworks =
        ref.watch(dashboardViewModelProvider.select((value) => value.artworks));

    final snapshot = useFuture(
      useMemoized(() {
        return ref
            .read(loadingStateProvider)
            .whileLoading(() => viewModel.fetchArtworks());
      }, [artworks?.toString()]),
    );

    return ContainerWithLoading(
      child: snapshot.connectionState == ConnectionState.waiting ||
              viewModel.artworks == null
          ? const SizedBox()
          : artworks!.when(success: (data) {
              if (data.isEmpty) {
                return Center(child: Text("probando"));
              }
              return Column(
                children: [
                  SizedBox(
                    height: 250,
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
                  CustomTextTitle()
                ],
              );
            }, failure: (e) {
              return Center(child: Text("Algo esta fallando"));
            }),
    );
  }
}
