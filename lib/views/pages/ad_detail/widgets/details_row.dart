import 'package:flutter/material.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../widgets_refactored/dashed_line_generator.dart';
import 'land_widget.dart';

class DetailsRow extends StatefulWidget {
  const DetailsRow({
    Key? key,
    required this.details,
    required this.dotColor,
  }) : super(key: key);

  final Map<String, dynamic> details;
  final Color dotColor;

  @override
  State<DetailsRow> createState() => _DetailsRowState();
}

class _DetailsRowState extends State<DetailsRow> {
  late ScrollController _scrollController;
  late ValueNotifier<bool> _scrollEnd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollEnd = ValueNotifier(false);
    activateListner();
  }

  void activateListner() {
    if(_scrollController.hasClients){
      _scrollController.addListener(() {
        if (_scrollController.position.maxScrollExtent -
                    _scrollController.position.pixels <
                40 &&
            _scrollEnd.value == false) {
          _scrollEnd.value = true;
        } else if (_scrollController.position.maxScrollExtent -
                    _scrollController.position.pixels >
                40 &&
            _scrollEnd.value == true) {
          _scrollEnd.value = false;
        }
      });
      Future.delayed(const Duration(milliseconds: 250)).then((value) {
        if (_scrollController.position.maxScrollExtent == 0) {
          _scrollEnd.value = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final keyList = widget.details.keys.toList();
    final valueList = widget.details.values.toList();
    return (widget.details.isNotEmpty)
        ? Column(
            children: [
              kHeight5,
              SizedBox(
                width: screenWidth * .9,
                child: MySeparator(color: widget.dotColor),
              ),
              kHeight5,
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Container(
                      height: 45,
                      width: 40,
                      decoration: BoxDecoration(
                        color: kWhiteColor.withOpacity(.4),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.bolt,
                        color: kWhiteColor,
                      ),
                    ),
                    kWidth10,
                    Expanded(
                      child: ListView.separated(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.details.length,
                        itemBuilder: (BuildContext context, int index) {
                          return LandWidget(
                            value: valueList[index] is String
                                ? valueList[index]
                                : valueList[index]['value'],
                            name: keyList[index],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return vericalDivider;
                        },
                      ),
                    ),
                    kWidth15,
                    SizedBox(
                      height: 45,
                      width: 30,
                      child: ValueListenableBuilder(
                          valueListenable: _scrollEnd,
                          builder: (context, isEndOfScroll, _) {
                            return !isEndOfScroll
                                ? const Icon(
                                    Icons.arrow_forward_ios,
                                    color: kDottedBorder,
                                    size: 20,
                                  )
                                : const SizedBox();
                          }),
                    ),
                  ],
                ),
              ),
            ],
          )
        : const SizedBox();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    _scrollEnd.dispose();
    super.dispose();
  }
}
