
class AccountModels {
  final int? id;
  final String? userId;
  final String? name;
  final String? address;
  final String? whatsapp;
  final String? phone;
  final String? email;
  final String? createDate;
  final String? profileImage;
  final String? selectedPlace;
  final String? placePincode;

  AccountModels({
    this.id,
      this.userId,
      this.name,
      this.address,
      this.whatsapp,
      this.phone,
      this.email,
      this.createDate,
      this.profileImage,
      this.selectedPlace,
      this.placePincode,
    });

  factory AccountModels.fromJson(Map map) {
    return AccountModels(
      id: map['id'],
      userId: map['user_id'],
      name: map['name'],
      address: map['address'],
      whatsapp: map['whatsapp'],
      phone: map['phone'],
      createDate: map['created_at'],
      email: map['email'],
      profileImage: map['profile_image'],
      selectedPlace: map['selected_place'],
      placePincode: map['place_pincode'],
    );
  }

  

  Map<String, dynamic> toJson(AccountModels accountModels) {
    return {
      'id': accountModels.id,
      'user_id':accountModels.userId ,
      'name': accountModels.name ,
      'address': accountModels.address ,
      'whatsapp': accountModels.whatsapp ,
      'phone': accountModels.phone ,
      'email': accountModels.email ,
      'profile_image': profileImage,
      'selected_place': selectedPlace,
      'place_pincode': placePincode,
    };
  }
  
  AccountModels copyWith({
    String? address,
    String? whatsapp,
    String? name,
    String? selectedPlace,
    String? placePincode,
  }){
    return AccountModels(
      id: id,
      userId: userId,
      name: name ?? this.name,
      address: address ?? this.address,
      whatsapp: whatsapp ?? this.whatsapp,
      phone: phone,
      createDate: createDate,
      email: email,
      profileImage: profileImage,
      selectedPlace: selectedPlace ?? this.selectedPlace,
      placePincode: placePincode ?? this.placePincode,
    );
  }
  @override
  String toString() {
    return "Account: {user_id : $userId, name: $name, address: $address, phone: $phone , whatsapp : $whatsapp, profileImage: $profileImage, selectedPlace: $selectedPlace, placePincode: $placePincode}";
  }
}

class AccountSingleton{
  factory AccountSingleton() => instance;
  static final AccountSingleton instance = AccountSingleton._();

  AccountSingleton._();


  AccountModels? _accountModels;
  set setAccountModels(AccountModels account) {
     _accountModels = account;
  }
  void resetAccountModel(){
    _accountModels = null;
  }
  AccountModels get getAccountModels => _accountModels!;

}