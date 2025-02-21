class GetAllOrderModel {
  String? status;
  String? message;
  List<Data>? data;

  GetAllOrderModel({this.status, this.message, this.data});

  GetAllOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? status;
  String? subTotal;
  String? discount;
  String? grandTotal;
  int? count;
  dynamic shippingMethod;
  String? shippingCost;
  dynamic paymentMethod;
  dynamic paymentReference;
  String? shippingFirstName;
  String? shippingLastName;
  String? shippingAddress;
  String? shippingAddress2;
  String? shippingCity;
  String? shippingCountry;
  String? shippingState;
  String? shippingPostalCode;
  String? shippingPhone;
  int? userId;
  String? createdAt;
  String? updatedAt;
  List<Items>? items;

  Data({
    this.id,
    this.status,
    this.subTotal,
    this.discount,
    this.grandTotal,
    this.count,
    this.shippingMethod,
    this.shippingCost,
    this.paymentMethod,
    this.paymentReference,
    this.shippingFirstName,
    this.shippingLastName,
    this.shippingAddress,
    this.shippingAddress2,
    this.shippingCity,
    this.shippingCountry,
    this.shippingState,
    this.shippingPostalCode,
    this.shippingPhone,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.items,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] is String ? int.tryParse(json['id']) : json['id'];
    status = json['status'];
    subTotal = json['sub_total']?.toString();
    discount = json['discount']?.toString();
    grandTotal = json['grand_total']?.toString();
    count =
        json['count'] is String ? int.tryParse(json['count']) : json['count'];
    shippingMethod = json['shipping_method'];
    shippingCost = json['shipping_cost']?.toString();
    paymentMethod = json['payment_method'];
    paymentReference = json['payment_reference'];
    shippingFirstName = json['shipping_first_name'];
    shippingLastName = json['shipping_last_name'];
    shippingAddress = json['shipping_address'];
    shippingAddress2 = json['shipping_address2'];
    shippingCity = json['shipping_city'];
    shippingCountry = json['shipping_country'];
    shippingState = json['shipping_state'];
    shippingPostalCode = json['shipping_postal_code'];
    shippingPhone = json['shipping_phone'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['sub_total'] = subTotal;
    data['discount'] = discount;
    data['grand_total'] = grandTotal;
    data['count'] = count;
    data['shipping_method'] = shippingMethod;
    data['shipping_cost'] = shippingCost;
    data['payment_method'] = paymentMethod;
    data['payment_reference'] = paymentReference;
    data['shipping_first_name'] = shippingFirstName;
    data['shipping_last_name'] = shippingLastName;
    data['shipping_address'] = shippingAddress;
    data['shipping_address2'] = shippingAddress2;
    data['shipping_city'] = shippingCity;
    data['shipping_country'] = shippingCountry;
    data['shipping_state'] = shippingState;
    data['shipping_postal_code'] = shippingPostalCode;
    data['shipping_phone'] = shippingPhone;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  String? name;
  String? productId;
  String? image;
  int? quantity;
  double? price;
  int? discount;
  double? subTotal;
  int? orderId;
  String? createdAt;
  String? updatedAt;

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'] is String ? int.tryParse(json['id']) : json['id'];
    name = json['name'];
    productId = json['product_id']?.toString();
    image = json['image'];
    quantity = json['quantity'] is String
        ? int.tryParse(json['quantity'])
        : json['quantity'];
    price = _parseDouble(json['price']);
    discount = json['discount'] is String
        ? int.tryParse(json['discount'])
        : json['discount'];
    subTotal = _parseDouble(json['sub_total']);
    orderId = json['order_id'] is String
        ? int.tryParse(json['order_id'])
        : json['order_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['product_id'] = productId;
    data['image'] = image;
    data['quantity'] = quantity;
    data['price'] = price;
    data['discount'] = discount;
    data['sub_total'] = subTotal;
    data['order_id'] = orderId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  // Helper method to parse double values
  double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
