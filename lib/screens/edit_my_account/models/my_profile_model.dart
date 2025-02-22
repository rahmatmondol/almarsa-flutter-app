class MyProfileModel {
  int? id;
  String? name;
  String? email;
  String? firstName;
  String? lastName;
  String? address;
  String? address2;
  String? city;
  String? country;
  String? state;
  String? postalCode;
  String? image;
  String? phone;
  String? shippingFirstName;
  String? shippingLastName;
  String? shippingAddress;
  String? shippingAddress2;
  String? shippingCity;
  String? shippingCountry;
  String? shippingState;
  String? shippingPostalCode;
  String? shippingPhone;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  MyProfileModel(
      {this.id,
      this.name,
      this.email,
      this.firstName,
      this.lastName,
      this.address,
      this.address2,
      this.city,
      this.country,
      this.state,
      this.postalCode,
      this.image,
      this.phone,
      this.shippingFirstName,
      this.shippingLastName,
      this.shippingAddress,
      this.shippingAddress2,
      this.shippingCity,
      this.shippingCountry,
      this.shippingState,
      this.shippingPostalCode,
      this.shippingPhone,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  MyProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address = json['address'];
    address2 = json['address2'];
    city = json['city'];
    country = json['country'];
    state = json['state'];
    postalCode = json['postal_code'];
    image = json['image'];
    phone = json['phone'];
    shippingFirstName = json['shipping_first_name'];
    shippingLastName = json['shipping_last_name'];
    shippingAddress = json['shipping_address'];
    shippingAddress2 = json['shipping_address2'];
    shippingCity = json['shipping_city'];
    shippingCountry = json['shipping_country'];
    shippingState = json['shipping_state'];
    shippingPostalCode = json['shipping_postal_code'];
    shippingPhone = json['shipping_phone'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['address'] = address;
    data['address2'] = address2;
    data['city'] = city;
    data['country'] = country;
    data['state'] = state;
    data['postal_code'] = postalCode;
    data['image'] = image;
    data['phone'] = phone;
    data['shipping_first_name'] = shippingFirstName;
    data['shipping_last_name'] = shippingLastName;
    data['shipping_address'] = shippingAddress;
    data['shipping_address2'] = shippingAddress2;
    data['shipping_city'] = shippingCity;
    data['shipping_country'] = shippingCountry;
    data['shipping_state'] = shippingState;
    data['shipping_postal_code'] = shippingPostalCode;
    data['shipping_phone'] = shippingPhone;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
