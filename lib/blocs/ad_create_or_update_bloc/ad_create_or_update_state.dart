part of 'ad_create_or_update_bloc.dart';

abstract class AdCreateOrUpdateState extends Equatable {
  const AdCreateOrUpdateState();
  
  @override
  List<Object> get props => [];
}

class AdCreateOrUpdateInitial extends AdCreateOrUpdateState {}

class AdCreateOrUpdateLoading extends AdCreateOrUpdateState {}

class AdCreateOrUpdateLoaded extends AdCreateOrUpdateState {
  final AdCreateOrUpdateModel? adUpdateModel;

  const AdCreateOrUpdateLoaded({this.adUpdateModel});
}
class AdCreateOrUpdateValidateState extends AdCreateOrUpdateState {}

class FaildToFetchExceptionState extends AdCreateOrUpdateState {
  final String errorMessagge;

  const FaildToFetchExceptionState(this.errorMessagge);
}


class ImageFileUploadingState extends AdCreateOrUpdateState {}

class ImageFileUploadedState extends AdCreateOrUpdateState {
  final ImageCountExceedException? exception;

  const ImageFileUploadedState({this.exception});
}

class OtherImageFileUploadingState extends AdCreateOrUpdateState {}
class OtherImageFileUploadedState extends AdCreateOrUpdateState {}

class AdUploadingProgress extends AdCreateOrUpdateState{}
class AdUploadingCompletedState extends AdCreateOrUpdateState{}


class ImageCountExceedException implements Exception{}