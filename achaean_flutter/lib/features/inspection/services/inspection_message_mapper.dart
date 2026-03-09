import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:injectable/injectable.dart';

import '../cubit/repo_inspection_state.dart';

@injectable
class InspectionMessageMapper
    implements IStateMessageMapper<RepoInspectionState> {
  @override
  MessageKey? map(RepoInspectionState state) {
    if (state.status == UiFlowStatus.success && state.result != null) {
      return const MessageKey.success('inspection.complete');
    }
    return null;
  }
}
