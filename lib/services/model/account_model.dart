import 'dart:async';

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
      profileImage: map['profile_image']
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
    };
  }
  
  AccountModels copyWith({
    String? address,
    String? whatsapp,
    String? name,
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
      profileImage: profileImage
    );
  }
  @override
  String toString() {
    return "Account: {user_id : $userId, name: $name, address: $address, phone: $phone , whatsapp : $whatsapp, profileImage: $profileImage}";
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
  AccountModels get getAccountModels => _accountModels!;

}
