class AccountModels {
  final int? id;
  final String? userId;
  final String? name;
  final String? address;
  final String? whatsapp;
  final String? phone;
  final String? email;
  final String? createDate;

  AccountModels(
      {this.id,
      this.userId,
      this.name,
      this.address,
      this.whatsapp,
      this.phone,
      this.email,
      this.createDate});

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
      // 'created_at': accountModels.createDate,
      'email': accountModels.email ,
    };
  }

  @override
  String toString() {
    return "Account: {user_id : $userId, name: $name, address: $address, phone: $phone , whatsapp : $whatsapp}";
  }
}
