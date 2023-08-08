
extension RemoveEmptyDataFromMap on Map<String, dynamic>{
  Map<String, dynamic> removeEmptyValue() {
    Map<String, dynamic> newMapData = {};
    forEach((key, value) {
      if(value != null){
        if(value is String && value.isNotEmpty){
          newMapData[key] = value;
        }else if(value is List && value.isNotEmpty){
          newMapData[key] = value;
        }else if(value is Map && value['value'] != ''){
          newMapData[key] = value;
        }
      }
    });
    return newMapData;
  }
}