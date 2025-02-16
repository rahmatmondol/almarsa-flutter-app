class MyAccountModel {
  MyAccountModel({
    num? id,
    String? name,
    String? email,
    String? firstName,
    String? lastName,
    String? address,
    String? address2,
    String? city,
    String? country,
    String? postalCode,
    String? image,
    String? phone,
    dynamic emailVerifiedAt,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _address = address;
    _address2 = address2;
    _city = city;
    _country = country;
    _postalCode = postalCode;
    _image = image;
    _phone = phone;
    _emailVerifiedAt = emailVerifiedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
  }

  MyAccountModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _address = json['address'];
    _address2 = json['address2'];
    _city = json['city'];
    _country = json['country'];
    _postalCode = json['postal_code'];
    _image = json['image'];
    _phone = json['phone'];
    _emailVerifiedAt = json['email_verified_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }

  num? _id;
  String? _name;
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _address;
  String? _address2;
  String? _city;
  String? _country;
  String? _postalCode;
  String? _image;
  String? _phone;
  dynamic _emailVerifiedAt;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;

  MyAccountModel copyWith({
    num? id,
    String? name,
    String? email,
    String? firstName,
    String? lastName,
    String? address,
    String? address2,
    String? city,
    String? country,
    String? postalCode,
    String? image,
    String? phone,
    dynamic emailVerifiedAt,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) =>
      MyAccountModel(
        id: id ?? _id,
        name: name ?? _name,
        email: email ?? _email,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        address: address ?? _address,
        address2: address2 ?? _address2,
        city: city ?? _city,
        country: country ?? _country,
        postalCode: postalCode ?? _postalCode,
        image: image ?? _image,
        phone: phone ?? _phone,
        emailVerifiedAt: emailVerifiedAt ?? _emailVerifiedAt,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        deletedAt: deletedAt ?? _deletedAt,
      );

  num? get id => _id;

  String? get name => _name;

  String? get email => _email;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get address => _address;

  String? get address2 => _address2;

  String? get city => _city;

  String? get country => _country;

  String? get postalCode => _postalCode;

  String? get image => _image;

  String? get phone => _phone;

  dynamic get emailVerifiedAt => _emailVerifiedAt;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  dynamic get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['address'] = _address;
    map['address2'] = _address2;
    map['city'] = _city;
    map['country'] = _country;
    map['postal_code'] = _postalCode;
    map['image'] = _image;
    map['phone'] = _phone;
    map['email_verified_at'] = _emailVerifiedAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    return map;
  }
}
