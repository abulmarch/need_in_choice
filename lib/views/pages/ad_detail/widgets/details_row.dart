import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import 'land_widget.dart';

class DetailsRow extends StatefulWidget {
  const DetailsRow({
    Key? key,
    required this.details,
  }) : super(key: key);

  final Map<String, dynamic> details;

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
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                var key = widget.details.keys.toList()[index];
                var value = widget.details.values.toList()[index];

                return LandWidget(
                  value: value is String ? value : value['value'],
                  name: key,
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
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    _scrollEnd.dispose();
    super.dispose();
  }
}
