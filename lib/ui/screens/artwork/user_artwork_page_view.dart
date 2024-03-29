import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/main_screen_extension.dart';
import 'package:spooker/ui/screens/artwork/user_artwork_item.dart';
import 'package:spooker/ui/screens/profile/profile_view_model.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

import '../../components/loading/container_with_loading.dart';
import '../../components/outputs/empty_view.dart';
import '../../loading_state_view_model.dart';
import '../../utils/spooker_strings.dart';

class UserArtworkPageView extends HookConsumerWidget {
  UserArtworkPageView({this.profileId = ''});

  final String profileId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(profileViewModel);
    final artworks =
        ref.watch(profileViewModel.select((value) => value.artworks));

    final snapshot = useFuture(
      useMemoized(() {
        return ref
            .read(loadingStateProvider)
            .whileLoading(() => viewModel.getArtworks(userId: profileId));
      }, [artworks?.toString()]),
    );

    return ContainerWithLoading(
      snapshot.connectionState == ConnectionState.waiting ||
              viewModel.artworks == null
          ? SizedBox()
          : artworks!.when(success: (data) {
              if (data.isEmpty) {
                return EmptyView(SpookerStrings.artworksText.toLowerCase());
              }
              return Container(
                height: double.infinity,
                width: double.infinity,
                child: RefreshIndicator(
                  onRefresh: () async {
                    viewModel.getArtworks(userId: profileId);
                  },
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: SpookerSize.m10,
                        mainAxisSpacing: SpookerSize.m10,
                        crossAxisCount: 3),
                    scrollDirection: Axis.vertical,
                    itemCount: data.length,
                    itemBuilder: (_, index) {
                      return UserArtworkItem(data[index]);
                    },
                  ),
                ),
              );
            }, failure: (e) {
              context.showErrorDialog(SpookerErrorStrings.dialogWrong);
              return EmptyView(SpookerStrings.artworksText.toLowerCase());
            }),
    );
  }
}
