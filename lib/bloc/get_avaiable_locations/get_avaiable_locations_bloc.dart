import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wild_rice_locator/data/firebase_service/location.dart';
import 'package:wild_rice_locator/domain/model/firebase/location_model_fb.dart';
import 'package:wild_rice_locator/domain/model/local/location_model.dart';

part 'get_avaiable_locations_event.dart';
part 'get_avaiable_locations_state.dart';

class GetAvaiableLocationsBloc
    extends Bloc<GetAvaiableLocationsEvent, GetAvaiableLocationsState> {
  GetAvaiableLocationsBloc() : super(GetAvaiableLocationsInitial()) {
    on<GetAvaiableLocationsEvent>((event, emit) async {
      if (event is GetAvaiableLocations) {
        emit(GetAvaiableLocationsLoading());
        final locations = await LocationHandler().getLocations();
        print(locations);
        emit(GetAvaiableLocationsLoaded(locations));
      }
    });
  }
}
