import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:need_in_choice/views/pages/ad_finalisation/bloc/location_bloc.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

class UpdateAdressBottomSheet extends StatelessWidget {
  const UpdateAdressBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController locationAddress = TextEditingController();

    return BlocProvider<LocationBloc>(
      create: (context) => LocationBloc(),
      child: Container(
        height: 600,
        decoration: BoxDecoration(
            color: kWhiteColor, borderRadius: BorderRadius.circular(100)),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Update Location',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: kBlackColor, fontSize: 35),
              ),
              kHeight10,
              Text(
                'Saved Adress',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              kHeight10,
              Text(
                ' Calletic Technologies Pvt Ltd \n4th Floor, Nila, Technopark Campus, \nTechnopark Campus, Kazhakkoottam, \nThiruvananthapuram, Kerala 695581',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              kHeight20,
              BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, state) {
                bool isLoading = false;
                if (state is LocationLoading) {
                  isLoading = true;
                } else if (state is LocationLoaded) {
                  isLoading = false;
                  locationAddress.text = state.address;
                }
                return Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        context.read<LocationBloc>().add(FetchLocationEvent());
                      },
                      child: Row(
                        children: [
                          RichText(
                            text: TextSpan(
                                text: 'Auto Fetch',
                                style: Theme.of(context).textTheme.labelMedium,
                                children: [
                                  TextSpan(
                                    text: ' Location',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(color: kPrimaryColor),
                                  )
                                ]),
                          ),
                          kWidth5,
                          isLoading == true
                              ? const CircularProgressIndicator()
                              : const Icon(Icons.refresh),
                        ],
                      ),
                    ),
                    kHeight10,
                    Container(
                        height: 217,
                        width: 359,
                        decoration: BoxDecoration(
                            color: const Color(0XFFF3F3F3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: (state is LocationLoaded)
                                ? Text(locationAddress.text,
                                    //  ' Calletic Technologies Pvt Ltd \n4th Floor, Nila, Technopark Campus, \nTechnopark Campus, Kazhakkoottam, \nThiruvananthapuram, Kerala 695581',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: 16,
                                            color: const Color(0XFF525151)))
                                : Text(
                                    //  locationAddress.text,
                                    ' Calletic Technologies Pvt Ltd \n4th Floor, Nila, Technopark Campus, \nTechnopark Campus, Kazhakkoottam, \nThiruvananthapuram, Kerala 695581',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: 16,
                                            color: const Color(0XFF525151))))),
                  ],
                );
              }),
              kHeight10,
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0XFF303030)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  elevation: MaterialStateProperty.all<double>(0),
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(321, 61)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: RichText(
                  text: TextSpan(
                      text: 'Save',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import '../../../../utils/colors.dart';
// import '../../../../utils/constants.dart';

// class UpdateAdressBottomSheet extends StatefulWidget {
//   const UpdateAdressBottomSheet({
//     super.key,
//   });

//   @override
//   State<UpdateAdressBottomSheet> createState() => _UpdateAdressBottomSheetState();
// }

// class _UpdateAdressBottomSheetState extends State<UpdateAdressBottomSheet> {

// var address;
//  final TextEditingController _addressController = TextEditingController();
//   bool _isGetLocation = false;

//    Future<Position> _determinePosition() async {
//     bool serviceEnabled = false;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     print("lo $serviceEnabled");
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     return await Geolocator.getCurrentPosition();
//   }




//   Future<void> getAddressFromLatLon(Position position) async {
//     position = await Geolocator.getCurrentPosition(
//             desiredAccuracy: LocationAccuracy.bestForNavigation)
//         .timeout(const Duration(seconds: 5));

//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );
//       String? street = placemarks[0].street;
//       String? city = placemarks[0].locality;
//       String? state = placemarks[0].administrativeArea;
//       String? country = placemarks[0].country;
//       String? postalCode = placemarks[0].postalCode;
//       address = '$street,\n$city,\n$state, $country,\nPincode : $postalCode';

//       setState(() {
//         print(street);
//         _addressController.text = address;
//       });
//     } catch (err) {}
//   }



// getPosition() async {
//     setState(() {
//       _isGetLocation = true;
//     });
//     Position position = await _determinePosition();
//     getAddressFromLatLon(position);
//     setState(() {
//       _isGetLocation = false;
//     });
//   }


//   @override
//   Widget build(BuildContext context) {

    
//     return Container(
//       height: 600,
//       decoration: BoxDecoration(
//           color: kWhiteColor, borderRadius: BorderRadius.circular(100)),
//       child: Padding(
//         padding: const EdgeInsets.all(30),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'Update Location',
//               style: Theme.of(context)
//                   .textTheme
//                   .titleLarge!
//                   .copyWith(color: kBlackColor, fontSize: 35),
//             ),
//             kHeight10,
//             Text(
//               'Saved Adress',
//               style: Theme.of(context).textTheme.labelMedium,
//             ),
//             kHeight10,
//             Text(
//               ' Calletic Technologies Pvt Ltd \n4th Floor, Nila, Technopark Campus, \nTechnopark Campus, Kazhakkoottam, \nThiruvananthapuram, Kerala 695581',
//               style: Theme.of(context).textTheme.bodySmall,
//             ),
//             kHeight20,
//             InkWell(
//               onTap: () async {
//                  await getPosition();
//                         setState(() {
//                         // update address value based on new location;
//                               _addressController.text;
//                         });
//               },
//               child: Row(
//                 children: [
//                   RichText(
//                     text: TextSpan(
//                         text: 'Auto Fetch',
//                         style: Theme.of(context).textTheme.labelMedium,
//                         children: [
//                           TextSpan(
//                             text: ' Location',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .labelMedium!
//                                 .copyWith(color: kPrimaryColor),
//                           )
//                         ]),
//                   ),
//                   kWidth5,
//                   const Icon(Icons.refresh),
//                 ],
//               ),
//             ),
//             kHeight10,
//             Container(
//               height: 217,
//               width: 359,
//               decoration: BoxDecoration(
//                   color: const Color(0XFFF3F3F3),
//                   borderRadius: BorderRadius.circular(10)),
//               child: Center(
//                   child: Text(
//                       ' Calletic Technologies Pvt Ltd \n4th Floor, Nila, Technopark Campus, \nTechnopark Campus, Kazhakkoottam, \nThiruvananthapuram, Kerala 695581',
//                       style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                           fontSize: 16, color: const Color(0XFF525151)))),
//             ),
//             kHeight10,
//             ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor:
//                     MaterialStateProperty.all(const Color(0XFF303030)),
//                 shape: MaterialStateProperty.all(
//                   RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(100)),
//                 ),
//                 elevation: MaterialStateProperty.all<double>(0),
//                 minimumSize:
//                     MaterialStateProperty.all<Size>(const Size(321, 61)),
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: RichText(
//                 text: TextSpan(
//                     text: 'Save',
//                     style: Theme.of(context)
//                         .textTheme
//                         .labelLarge!
//                         .copyWith(color: kWhiteColor, fontSize: 23),
//                     children: [
//                       TextSpan(
//                         text: 'Location',
//                         style: Theme.of(context)
//                             .textTheme
//                             .labelLarge!
//                             .copyWith(color: kPrimaryColor, fontSize: 23),
//                       ),
//                     ]),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
