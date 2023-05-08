import 'package:flutter/material.dart';
import 'package:need_in_choice/views/widgets_refactored/dashed_line_generator.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});

  final List<String> messages = [
    "Modern zxzvzvzxvzvzvzxv Home ...",
    "Modern zxzvzvzxvzvzvzxv Home ...",
    "Modern zxzvzvzxvzvzvzxv Home ...Modern zxzvzvzxvzvzvzxv Home ...Modern zxzvzvzxvzvzvzxv Home ...Modern zxzvzvzxvzvzvzxv Home ...",
    "Modern zxzvzvzxvzvzvzxv Home ...Modern zxzvzvzxvzvzvzxv Home ...Modern zxzvzvzxvzvzvzxv Home ...Modern zxzvzvzxvzvzvzxv Home ...",
    "Modern zxzvzvzxvzvzvzxv Home ...",
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SafeArea(
          child: Scaffold(
              body: Column(children: [
        Container(
          width: double.infinity,
          height: height * 0.18,
          margin: const EdgeInsets.only(
            top: kpadding10 / 2,
            bottom: kpadding10 * 3,
            left: kpadding10 / 2,
            right: kpadding10 / 2,
          ),
          padding: const EdgeInsets.all(kpadding10),
          decoration: BoxDecoration(
            color: kLightBlueWhite,
            borderRadius: const BorderRadius.all(
              Radius.circular(kpadding10),
            ),
            border: Border.all(color: kLightBlueWhiteBorder, width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const CircleAvatar(
                    radius: 23,
                    backgroundColor: kButtonColor,
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      color: kBlackColor,
                      size: 30,
                    )),
              ),
              SizedBox(
                width: width * 0.01,
              ),
              DashedLineHeight(
                height: constraints.maxWidth - 65,
              ),
              SizedBox(
                width: width * 0.01,
              ),
              Card(
                child: Container(
                  height: height * 0.1,
                  width: width * 0.21,
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset('assets/images/dummy/house_for_rent1.png'),
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Anjitha',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: kBlackColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 15), //TextStyle(color: kFadedBlack),
                  ),
                  Text(
                    'Modern Contrper Home ...',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: kGreyColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 10), //TextStyle(color: kFadedBlack),
                    overflow: TextOverflow.ellipsis,
                  ),
                  DashedLineGenerator(
                    width: constraints.maxWidth - 200,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  RichText(
                    text: const TextSpan(
                        text: '₹',
                        style: TextStyle(fontSize: 18, color: kFadedBlack),
                        children: <TextSpan>[
                          TextSpan(
                              text: '9800/-',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: kFadedBlack))
                        ]),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 100),
                child: Icon(
                  Icons.circle,
                  color: Colors.green,
                  size: 18,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (BuildContext context, int index) {
              bool isMe = index % 2 == 0;
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Container(
                        width: 260,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMe ? kPrimaryColor : const Color(0XFFeaeaea),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          messages[index],
                          style: TextStyle(
                            color:
                                isMe ? Colors.white : const Color(0xff797272),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Type your Message here",
                contentPadding: const EdgeInsets.all(10),
                border: InputBorder.none,
                prefixIcon: IconButton(
                  icon: const Icon(
                    Icons.add_chart,
                    color: Color(0XFF7B7B7B),
                  ),
                  onPressed: () {},
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.rocket_launch_outlined,
                        color: kWhiteColor,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              onSubmitted: (value) {},
            ),
          ),
        ),
      ])));
    });
  }
}
