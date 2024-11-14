import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'show_rice_data_event.dart';
part 'show_rice_data_state.dart';

class ShowRiceDataBloc extends Bloc<ShowRiceDataEvent, ShowRiceDataState> {
  ShowRiceDataBloc() : super(ShowRiceDataInitial()) {
    on<ShowRiceDataEvent>((event, emit) {
      if (event is ShowRiceData) {
        emit(ShowRiceDataLoaded(event.data));
      }
    });
  }
}
