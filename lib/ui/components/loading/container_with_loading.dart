import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/loading/loading.dart';

import '../../loading_state_view_model.dart';

class ContainerWithLoading extends ConsumerWidget {
  const ContainerWithLoading(this._child);

  final Widget _child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loadingStateProvider);
    return Stack(children: [
      _child,
      state.isLoading ? const Loading() : const SizedBox(),
    ]);
  }
}
