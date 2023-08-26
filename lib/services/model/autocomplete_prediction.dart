class AutocompletePrediction{
  final String? description;
  final String? placeId;
  final String? reference;
  final StructuredFormatting? structuredFormatting;

  const AutocompletePrediction({
    this.placeId,
    this.description,
    this.reference,
    this.structuredFormatting,
  });
   factory AutocompletePrediction.fromJson(Map<String, dynamic> json){
    return AutocompletePrediction(
      placeId: json['place_id'] as String?,
      description: json['description'],
      reference: json['reference'] as String?,
      structuredFormatting: json['structured_formatting'] != null ? StructuredFormatting.fromJson(json['structured_formatting']) : null,
    );
   }

   Map<String, dynamic> toJson(){
    return {
      'place_id': placeId,
      'description': description,
      'reference': reference,
      'structured_formatting': structuredFormatting?.toJson(),
    };
   }

   @override
  String toString() {
    return 'placeId: $placeId  description: $description  reference: $reference \n structuredFormatting: $structuredFormatting';
  }
}


class StructuredFormatting {
  final String? mainText;
  final String? secondaryText;
  const StructuredFormatting({
    this.mainText,
    this.secondaryText,
  });

  factory StructuredFormatting.fromJson(Map<String, dynamic> json){
    return StructuredFormatting(
      mainText: json['main_text'] as String?,
      secondaryText: json['secondary_text'] as String?,
    );
  }
  Map<String, dynamic> toJson(){
    return {
      'main_text': mainText,
      'secondary_text': secondaryText,
    };
  }
  @override
  String toString() {
    return 'mainText:  $mainText   secondaryText: $secondaryText';
  }
}