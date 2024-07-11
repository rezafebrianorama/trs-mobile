import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobile_trs/event_states/splash_event.dart';
import 'package:flutter_mobile_trs/event_states/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<LoadData>((event, emit) async {
      emit(SplashLoading());
      await Future.delayed(Duration(seconds: 2)); // Simulasi pemuatan data
      emit(SplashLoaded());
    });
  }
}
