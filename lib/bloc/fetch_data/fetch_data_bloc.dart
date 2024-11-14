import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wild_rice_locator/data/service/rice_data.dart';

part 'fetch_data_event.dart';
part 'fetch_data_state.dart';

class FetchDataBloc extends Bloc<FetchDataEvent, FetchDataState> {
  FetchDataBloc() : super(FetchDataInitial()) {
    on<FetchDataEvent>((event, emit) async {
      // TODO: implement event handler

      if (event is FetchData) {
        final data = await RiceData().getRiceData();

        emit(FetchDataLoaded(data));

        try {} catch (e) {
          emit(FetchDataError(e.toString()));
        }
      }
    });
  }
}
