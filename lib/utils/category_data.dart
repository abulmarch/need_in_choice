import '../config/routes/route_names.dart';
import 'main_cat_enum.dart';

// enum MainCategory {realestate,vehicle,electronics,jobs,professional,services,business,skilledPerson,antique,socialWorker}

//  ----------------------------------------------------------------------------------------------------------
//  ----------------------------------------- LEVEL 1 ---------------------------------------------------------
const List<Map<String, dynamic>> mainCategories = [
  {
    'cat_name': 'REAL ESTATE',
    'cat_img': 'assets/images/category/level1-main-category/realestate.png',
    'end_of_cat': false,
    'next_cat_list' : realEstateSubCategory,
    'MainCategory': MainCategory.realestate
  },
  {
    'cat_name': 'VEHICLE', 
    'cat_img': 'assets/images/category/level1-main-category/vehicle.png',
    'end_of_cat': false,
    // 'next_cat_list' : vehicleSubCategory,
    'next_cat_list' : commingSoon,
    'MainCategory': MainCategory.vehicle,
    'is_comming_soon': true,
  },
  {
    'cat_name': 'ELECTRONICS & FURNITURE',
    'cat_img': 'assets/images/category/level1-main-category/electronics.png',
    'end_of_cat': true,
    // 'root_name': collectAdDetails,
    'next_cat_list' : commingSoon,
    'MainCategory': MainCategory.electronics,
    'is_comming_soon': true,
  },
  {
    'cat_name': 'JOBS', 
    'cat_img': 'assets/images/category/level1-main-category/jobs.png',
    'end_of_cat': false,
    // 'next_cat_list' : <Map<String, dynamic>>[],
    'next_cat_list' : commingSoon,
    'MainCategory': MainCategory.jobs,
    'is_comming_soon': true,
  },
];

//  ----------------------------------------------------------------------------------------------------------
//  ----------------------------------------- LEVEL 2 ---------------------------------------------------------
const List<Map<String, dynamic>> commingSoon= [
  {
    'cat_name': 'COMMING SOON',
  }
];
      //  REAL ESTATE
const List<Map<String, dynamic>> realEstateSubCategory = [
  {
    'cat_name': 'BUILDING FOR SALE',
    'end_of_cat': false,
    'next_cat_list' : buildingForSale,
  },
  {
    'cat_name': 'BUILDING FOR RENT',
    'end_of_cat': false,
    'next_cat_list' : buildingForRent,
  },
  {
    'cat_name': 'LAND FOR SALE',
    'end_of_cat': false,
    'next_cat_list' : landForSale,
  },
  {
    'cat_name': 'LAND FOR RENT',
    'end_of_cat': true,
    'root_name': landForRentRoot,
  },
  {
    'cat_name': 'REAL-ESTATE AGENCY',
    'end_of_cat': true,
    'root_name': realestateAgencyRoot,
  },
  {
    'cat_name': 'REAL-ESTATE AGENT',
    'end_of_cat': true,
    'root_name': realestateAgentRoot,
  },
];
      //  VEHICLE
const List<Map<String, dynamic>> vehicleSubCategory = [
  {
    'cat_name': 'SALES',
    'end_of_cat': false,
    'next_cat_list' : vehicleSales,
  },
  {
    'cat_name': 'RENT',
    'end_of_cat': false,
    'next_cat_list' : vehicleRent,
  },
  {
    'cat_name': 'SERVICES',
    'end_of_cat': true,
    'root_name': collectAdDetails,
  },
  {
    'cat_name': 'SPARE-PARTS & ACCESORIES',
    'end_of_cat': true,
    'root_name': collectAdDetails,
  },
];

//  ----------------------------------------------------------------------------------------------------------
//  ----------------------------------------- LEVEL 3 ---------------------------------------------------------
      //  REAL ESTATE
const List<Map<String, String>> buildingForSale = [
  {
    'cat_name': 'COMMERCIAL BUILDING',
    'cat_img': 'assets/images/category/level3-sub-cat/building-commercial_building.png',
    // 'root_name': collectAdDetails,
    'root_name': commercialBuildingForSaleRoot,
  },
  {
    'cat_name': 'HOUSE VILLA',
    'cat_img': 'assets/images/category/level3-sub-cat/building-house_villa.png',
    'root_name': houseAndVillaForSaleRoot,
  },
  {
    'cat_name': 'APARTMENT & FLAT',
    'cat_img': 'assets/images/category/level3-sub-cat/building-appartment_and_flat.png',
    'root_name': appartmentAndFlatForSaleRoot,
  },
  {
    'cat_name': 'PENDING PROJECTS',
    'cat_img': 'assets/images/category/level3-sub-cat/building-pending_project.png',
    'root_name': pendingProjectForSaleRoot,
  },
  {
    'cat_name': 'E- AUCTION PROJECTS',
    'cat_img': 'assets/images/category/level3-sub-cat/building-e_auction_project.png',
    'root_name': eAuctionProjectForSaleRoot,
  },
];
const List<Map<String, String>> buildingForRent = [
  {
    'cat_name': 'COMMERCIAL BUILDING',
    'cat_img': 'assets/images/category/level3-sub-cat/building-commercial_building.png',
    'root_name': commercialBuildingForRentRoot,
  },
  {
    'cat_name': 'HOUSE VILLA',
    'cat_img': 'assets/images/category/level3-sub-cat/building-house_villa.png',
    'root_name': houseAndVillaForRentRoot,
  },
  {
    'cat_name': 'APARTMENT & FLAT',
    'cat_img': 'assets/images/category/level3-sub-cat/building-appartment_and_flat.png',
    'root_name': appartmentAndFlatForRentRoot,
  },
];
const List<Map<String, String>> landForSale = [
  {
    'cat_name': 'LAND',
    'cat_img': 'assets/images/category/level3-sub-cat/building-commercial_building.png',
    'root_name': landForSaleRoot,
  },
  {
    'cat_name': 'E- AUCTION LAND',
    'cat_img': 'assets/images/category/level3-sub-cat/building-appartment_and_flat.png',
    'root_name': eAuctionLandForSaleRoot,
  },
];

      //  VEHICLE
const List<Map<String, String>> vehicleRent = [
  {
    'cat_name': 'DRIVERS FOR HIRE',
    'cat_img': 'assets/images/category/realestate-buildingForSale/commercial_building.png',
    'root_name': collectAdDetails,
  },
  {
    'cat_name': 'HEAVY EEQUIPMENTS FOR RENT',
    'cat_img': 'assets/images/category/realestate-buildingForSale/house_villa.png',
    'root_name': collectAdDetails,
  },
  {
    'cat_name': 'LONG VEHICLE FOR RENT',
    'cat_img': 'assets/images/category/realestate-buildingForSale/house_villa.png',
    'root_name': collectAdDetails,
  },
  {
    'cat_name': 'VEHICLE FOR HIRE',
    'cat_img': 'assets/images/category/realestate-buildingForSale/commercial_building.png',
    'root_name': collectAdDetails,
  },
  {
    'cat_name': 'TAXI AGENCIES',
    'cat_img': 'assets/images/category/realestate-buildingForSale/house_villa.png',
    'root_name': collectAdDetails,
  },
  {
    'cat_name': 'WEDDING CARS FOR RENT',
    'cat_img': 'assets/images/category/realestate-buildingForSale/commercial_building.png',
    'root_name': collectAdDetails,
  },
  {
    'cat_name': 'TAXI FOR HIRE',
    'cat_img': 'assets/images/category/realestate-buildingForSale/commercial_building.png',
    'root_name': collectAdDetails,
  },
];
const List<Map<String, String>> vehicleSales = [
  {
    'cat_name': 'CARS',
    'cat_img': 'assets/images/category/realestate-buildingForSale/commercial_building.png',
    'root_name': collectAdDetails,
  },
  {
    'cat_name': 'BIKES',
    'cat_img': 'assets/images/category/realestate-buildingForSale/house_villa.png',
    'root_name': collectAdDetails,
  },
  {
    'cat_name': 'SCOOTER',
    'cat_img': 'assets/images/category/realestate-buildingForSale/house_villa.png',
    'root_name': collectAdDetails,
  },
  {
    'cat_name': 'AUTO',
    'cat_img': 'assets/images/category/realestate-buildingForSale/commercial_building.png',
    'root_name': collectAdDetails,
  },
  {
    'cat_name': 'AMBULANCE',
    'cat_img': 'assets/images/category/realestate-buildingForSale/house_villa.png',
    'root_name': collectAdDetails,
  },
  {
    'cat_name': 'BUS',
    'cat_img': 'assets/images/category/realestate-buildingForSale/commercial_building.png',
    'root_name': collectAdDetails,
  },
  {
    'cat_name': 'TRUCKS',
    'cat_img': 'assets/images/category/realestate-buildingForSale/commercial_building.png',
    'root_name': collectAdDetails,
  },
  {
    'cat_name': 'HEAVY EQUIPMENTS',
    'cat_img': 'assets/images/category/realestate-buildingForSale/house_villa.png',
    'root_name': collectAdDetails,
  },
  {
    'cat_name': 'WATER-CRAFTS AND BOATS',
    'cat_img': 'assets/images/category/realestate-buildingForSale/commercial_building.png',
    'root_name': collectAdDetails,
  },
  {
    'cat_name': 'TRACTORS',
    'cat_img': 'assets/images/category/realestate-buildingForSale/commercial_building.png',
    'root_name': collectAdDetails,
  },
  {
    'cat_name': 'CYCLE',
    'cat_img': 'assets/images/category/realestate-buildingForSale/commercial_building.png',
    'root_name': collectAdDetails,
  },
];