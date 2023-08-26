
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../config/theme/screen_size.dart';
import '../../../services/cached_location.dart';
import '../../../services/model/autocomplete_prediction.dart';
import '../../../services/model/place_autocomplete_response.dart';
import '../../../services/repositories/key_information.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../widgets_refactored/dashed_line_generator.dart';
import '../../widgets_refactored/lottie_widget.dart';
import 'network_util.dart';

class LocationSheet extends StatefulWidget {
  const LocationSheet({
    super.key,
  });

  @override
  State<LocationSheet> createState() => _LocationSheetState();
}

class _LocationSheetState extends State<LocationSheet> {

  List<AutocompletePrediction> placePredictions = [];
  bool _textFieldFocused = false;
  CacheLocation cahedLocation = CacheLocation();
  bool _placeClicked = false;
  
Future<void> placeAutocomplet(String query) async {

  Uri uri = Uri.https(
    'maps.googleapis.com',
    'maps/api/place/autocomplete/json',
    {
      "input": query,
      "key": kGooglePlaceSearchKey,
      "components": "country:in",
      "types":"establishment",
    }
  );
  String? response = await NetworkUtility.fetchUrl(uri);
  if (response != null) {
    PlaceAutocompletResponse result = PlaceAutocompletResponse.parseAutocompleteResult(response);
    if (result.predictions != null ) {
      setState(() {
        placePredictions = result.predictions!;
      });
    }
  }
}

  @override
  Widget build(BuildContext context) {
    final double screenHeight = ScreenSize.height;
    final double screenWidth = ScreenSize.width;
    return WillPopScope(
      onWillPop: () {
        return _placeClicked ? Future.value(false) : Future.value(true);
      },
      child: SingleChildScrollView(
        child: Form(
          child: Container(
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            height: screenHeight * 0.5,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          kHeight5,
                          SizedBox(
                            width: screenWidth * .9,
                            child: TextFormField(
                              onChanged: (value) {
                                placeAutocomplet(value);
                              },
                              onTap: () {
                                setState(() {
                                  _textFieldFocused = true;
                                });
                              },
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: kWhiteColor,
                                ),
                                hintText: "Search City Area or Locality",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                                filled: true,
                                fillColor: kWhiteColor.withOpacity(.24),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          kHeight20,
                          Row(
                                      children: [
                                        const Icon(
                                          Icons.location_searching_sharp,
                                          color: kWhiteColor,
                                        ),
                                        kWidth10,
                                        Text(
                                          'Your current location',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                  color: kWhiteColor),
                                        )
                                      ],
                                    ),
                                    kHeight15,
                                    const MySeparator(
                                      color: kWhiteColor,
                                    ),
                                    kHeight15,
                                    Text(
                                      'Your Recent location',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: kWhiteColor.withOpacity(0.7)),
                                    ),
                                    kHeight15,
                          Expanded(
                            child: FutureBuilder(
                              future: cahedLocation.initializeSharedPreferences(),
                              builder: (context, snapshot)  {
                                if(snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.active){
                                  return LottieWidget.loading();
                                }
                                return ListView.separated(
                                  physics: const BouncingScrollPhysics(), 
                                  itemCount: cahedLocation.predictions.length,
                                  itemBuilder: (context, index) {
                                    log(cahedLocation.predictions.toString());
                                    return InkWell(
                                      onTap: () async {
                                        _placeClicked = true;
                                        cahedLocation.saveDataToUserProfile(cahedLocation.predictions[index], context).then((value) => Navigator.of(context).pop());
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.location_searching_sharp,
                                            color: kWhiteColor,
                                          ),
                                          kWidth10,
                                          SizedBox(
                                            width: screenWidth*0.76,
                                            child: Text(
                                              cahedLocation.predictions[index].prediction.description?? '',//'Poojapura Trivandrum',//cahedLocation.predictions[index].description
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      fontSize: 17,
                                                      fontWeight: FontWeight.w500,
                                                      color: kWhiteColor,
                                                ),
                                                overflow: TextOverflow.clip,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }, 
                                  separatorBuilder: (context, index) => kHeight15,
                                );
                              }
                            )
                          ),
                          kHeight10,
                        ],
                      ),
                      _textFieldFocused ? Container(
                        margin: const EdgeInsets.only(top: 75),
                        height: screenHeight * 0.35,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: ListView.builder(
                          itemCount: placePredictions.length,
                          itemBuilder: (ctx, index) => PlaceListTile(
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                _placeClicked = true;
                                _textFieldFocused = false;
                              });
                              cahedLocation.finadPlaceDetails(prediction: placePredictions[index], context: context).then((value) => Navigator.of(context).pop());
                            },
                            location: placePredictions[index].description!,
                          ),
    
                        ),
                      )
                      : const SizedBox(),
                    ],
                  ),
                ),
                _placeClicked ? const Center(
                  child: CircularProgressIndicator(color: kWhiteColor,),
                ) : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlaceListTile extends StatelessWidget {
  const PlaceListTile({
    super.key,
    required this.location,
    required this.onTap
  });
  final String location;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          horizontalTitleGap: 0,
          leading: const Icon(Icons.location_on),
          title: Text(
            location,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Divider(
          height: 2,
          thickness: 2,
          color: kLightGreyColor.withOpacity(0.5),
        )
      ],
    );
  }
}
