import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/constants.dart';

import '../../../utils/city_names.dart';
import '../../../utils/colors.dart';
import '../../widgets_refactored/rich_text_builder.dart';
import '../../widgets_refactored/search_form_field.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({super.key});
  int selectedCategory = 0;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: double.infinity,
                    height: 140,
                    margin: const EdgeInsets.only(bottom: kpadding10*3,left: 5,right: 5),
                    padding: const EdgeInsets.all(kpadding15),
                    decoration: BoxDecoration(
                      color: kLightBlueWhite,
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(kpadding10),bottomRight: Radius.circular(kpadding10)),
                      border: Border.all(color: kLightBlueWhiteBorder,width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [                              
                              Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: kpadding10),
                                    child: DropdownButton<String>(
                                      menuMaxHeight: 250,
                                      value: 'Trivandrum',
                                      underline: const SizedBox(),
                                      icon: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(6))
                                        ),
                                        child: const Icon(Icons.keyboard_arrow_down,color: Color(0xFF736F6F),size: 17),
                                      ),
                                      elevation: 8,
                                      isDense: true,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold,color: const Color(0xFF736F6F)),
                                      
                                      onChanged: (String? value) {                                    
                                      },
                                      items: cityName.map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  const Text(
                                    '------------------',
                                    style: TextStyle(
                                      height: 0.7,
                                      color: kDottedBorder
                                    ),
                                  )
                                ],
                              ),
                              

                              RichText(
                                text: TextSpan(
                                  text: 'Buy &',
                                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: kFadedBlack),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Sell \nAnything Now', 
                                      // style: TextStyle(),
                                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(height: 0.9,)
                                    ),
                                    TextSpan(text: '...', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: const Color(0xFF898989),height: 0.9)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            const CircleAvatar(
                              maxRadius: 30,
                              backgroundImage: AssetImage('assets/images/profile/no_profile_img.png'),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Account ',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 9,color: const Color(0xFF6A6A6A)),
                                children: <TextSpan>[
                                  const TextSpan(text: 'Details',style: TextStyle(color: kPrimaryColor),),
                                  TextSpan(text: '\nView more info',style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 8,color: const Color(0xFFBABABA))),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kpadding20),
                    child: SearchFormField(
                      hintText: 'Find vehicle, furniture and more',
                    ),
                  ),
                ],
              ),
              
              Container(
                width: double.infinity,
                height: 150,
                padding: const EdgeInsets.all(kpadding15),
                // color: Colors.pink[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'What are you looking for?',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 17,fontWeight: FontWeight.bold,color: kFadedBlack),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
                            minimumSize: MaterialStateProperty.all<Size>(const Size(5, 5)),
                            alignment: Alignment.topCenter,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            
                          }, 
                          child: Row(
                            children: const [
                              Text('See all',style: TextStyle(fontSize: 14),),
                              RotatedBox(
                                quarterTurns: 3,
                                child: Icon(Icons.arrow_drop_down_circle_rounded,)
                              )
                            ],
                          )
                        ),
                      ],
                    ),
                    
                    Expanded(
                      child: LayoutBuilder(
                        builder: (BuildContext ctx, BoxConstraints bConst) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  foregroundDecoration: selectedCategory != index ? const BoxDecoration(
                                    color: Colors.grey,
                                    backgroundBlendMode: BlendMode.saturation,
                                  ) : null,
                                  width: bConst.maxHeight,
                                  height: bConst.maxHeight,
                                  // margin: EdgeInsets.symmetric(horizontal: 5),
                                  child: Column(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 30),
                                            child: Image.asset('assets/images/ellipse.png'),
                                          ),
                                          Image.asset('assets/images/category/realestate.png'),
                                        ],
                                      ),

                                      RichTextBuilder(
                                        text: 'REAL ESTATE'.toUpperCase(),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth-30,
                      height: 2,
                      child: Text(
                        dashedLineGenerator(constraints.maxWidth-30),//kPadding15*2   // '-------------------------------------------------',
                        style: const TextStyle(
                          height: 0.7,
                          color: kDottedBorder,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kpadding15),
                  child: LayoutBuilder(
                    builder: (ctx, bC) {
                      double imageSize = bC.maxWidth*0.5-15;  // subtract padding form half of width
                      return GridView.builder(                      
                        physics: const ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: bC.maxWidth / bC.maxHeight*0.75,
                        ), 
                        itemCount: 12,
                        itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9F9F9),
                            borderRadius: const BorderRadius.all(Radius.circular(kpadding10)),
                            border: Border.all(color: Colors.black)
                          ),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  SizedBox(
                                    width: imageSize,
                                    height: imageSize-15,
                                    child: PageView.builder(

                                      itemCount: houseFoRentr.length,
                                      itemBuilder: (context, index) => ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(kpadding10)),
                                        child: Image.asset(
                                          houseFoRentr[index],fit: BoxFit.cover,
                                          // width: imageSize,
                                          // height: imageSize-15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  Positioned(
                                    top: kpadding10,
                                    right: kpadding10,
                                    child: Container(
                                      width: 75,
                                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(kpadding20))
                                      ),
                                      child: Text(
                                        '10 days ago',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10,color: kPrimaryColor),
                                      ),
                                    ),
                                  ),
                                  
                                  Positioned(
                                    bottom: kpadding10,
                                    child: Container(
                                      width: 100,
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(Radius.circular(kpadding20))
                                      ),
                                      // child: ListView(
                                      //   shrinkWrap: true,
                                      //   scrollDirection: Axis.horizontal,
                                        
                                      //   children: List.generate(houseFoRentr.length, (index) => Container(width: 25,height: 25,child: Text('1'),color: Colors.white,padding: EdgeInsets.symmetric(horizontal: 10),)),
                                      // )
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Modern Contrper',
                                        style: TextStyle(color: kFadedBlack),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      RichTextBuilder.lastWord(text: '1 bhk m'.toUpperCase()),
                                      // Text('text2'),
                                      // Text('text3'),
                                      Text('text4'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  String dashedLineGenerator(double width){
    int noOfTimes = int.parse('${width~/6}');
    return '-'*noOfTimes;
  }
}