import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../widgets_refactored/dashed_line_generator.dart';
import '../../widgets_refactored/search_form_field.dart';
import 'chat_view.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SafeArea(
          child: Scaffold(
            body: Column(children: [
              Stack(children: [
                Container(
                  width: double.infinity,   // constraints.maxWidth
                  height: height * 0.17,    // constraints.maxHeight
                  margin: const EdgeInsets.only(
                    top: 5,
                    bottom: kpadding10 * 3,// 30
                    left: 5,
                    right: 5,
                  ),
                  padding: const EdgeInsets.all(kpadding10),
                  decoration: BoxDecoration(
                    color: kLightBlueWhite,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(kpadding10),
                    ),
                    border:
                        Border.all(color: kLightBlueWhiteBorder, width: 1.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: width / 2.5,
                          height: height * .06,
                          decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(0.7),
                              border: Border.all(color: kPrimaryColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25))),
                          child: const Center(
                            child: Text(
                              'Buying',
                              style: TextStyle(
                                  color: kWhiteColor,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * .05,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: width / 2.5,
                          height: height * .06,
                          decoration: BoxDecoration(
                              border: Border.all(color: kButtonColor),
                              color: kButtonColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25))),
                          child: const Center(
                            child: Text(
                              'Selling',
                              style: TextStyle(
                                  color: kGreyColor,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      const Spacer()
                    ],
                  ),
                ),
                const Positioned(
                  bottom: 0,
                  left: kpadding20,
                  right: kpadding20,
                  child: SearchFormField(
                    hintText: 'Search chat Here...',
                  ),
                ),
              ]),
              SizedBox(
                height: height * .01,
              ),
              Expanded(
                child: ListView.builder(
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
                                  const SizedBox(
                                    width: 10,
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
                                            border: Border.all(
                                                color: Colors.green),
                                            borderRadius:
                                                const BorderRadius.all(
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
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChatView()));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      child: Image.asset(
                                          'assets/images/icons/Burger.png'))
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
                    }),
              )
            ]),
          ),
        );
      },
    );
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: width / 2.5,
                      height: height * .06,
                      decoration: BoxDecoration(
                          color: kButtonRedColor,
                          border: Border.all(color: kButtonRedColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: const Center(
                        child: Text(
                          'Yes',
                          style: TextStyle(
                              color: kWhiteColor,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * .05,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: width / 2.5,
                      height: height * .06,
                      decoration: BoxDecoration(
                          border: Border.all(color: kButtonColor),
                          color: kButtonColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: const Center(
                        child: Text(
                          'No',
                          style: TextStyle(
                              color: kGreyColor,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
