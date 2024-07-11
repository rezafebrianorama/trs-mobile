import 'package:equatable/equatable.dart';

abstract class AddDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SaveData extends AddDataEvent {
  final Map<String, dynamic> data;

  SaveData(this.data);

  @override
  List<Object> get props => [data];
}
