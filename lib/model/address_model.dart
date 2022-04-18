class AddressModel {
  String? id;
  String name;
  String mobNumber;
  String alterNumber;
  String pincode;
  String state;
  String city;
  String address;
  AddressModel(
      {required this.name,
      required this.mobNumber,
      required this.alterNumber,
      required this.pincode,
      required this.state,
      required this.city,
      required this.address,
      this.id});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mobNumber': mobNumber,
      'alterNumber': alterNumber,
      'pincode': pincode,
      'state': state,
      'city': city,
      'address': address,
      'id': id
    };
  }

  static AddressModel fromJson(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'],
        name: map['name'] ?? '',
        mobNumber: map['mobNumber'] ?? '',
        alterNumber: map['alterNumber'] ?? '',
        pincode: map['pincode'] ?? '',
        state: map['state'] ?? '',
        city: map['city'] ?? '',
        address: map['address']);
  }
}
