

import 'package:flutter/material.dart';

class SearchFormField extends StatelessWidget {
  const SearchFormField({super.key, this.controller, this.hintText});
  final TextEditingController? controller;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      shadowColor: Colors.grey,
      borderRadius: const BorderRadius.all(Radius.circular(13)),  
      child: TextFormField(
        
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,contentPadding: const EdgeInsets.all(18),
          hintStyle: const  TextStyle(
            color: Color(0xFFCBCBCB),
            fontFamily: 'Poppins'
          ),
          prefixIcon: const Icon(Icons.search),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.white),
          ),
          fillColor: Colors.white,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
