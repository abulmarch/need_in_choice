import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/views/pages/account/bloc/account_page_bloc.dart';
import 'package:need_in_choice/views/pages/account/widgets/ad_tiles.dart';
import 'package:need_in_choice/views/pages/account/widgets/address_bar.dart';
import 'package:need_in_choice/views/pages/account/widgets/viewing_tiles.dart';

import '../../../utils/constants.dart';
import '../../widgets_refactored/search_form_field.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountPageBloc, AccountPageState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children:const [
                    AddressBar(),
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: kpadding20),
                      child: SearchFormField(
                        hintText: 'Search your Ads',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 510,
                  child: ListView.builder(
                    padding: const EdgeInsetsDirectional.symmetric(
                      vertical: kpadding15,
                      horizontal: kpadding15 * 2,
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      if (state is ViewPressedState) {
                        return const ViewingTiles();
                      }
                      return const Adtiles();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
