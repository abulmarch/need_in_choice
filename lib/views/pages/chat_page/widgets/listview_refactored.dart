import 'package:flutter/material.dart';
import 'package:need_in_choice/views/pages/chat_page/widgets/elevated_button.dart';
import '../../../../config/theme/screen_size.dart';
import '../../../../utils/colors.dart';
import '../../../widgets_refactored/dashed_line_generator.dart';


bool isYes = true;

class ChatListViewBuilder extends StatelessWidget {
  const ChatListViewBuilder({super.key});
  @override
  Widget build(BuildContext context) {
    final height = ScreenSize.size.height;
    final width = ScreenSize.size.width;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(
                  height: height * 0.095,
                  child: Column(children: [
                    SizedBox(
                      height: height * 0.001,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.01,
                        ),
                        Stack(children: [
                          Card(
                            child: Container(
                              height: height * 0.08,
                              width: 60,
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(
                                  'assets/images/dummy/house_for_rent1.png'),
                            ),
                          ),
                          Positioned(
                            left: 11,
                            child: Container(
                              width: 45,
                              height: 13,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  border: Border.all(color: Colors.green),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25))),
                              child: const Center(
                                child: Text(
                                  'Price',
                                  style: TextStyle(
                                      color: kWhiteColor,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 6),
                                ),
                              ),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatView()));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Anjitha',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color: kBlackColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            15), //TextStyle(color: kFadedBlack),
                              ),
                              Text(
                                'Modern Contrper Home ...',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color: kGreyColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            12), //TextStyle(color: kFadedBlack),
                                overflow: TextOverflow.ellipsis,
                              ),
                              DashedLineGenerator(
                                width: constraints.maxWidth - 200,
                              ),
                              Text(
                                'we agreed on Rs 353453',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            9), //TextStyle(color: kFadedBlack),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        InkWell(
                            onTap: () {
                              _show(context);
                            },
                            child:
                                Image.asset('assets/images/icons/Burger.png'))
                      ],
                    )
                  ]),
                ),
                const SizedBox(
                  height: 2,
                ),
                DashedLineGenerator(
                  width: constraints.maxWidth - 65,
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            );
          });
    });
  }

  void _show(BuildContext ctx) {
    final double height = MediaQuery.of(ctx).size.height;
    final double width = MediaQuery.of(ctx).size.width;

    showModalBottomSheet(
      elevation: 10,
      context: ctx,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: width * .5,
          height: height * .28,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Remove &',
                    style: Theme.of(ctx)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: kDarkGreyColor),
                    children: [
                      TextSpan(
                        text: ' Delete\n',
                        style: Theme.of(ctx)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: kButtonRedColor),
                      ),
                      TextSpan(
                        text: 'Chat Now',
                        style: Theme.of(ctx)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: kButtonRedColor),
                      ),
                      TextSpan(
                        text: '...',
                        style: Theme.of(ctx)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: kDarkGreyColor),
                      ),
                    ],
                  ),
                ),
                DashedLineGenerator(
                  width: width,
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildElevatedButton(
                        value: isYes,
                        onPressed: () {},
                        label: 'Yes',
                        primaryColor: kButtonRedColor,
                        buttonColor: kButtonColor,
                        textColor: kWhiteColor,
                        width: width,
                        height: height),
                    buildElevatedButton(
                      value: !isYes,
                      onPressed: () {},
                      label: 'No',
                      primaryColor: kButtonRedColor,
                      buttonColor: kButtonColor,
                      textColor: kGreyColor,
                      width: width,
                      height: height,
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
