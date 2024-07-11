import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobile_trs/event_states/home_event.dart';
import 'package:flutter_mobile_trs/event_states/home_state.dart';
import 'package:flutter_mobile_trs/services/api_service.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiService apiService;

  HomeBloc(this.apiService) : super(HomeInitial()) {
    on<LoadData>((event, emit) async {
      emit(HomeLoading());
      try {
        final data = await apiService.fetchData();
        // print(data); // Cetak data ke konsol
        emit(HomeLoaded(data));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }
}
