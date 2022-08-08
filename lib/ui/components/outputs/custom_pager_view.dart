import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

import '../../screens/artwork/user_artwork_page_view.dart';
import '../../screens/event/user_event_page_view.dart';
import 'custom_title_text.dart';

class CustomPagerView extends HookConsumerWidget {
  final List<String> _options = ["Artworks", "Events"];
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagerState = ref.watch(pagerStateProvider);
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  if (pagerState.selectedPage != 0) {
                    _controller.jumpTo(-800);
                  }
                  pagerState.setSelectedPage(0);
                },
                child: CustomTextTitle(
                    titleText: _options[0],
                    highlight: pagerState.selectedPage == 0),
              )),
              Expanded(
                  child: InkWell(
                onTap: () {
                  if (pagerState.selectedPage != 1) {
                    _controller.jumpTo(800);
                  }
                  pagerState.setSelectedPage(1);
                },
                child: CustomTextTitle(
                    titleText: _options[1],
                    highlight: pagerState.selectedPage == 1),
              ))
            ],
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: SpookerSize.m20),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return ListView(
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        child: UserArtworkPageView(),
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                      ),
                      Divider(
                        height: 2,
                        color: Colors.black,
                      ),
                      Container(
                        child: UserEventPageView(),
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final pagerStateProvider =
    ChangeNotifierProvider((ref) => PagerSelectedState());

class PagerSelectedState extends ChangeNotifier {
  int _selectedPage = 0;

  int get selectedPage => _selectedPage;

  void setSelectedPage(int page) {
    _selectedPage = page;
    notifyListeners();
  }
}
