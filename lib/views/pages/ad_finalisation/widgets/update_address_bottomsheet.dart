import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;

import '../../../../blocs/ad_create_or_update_bloc/ad_create_or_update_bloc.dart';
import '../../../../blocs/ad_create_or_update_bloc/exception_file.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../widgets_refactored/error_popup.dart';

class UpdateAdressBottomSheet extends StatefulWidget {
  const UpdateAdressBottomSheet({super.key});

  @override
  State<UpdateAdressBottomSheet> createState() => _UpdateAdressBottomSheetState();
}

class _UpdateAdressBottomSheetState extends State<UpdateAdressBottomSheet> {
 late TextEditingController _addressController;
  late ValueNotifier<bool> _fetchLocationLoader;
  late ScrollController _scrollController;
  bool _firstFocustap = true;
  late AdCreateOrUpdateBloc adCreateOrUpdateBloc;
  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
    _fetchLocationLoader = ValueNotifier(false);
    _scrollController = ScrollController();
    adCreateOrUpdateBloc = BlocProvider.of<AdCreateOrUpdateBloc>(context);
    _addressController.text = adCreateOrUpdateBloc.adCreateOrUpdateModel.adsAddress;
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: EdgeInsets.only(left: 30,right: 30,top: 30,bottom: MediaQuery.of(context).viewInsets.bottom,),
      child: Column(
        children: [
          SizedBox(
            height: 520,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 50,
                    maxHeight: 70,
                  ),
                  child: Text(
                    adCreateOrUpdateBloc.adCreateOrUpdateModel.adsAddress,
                    // 'Calletic Technologies Pvt Ltd 4th Floor, Nila, Technopark Campus, Technopark Campus, Kazhakkoottam, Thiruvananthapuram, Kerala 695581',
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                kHeight20,
                SizedBox(
                  height: 30,
                  child: InkWell(
                    onTap: () async {
                      try {
                        _fetchLocationLoader.value = true;
                        _addressController.text = await adCreateOrUpdateBloc.getCurrentLocation();
                        _fetchLocationLoader.value = false;
                      } catch (e) {
                        _fetchLocationLoader.value = false;
                        log(e.toString());
                      }
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
                        ValueListenableBuilder(
                          valueListenable: _fetchLocationLoader,
                          builder: (context, isLoading, _) {
                            return isLoading 
                            ? const SizedBox(
                              width: 18, height: 18,
                              child: CircularProgressIndicator(color: Colors.black,strokeWidth: 3),
                            ) 
                            : const Icon(Icons.refresh,size: 30);
                          }
                        ),
                      ],
                    ),
                  ),
                ),
                kHeight10,
                SizedBox(
                  height: 217,
                  width: 359,
                  child: TextFormField(
                    controller: _addressController,
                    // initialValue: 'Calletic Technologies Pvt Ltd 4th Floor, Nila, Technopark Campus, Technopark Campus, Kazhakkoottam, Thiruvananthapuram, Kerala 695581',
                    minLines: 15,
                    maxLines: 19,
                    textAlignVertical: TextAlignVertical.center,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16, color: const Color(0XFF525151)),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFCACACA)),
                      ),
                    ),
                    onTapOutside: (event) {
                      _firstFocustap = true;
                      FocusScope.of(context).unfocus();
                    },
                    onTap: () async {
                        if(_firstFocustap){
                          _firstFocustap = false;
                          await Future.delayed(const Duration(milliseconds: 700));
                        }
                        if (_scrollController.position.maxScrollExtent *0.55 > _scrollController.position.pixels) {
                          _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 400), 
                            curve: Curves.linear,
                          );
                        }
                    },
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0XFF303030)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    ),
                    elevation: MaterialStateProperty.all<double>(0),
                    minimumSize: MaterialStateProperty.all<Size>(const Size(321, 61)),
                    ),
                  onPressed: () {
                    try {
                      adCreateOrUpdateBloc.saveAdsAddress(_addressController.text);
                      Navigator.pop(context);
                    } on InvalidPincodeException{
                      showErrorDialog(context, 'Invalid Pincod');
                    } on InvalidAddressException{
                      showErrorDialog(context, 'Invalid address, Include pincod in the address');
                    }
                    catch (e) {
                      showErrorDialog(context, 'Something went wrong');
                    }
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Save', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: kWhiteColor, fontSize: 23),
                      children: [
                        TextSpan(
                      text: 'Location', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: kPrimaryColor, fontSize: 23),),
                      ]
                    ),
                  ),
                ),
                const Spacer()
              ],
            ),
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    _addressController.dispose();
    _fetchLocationLoader.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
