import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobile_trs/event_states/add_employe_event.dart';
import 'package:flutter_mobile_trs/event_states/add_employe_state.dart';
import 'package:flutter_mobile_trs/services/api_service.dart';

class AddDataBloc extends Bloc<AddDataEvent, AddDataState> {
  final ApiService apiService;

  AddDataBloc(this.apiService) : super(AddDataInitial()) {
    on<SaveData>((event, emit) async {});
  }
}
