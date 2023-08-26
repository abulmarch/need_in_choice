import 'dart:convert';

import 'package:need_in_choice/services/model/autocomplete_prediction.dart';


class PlaceAutocompletResponse{
  final String? status;
  final List<AutocompletePrediction>? predictions;
  const PlaceAutocompletResponse({
    this.status,
    this.predictions,
  });

  factory PlaceAutocompletResponse.fromJson(Map<String, dynamic> json){
    return PlaceAutocompletResponse(
      status: json['status'] as String?,
      predictions: json['predictions'] != null ? json['predictions'].map<AutocompletePrediction>((json)=> AutocompletePrediction.fromJson(json)).toList() : null,
    );
  }
  static PlaceAutocompletResponse parseAutocompleteResult(String responseBody){
    final parsed = jsonDecode(responseBody).cast<String, dynamic>();//, .cast<String, dynamic>()
    return PlaceAutocompletResponse.fromJson(parsed);
  }


  @override
  String toString() {
    return '''
      status : $status 
      predictions : $predictions
    ''';
  }
}