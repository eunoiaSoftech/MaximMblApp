import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_app/features/legals/data/models/legal_document_list_resp.dart';
import 'package:logistics_app/features/legals/data/repositories/legals_repo.dart';
import 'package:logistics_app/features/legals/presentation/blocs/legals_events/legal_document_list_events.dart';
import 'package:logistics_app/features/legals/presentation/blocs/legals_events/legals.dart';
import 'package:logistics_app/features/legals/presentation/blocs/legals_states/legal_document_list_states.dart';
import 'package:logistics_app/features/legals/presentation/blocs/legals_states/legals.dart';

class LegalDocumentListBloc extends Bloc<LegalsEvent, LegalsState> {
  final LegalsRepository repository;

  LegalDocumentListBloc(this.repository) : super(LegalDocumentListInitial()) {
    on<LegalDocumentListEvent>(_getLegalDocumentList);
  }

  _getLegalDocumentList(event, emit) async {
    if (event is LegalDocumentListEvent) {
      emit(LegalDocumentListLoading());
      try {
        LegalDocumentListResp resp =
            await repository.getLegalDocumentListRepo(event.vehicleId);
        if (resp.statusCode == 0) {
          emit(LegalDocumentListLoaded(resp));
        } else {
          emit(LegalDocumentListError(resp.message ?? "Something Went Wrong"));
        }
      } catch (e) {
        emit(LegalDocumentListError("Failed to login! $e"));
      }
    }
  }
}
