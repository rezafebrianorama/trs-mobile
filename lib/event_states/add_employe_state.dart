import 'package:equatable/equatable.dart';

abstract class AddDataState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddDataInitial extends AddDataState {}

class AddDataLoading extends AddDataState {}

class AddDataSuccess extends AddDataState {}

class AddDataError extends AddDataState {
  final String message;

  AddDataError(this.message);

  @override
  List<Object> get props => [message];
}
