part of 'ad_create_or_update_bloc.dart';

abstract class AdCreateOrUpdateEvent extends Equatable {
  const AdCreateOrUpdateEvent();

  @override
  List<Object> get props => [];
}

class AdCreateOrUpdateInitialEvent extends AdCreateOrUpdateEvent{
  final int? id;
  final String currentPageRoute;
  final String mainCategory;
  

  const AdCreateOrUpdateInitialEvent({
    this.id,
    required this.currentPageRoute, 
    required this.mainCategory,

  });
}
class AdCreateOrUpdateCheckDropDownValidattionEvent extends AdCreateOrUpdateEvent {}

class PickImageFromCameraOrGallery extends  AdCreateOrUpdateEvent{
  final ImageSource source;

  const PickImageFromCameraOrGallery({required this.source});
}

class PickOtherImageEvent extends AdCreateOrUpdateEvent{
  final String imageType;
  /// it should be lowecase and if it is morethan one word then use underscore '_'. 
  /// eg: floor_plan, land_sketch etc
  const PickOtherImageEvent(this.imageType);
}

class UploadAdEvent extends AdCreateOrUpdateEvent{}


class SwitchToInitialStateEvent extends AdCreateOrUpdateEvent{}