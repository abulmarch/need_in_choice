
import 'package:flutter_bloc/flutter_bloc.dart';


import 'get_location.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<FetchLocationEvent>((event, emit) async {
      emit(LocationLoading());
      final position = await determinePosition();
   
      final address = await getAddressFromLatLon(position);
    
      emit(LocationLoaded(address));
    });
  }
}
