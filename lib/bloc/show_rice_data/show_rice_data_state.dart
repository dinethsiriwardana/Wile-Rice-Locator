part of 'show_rice_data_bloc.dart';

@immutable
sealed class ShowRiceDataState {}

final class ShowRiceDataInitial extends ShowRiceDataState {}

final class ShowRiceDataLoading extends ShowRiceDataState {}

final class ShowRiceDataLoaded extends ShowRiceDataState {
  final Map<String, dynamic> data;

  ShowRiceDataLoaded(this.data);
}

final class ShowAppDataState extends ShowRiceDataState {}
