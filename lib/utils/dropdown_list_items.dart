class RealEstateDropdownList {
  static List<String> propertyArea = [
    'cents',
    'sq.feet',
    'sq.yards',
    'sq.meter',
    'grounds',
    'aankadam',
    'rood',
    'chataks',
    'perch',
    'guntha',
    'ares',
    'biswa',
    'acres',
    'bigha',
    'kottah',
    'hectares',
    'maria',
    'kanal',
  ];
  static List<String> buildupArea = ['sq.feet', 'sq.meter'];
  static List<String> saleType = ['new', 'resale'];
  static List<String> listedBy = [
    'broker',
    'owner',
    'relative',
    'friend',
    'real estate agency'
  ];
  static List<String> facing = [
    'east',
    'north',
    'north-east',
    'north-west',
    'south',
    'west',
    'south-west',
    'south-east'
  ];
  static List<String> carpetArea = ['sq.feet', 'sq.meter'];
  static List<String> constructionStatus = [
    'ready to move',
    'under construction'
  ];
  static List<String> furnishing = [
    'fully furnished',
    'semi furnished',
    'unfurnished'
  ];
}

class VehicleDropDownList {
  static List<String> rentTypeDriver = ['hours', 'day', 'km'];
  static List<String> rentTypeLoading = [
    'hours',
    'day',
    'km',
    'minimum charge',
    'monthly',
    'weekly'
  ];
  static List<String> salaryPeriod = ['monthly', 'hourly', 'daily'];
  static List<String> listedBy = ['owner', 'dealer', 'driver'];
  static List<String> hiringType = ['hours', 'day', 'km', 'weekly', 'monthly'];
  static List<String> drivingType = [
    'with driver',
    'without driver',
  ];
  static List<String> loadingCapacity = ['ton', 'kg'];
  static List<String> rentTypeWedding = ['km', 'days'];
  static List<String> additionalChargeWed = ['km', 'day'];
  static List<String> listedByWed = ['owner', 'driver', 'agency'];
  static List<String> fuel = [
    'petrol',
    'diesel',
    'electric',
    'hybrid',
    'CNG',
    'LPG'
  ];
  static List<String> finance = [
    'Yes',
    'No',
  ];
  static List<String> owner = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '10+'
  ];
  static List<String> listedBySale = ['owner', 'dealer', 'friend', 'relative'];
  static List<String> transmission = [
    'automatic',
    'manual',
  ];
  static List<String> driven = [
    'km',
    'hrs',
  ];
}

class JobsDropDownList {
  static List<String> gender = ['male', 'female', 'others'];

  static List<String> employmentType = [
    'Full Time',
    'Part Time',
    'Daily',
    'Hourly'
  ];
  static List<String> workExperience = [
    '0-2',
    '2-4',
    '4-6',
    '6-8',
    '8-10',
    '10+'
  ];

  static List<String> ageCategory = [
    'below 20',
    '20-25',
    '25-30',
    '30-35',
    'above 35',
  ];
}
