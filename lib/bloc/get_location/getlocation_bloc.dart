import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:meta/meta.dart';
import 'package:wild_rice_locator/data/location_service/get_location.dart';
import 'package:wild_rice_locator/domain/model/local/location_model.dart';

part 'getlocation_event.dart';
part 'getlocation_state.dart';

class GetlocationBloc extends Bloc<GetlocationEvent, GetlocationState> {
  GetlocationBloc() : super(GetlocationInitial()) {
    on<GetlocationEvent>((event, emit) async {
      if (event is GetLocation) {
        emit(GetlocationLoading());
        final location = await GetUserLocation().getAddressFromLatLng();
        emit(GetlocationLoaded(location));
      } else if (event is UpdateLocation) {
        emit(GetlocationLoading());
        final location = await GetUserLocation().updateLocation(event.position);
        emit(GetlocationLoaded(location));
      }
    });
  }
}
