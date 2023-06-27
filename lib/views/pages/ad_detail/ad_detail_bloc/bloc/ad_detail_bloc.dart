import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../services/model/ads_models.dart';
import '../../../../../services/repositories/selected_ads_service.dart';

part 'ad_detail_event.dart';
part 'ad_detail_state.dart';

class AdDetailBloc extends Bloc<AdDetailBlocEvent, AdDetailState> {
  final SelectedAdsRepo repo;
  AdDetailBloc(this.repo) : super(AdDetailInitial()) {
    on<FetchAdDetailEvent>((event, emit) async {
      int id = event.adId;
      emit(AdDetailInitial());
      final adsModel = await repo.fetchSelectedAdsData(id);
      emit(AdDetailsLoaded(adsModel: adsModel));
    });
  }
}
