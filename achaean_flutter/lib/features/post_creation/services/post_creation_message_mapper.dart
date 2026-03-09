import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:injectable/injectable.dart';

import '../cubit/post_creation_state.dart';

@injectable
class PostCreationMessageMapper
    implements IStateMessageMapper<PostCreationState> {
  @override
  MessageKey? map(PostCreationState state) {
    if (state.status == UiFlowStatus.success && state.result != null) {
      return const MessageKey.success('post.creation.success');
    }
    return null;
  }
}
