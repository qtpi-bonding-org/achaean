import 'package:cubit_ui_flow/cubit_ui_flow.dart';

import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../services/i_post_creation_service.dart';
import 'own_posts_state.dart';

class OwnPostsCubit extends AppCubit<OwnPostsState> {
  final IPostCreationService _service;

  OwnPostsCubit(this._service) : super(const OwnPostsState());

  Future<void> loadPosts() async {
    await tryOperation(
      () async {
        final posts = await _service.getOwnPosts();
        return state.copyWith(
          status: UiFlowStatus.success,
          posts: posts,
          error: null,
        );
      },
      emitLoading: true,
    );
  }
}
