import 'package:logistics_app/features/legals/data/models/legal_document_list_resp.dart';
import 'package:logistics_app/features/legals/presentation/blocs/legals_states/legals.dart';

/// loading ...
class LegalDocumentListLoading extends LegalsState {}

/// success ...
class LegalDocumentListLoaded extends LegalsState {
  final LegalDocumentListResp resp;

  LegalDocumentListLoaded(this.resp);

  @override
  List<Object?> get props => [resp];
}

/// error ...
class LegalDocumentListError extends LegalsState {
  final String error;

  LegalDocumentListError(this.error);

  @override
  List<Object?> get props => [error];
}
