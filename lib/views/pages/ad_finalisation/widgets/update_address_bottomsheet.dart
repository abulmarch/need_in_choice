import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, BlocProvider;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../blocs/ad_create_or_update_bloc/ad_create_or_update_bloc.dart';
import '../../../../blocs/ad_create_or_update_bloc/exception_file.dart';
import '../../../../blocs/find_address/find_address_bloc.dart';
import '../../../../config/theme/screen_size.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../widgets_refactored/error_popup.dart';

const LatLng currentLocation = LatLng(8.690652240831222, 76.9709836319089);

class UpdateAdressBottomSheet extends StatefulWidget {
  const UpdateAdressBottomSheet({Key? key}) : super(key: key);

  @override
  State<UpdateAdressBottomSheet> createState() =>
      _UpdateAdressBottomSheetState();
}

class _UpdateAdressBottomSheetState extends State<UpdateAdressBottomSheet> {
  late final GoogleMapController _controller;
  late AdCreateOrUpdateBloc adCreateOrUpdateBloc;
  late TextEditingController _textEditingController;

  String _currentAddress = '';
  LatLng? _selectedLocation;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: currentLocation,
    zoom: 10,
  );

  @override
  void initState() {
    super.initState();
    _selectedLocation = currentLocation;
    _textEditingController = TextEditingController();
    adCreateOrUpdateBloc = BlocProvider.of<AdCreateOrUpdateBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = ScreenSize.height;

    return BlocProvider(
      create: (context) => FindAddressBloc(),
      child: BlocBuilder<FindAddressBloc, FindAddressState>(
        builder: (context, state) {
          if (state is AddressLoaded) {
            _selectedLocation = state.latLng;
            _currentAddress = state.address;
            log(_currentAddress);
            _controller
                .animateCamera(CameraUpdate.newLatLngZoom(state.latLng, 12));
            _showSnackBar();
          }

          ElevatedButton? saveButton;

          if (state is AddressLoaded) {
            saveButton = _elevatedSaveButton(context);
          }
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Stack(children: [
                SizedBox(
                  height: height,
                  width: double.infinity,
                  child: GoogleMap(
                      mapToolbarEnabled: false,
                      padding: const EdgeInsets.only(bottom: 150),
                      // buildingsEnabled: true,
                      onCameraMove: (CameraPosition position) {
                        _selectedLocation = position.target;
                      },
                      mapType: MapType.normal,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                      },
                      onTap: (latLng) {
                        BlocProvider.of<FindAddressBloc>(context)
                            .add(MarkAddress(latLng));
                      },
                      markers: {
                        Marker(
                          markerId: const MarkerId('selectedLocation'),
                          position: _selectedLocation!,
                          draggable: true,
                          infoWindow: InfoWindow(
                            title: 'Location',
                            snippet: _currentAddress,
                          ),
                        ),
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    onSubmitted: (value) {
                      BlocProvider.of<FindAddressBloc>(context)
                          .add(SearchAddress(value));
                    },
                    controller: _textEditingController,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: 'Search for a location',
                      hintStyle: const TextStyle(color: kGreyColor),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: kLightGreyColor,
                      ),
                      suffix: GestureDetector(
                        onTap: () {
                          BlocProvider.of<FindAddressBloc>(context)
                              .add(SearchAddress(_textEditingController.text));
                        },
                        child: Container(
                            width: 80,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kPrimaryColor),
                            child: const Text(
                              'Search',
                              style: TextStyle(color: kWhiteColor),
                            )),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      filled: true,
                      fillColor: kWhiteColor.withOpacity(0.9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: saveButton ??
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              kBlackColor.withOpacity(0.5)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          elevation: MaterialStateProperty.all<double>(0),
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(321, 61)),
                        ),
                        onPressed: null,
                        child: RichText(
                          text: TextSpan(
                              text: 'Save ',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      color: kWhiteColor.withOpacity(0.5),
                                      fontSize: 23),
                              children: [
                                TextSpan(
                                  text: 'Location',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          color: kLightGreyColor, fontSize: 23),
                                ),
                              ]),
                        ),
                      ),
                ),
                kHeight20
              ]),
            ),
          );
        },
      ),
    );
  }

  ElevatedButton _elevatedSaveButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0XFF303030)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
        elevation: MaterialStateProperty.all<double>(0),
        minimumSize: MaterialStateProperty.all<Size>(const Size(321, 61)),
      ),
      onPressed: () async {
        try {
          adCreateOrUpdateBloc.saveAdsAddress(_currentAddress.toString());
          log("Address saved successfully.");

          Navigator.pop(context);
        } on InvalidPincodeException {
          showErrorDialog(context, 'Invalid Pincode');
        } on InvalidAddressException {
          showErrorDialog(
            context,
            'Invalid address, Include pincode in the address',
          );
        } catch (e) {
          showErrorDialog(context, 'Something went wrong');
          log('Error saving address: $e');
        }
      },
      child: RichText(
        text: TextSpan(
            text: 'Save ',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: kWhiteColor, fontSize: 23),
            children: [
              TextSpan(
                text: 'Location',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: kPrimaryColor, fontSize: 23),
              ),
            ]),
      ),
    );
  }

  void _showSnackBar() {
    Future.delayed(const Duration(microseconds: 600)).then((value) {
      SnackBar snackBar = SnackBar(
        content: Center(
            child: Text(
          _currentAddress,
          style: const TextStyle(fontSize: 11),
        )),
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 100),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0XFF979797),
        duration: const Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
