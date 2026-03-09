import 'package:cubit_ui_flow/cubit_ui_flow.dart';

import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../services/i_post_creation_service.dart';
import 'post_creation_state.dart';

class PostCreationCubit extends AppCubit<PostCreationState> {
  final IPostCreationService _service;

  PostCreationCubit(this._service) : super(const PostCreationState());

  Future<void> submitPost({
    required String text,
    String? title,
    String? url,
    List<String> poleis = const [],
    List<String> tags = const [],
  }) async {
    await tryOperation(
      () async {
        final result = await _service.createPost(
          text: text,
          title: title,
          url: url,
          poleis: poleis,
          tags: tags,
        );
        return state.copyWith(
          status: UiFlowStatus.success,
          result: result,
          error: null,
        );
      },
      emitLoading: true,
    );
  }
}
