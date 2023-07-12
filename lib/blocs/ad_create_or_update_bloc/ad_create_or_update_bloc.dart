import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:need_in_choice/services/model/ad_create_or_update_model.dart';
import '../../services/repositories/ad_create_or_update_service.dart';
import '../../services/repositories/get_location.dart';

part 'ad_create_or_update_event.dart';
part 'ad_create_or_update_state.dart';

class AdCreateOrUpdateBloc extends Bloc<AdCreateOrUpdateEvent, AdCreateOrUpdateState> {
  final CreateOrUpdateAdsRepo createOrUpdateAdsRepo;

  AdCreateOrUpdateModel? _adCreateOrUpdateModel;
  StreamController<List<dynamic>>? _imageListController;        // = StreamController<List<dynamic>>.broadcast();
  StreamController<String>? _addressStreamController;

  AdCreateOrUpdateBloc(this.createOrUpdateAdsRepo) : super(AdCreateOrUpdateInitial()) {
    on<AdCreateOrUpdateInitialEvent>(_adCreateOrUpdateInitialEvent);
    on<AdCreateOrUpdateCheckDropDownValidattionEvent>((event, emit) {
      emit(AdCreateOrUpdateValidateState());
    });
    on<PickImageFromCameraOrGallery>(_pickImageEvent);
    on<PickOtherImageEvent>(_pickOtherImageEvent);

    on<UploadAdEvent>(_uploadAdEvent);
  }

  AdCreateOrUpdateModel get adCreateOrUpdateModel => _adCreateOrUpdateModel!;

  Stream<List<dynamic>> get imageListStream => _imageListController!.stream;
  Stream<String> get addressStream => _addressStreamController!.stream;
  


  FutureOr<void> _adCreateOrUpdateInitialEvent(AdCreateOrUpdateInitialEvent event, Emitter<AdCreateOrUpdateState> emit) async{
    _adCreateOrUpdateModel = null;
    emit(AdCreateOrUpdateLoading());
    if(event.id == null){// new ad
      _adCreateOrUpdateModel = AdCreateOrUpdateModel(
        userId: 'qwerty', 
        mainCategory: event.mainCategory,

        adsAddress: "Calletic Technologies Pvt Ltd 4th Floor, Nila, Technopark Campus, Technopark Campus, Kazhakkoottam, Thiruvananthapuram, Kerala 695581",
        // imageUrls: ['real_estate/6492a0700dc2e6_58910190.jpg','real_estate/6492a096182ab2_59995728.jpg','real_estate/6492a0bc1e3674_44337848.jpg',],
        otherImageUrls: [
          // {
          //   "image_type": "floor_plan",
          //   "url": "adsotherimage/64a9418c1584d3_13380405.jpg"
          // },
        ]
      );
      emit(const AdCreateOrUpdateLoaded());
    }else{// ad updateion
      try {
        final result = await createOrUpdateAdsRepo.fetchAdDataToUpdate(event.id!);
        _adCreateOrUpdateModel = result;
        emit(AdCreateOrUpdateLoaded(adUpdateModel: result)); 
      } catch (e){
        emit(FaildToFetchExceptionState(e.toString()));
      }
    }
  }

  FutureOr<void> _pickImageEvent(PickImageFromCameraOrGallery event, Emitter<AdCreateOrUpdateState> emit) async {
    emit(ImageFileUploadingState());
    int noOfImagesPossibleToAdd = 7 - (adCreateOrUpdateModel.imageUrls.length + adCreateOrUpdateModel.imageFiles.length);
    final ImagePicker picker = ImagePicker();
    List<XFile> xFileList = [];
    if (event.source == ImageSource.camera) {
      final XFile? image = await picker.pickImage(source: event.source);
      if(image != null){
        xFileList.add(image);
      }
    } else {
      List<XFile> imagFiles = await picker.pickMultiImage();
      xFileList.addAll(imagFiles);
    }
    if(noOfImagesPossibleToAdd > 0){
      final newFiles = xFileList.take(noOfImagesPossibleToAdd).toList();
      _adCreateOrUpdateModel = adCreateOrUpdateModel.copyWith(
        imageFiles: [...newFiles,...adCreateOrUpdateModel.imageFiles]
      );
      _notifyImageStreamController();
      emit(const ImageFileUploadedState());
    }else{
      emit(ImageFileUploadedState(exception: ImageCountExceedException()));
    }
  }
  Future<FutureOr<void>> _pickOtherImageEvent(PickOtherImageEvent event, Emitter<AdCreateOrUpdateState> emit) async {
    log('------------------------- before --------------------');
    log(adCreateOrUpdateModel.toString());
    final ImagePicker picker = ImagePicker();
    emit(OtherImageFileUploadingState());
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      List<String> otherImgUrlToDelete = [...adCreateOrUpdateModel.otherImgUrlsToDelete];
      List otherImageUrls = adCreateOrUpdateModel.otherImageUrls;
      List<Map<dynamic, dynamic>> otherImageFiles = [...adCreateOrUpdateModel.otherImageFiles];

      final fileIndex = otherImageFiles.indexWhere((map) => map['image_type'] == event.imageType);
      print('---fileIndex----------| $fileIndex');
      if (fileIndex == -1) { //  if it is not exist we need to remove it from otherImageUrls List and added to otherImageUrlToDelete List
        final urlIndex = otherImageUrls.indexWhere((map) => map['image_type'] == event.imageType);
      print('---urlIndex----------| $urlIndex');

        if(urlIndex >= 0){
          otherImgUrlToDelete.add(otherImageUrls[urlIndex]['url']);
          otherImageUrls.removeAt(urlIndex);
        }
        otherImageFiles.add({
          'image_type' : event.imageType,
          'file' : image,
        });
      }else{
        otherImageFiles[fileIndex]['file'] = image;
      }
      _adCreateOrUpdateModel = adCreateOrUpdateModel.copyWith(
        otherImageUrls: otherImageUrls,
        otherImageFiles: otherImageFiles,
        otherImgUrlsToDelete: otherImgUrlToDelete,
      );
    }
    log('------------------------- after --------------------');
    log(adCreateOrUpdateModel.toString());
    emit(OtherImageFileUploadedState());
  }
  
  
  Future<FutureOr<void>> _uploadAdEvent(UploadAdEvent event, Emitter<AdCreateOrUpdateState> emit) async {
    emit(AdUploadingProgress());
    await createOrUpdateAdsRepo.updateOrCreateAd(adCreateOrUpdateModel);
    emit(AdUploadingCompletedState());
  }

  void savePrimaryMoreInfoDetails({
    required String adsTitle,
    required String description,
    required Map<String, dynamic> prymaryInfo, 
    required Map<String, dynamic> moreInfo,
    required Map<String, dynamic> adsLevels,
    String? level4Sub,
    }) {
    _adCreateOrUpdateModel = adCreateOrUpdateModel.copyWith(
      adsTitle: adsTitle,
      description: description,
      primaryData: prymaryInfo,
      moreInfoData: moreInfo,
      adsLevels: adsLevels,
      level4Sub: level4Sub?.toLowerCase(),
    );
    log('with --- \n${adCreateOrUpdateModel.toString()}');
  }
  

  void deleteImage({required int index, required dynamic data}){
    if (data.runtimeType == String) {
      adCreateOrUpdateModel.imageUrls.remove(data);
      List<String> urlsToDelete = [...adCreateOrUpdateModel.urlsToDelete];
      urlsToDelete.add(data);
      _adCreateOrUpdateModel = adCreateOrUpdateModel.copyWith(urlsToDelete: urlsToDelete);
    } else {
      adCreateOrUpdateModel.imageFiles.removeAt(index);     
    }
    _notifyImageStreamController();
  }

  Future<String> getCurrentLocation() async{
    final position = await determinePosition();
    return await getAddressFromLatLon(position);
  }

  void saveAdsAddress(String address){
    final pinCode = findPinCode(address);
    _adCreateOrUpdateModel = adCreateOrUpdateModel.copyWith(
      adsAddress: address,
      pinCode: pinCode,
    );
    _notifyAddressStreamController();
  }
  void _notifyImageStreamController(){
    final newList = [...adCreateOrUpdateModel.imageFiles,...adCreateOrUpdateModel.imageUrls];
    _imageListController!.add(newList);
  }
  _notifyAddressStreamController(){
    _addressStreamController!.add(adCreateOrUpdateModel.adsAddress);
  }

  void initializeStreamController(){
    _imageListController = StreamController<List<dynamic>>.broadcast();
    _addressStreamController = StreamController<String>.broadcast();
    Future.delayed(const Duration(milliseconds: 250)).then((value) {
      _notifyImageStreamController();
      _notifyAddressStreamController();
    });
  }

  void dispose(){
    _imageListController?.close();
    _addressStreamController?.close();
  }
}