part of 'fetch_data_bloc.dart';

@immutable
sealed class FetchDataState {}

final class FetchDataInitial extends FetchDataState {}

final class FetchDataLoading extends FetchDataState {}

final class FetchDataLoaded extends FetchDataState {
  final List<Map<String, dynamic>> data;

  FetchDataLoaded(this.data);
}

final class FetchDataError extends FetchDataState {
  final String error;

  FetchDataError(this.error);
}
