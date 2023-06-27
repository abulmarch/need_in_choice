class AccountModels {
  final int id;
  final String userId;
  final String name;
  final String address;
  final String whatsapp;
  final String phone;
  final String email;
  final String createDate;

  AccountModels(
      {required this.id,
      required this.userId,
      required this.name,
      required this.address,
      required this.whatsapp,
      required this.phone,
      required this.email,
      required this.createDate});

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
}
