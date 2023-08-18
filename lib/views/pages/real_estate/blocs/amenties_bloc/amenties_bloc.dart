import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'amenties_event.dart';
part 'amenties_state.dart';

class AmentiesBloc extends Bloc<AmentiesEvent, AmentiesState> {
  AmentiesBloc() : super(AmentiesInitial()) {
    on<ToggleAmentiesSelectionEvent>((event, emit) {
 
      List<String> amentiesList = List<String>.from(event.amentiesList);
      if (amentiesList.contains(event.amenties)) {
        amentiesList.remove(event.amenties);
      } else {
        amentiesList.add(event.amenties);
      }

      emit(AmentiesLoadedState(amentiesList));
    });
  
  }
}
