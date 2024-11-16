part of 'show_rice_data_bloc.dart';

@immutable
sealed class ShowRiceDataEvent {}

class ShowRiceData extends ShowRiceDataEvent {
  final Map<String, dynamic> data;

  ShowRiceData(this.data);
}

class ShowAppData extends ShowRiceDataEvent {}
