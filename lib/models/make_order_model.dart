// lib/models/order_request.dart
class MakeOrderModel {
  final String shippingFirstName;
  final String shippingLastName;
  final String shippingAddress;
  final String shippingAddress2;
  final String shippingCity;
  final String shippingCountry;
  final String? shippingState;
  final String shippingPostalCode;
  final String shippingPhone;
  final int userId;
  final List<OrderItem> items;

  MakeOrderModel({
    required this.shippingFirstName,
    required this.shippingLastName,
    required this.shippingAddress,
    required this.shippingAddress2,
    required this.shippingCity,
    required this.shippingCountry,
    this.shippingState,
    required this.shippingPostalCode,
    required this.shippingPhone,
    required this.userId,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
    'shipping_first_name': shippingFirstName,
    'shipping_last_name': shippingLastName,
    'shipping_address': shippingAddress,
    'shipping_address2': shippingAddress2,
    'shipping_city': shippingCity,
    'shipping_country': shippingCountry,
    'shipping_state': shippingState,
    'shipping_postal_code': shippingPostalCode,
    'shipping_phone': shippingPhone,
    'user_id': userId,
    'items': items.map((item) => item.toJson()).toList(),
  };
}

class OrderItem {
  final String productId;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'quantity': quantity,
    'price': price,
  };
}

// lib/models/order_response.dart
class OrderResponse {
  final bool success;
  final String message;
  final OrderData data;

  OrderResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
    success: json['success'],
    message: json['message'],
    data: OrderData.fromJson(json['data']),
  );
}

class OrderData {
  final int id;
  final String subTotal;
  final String discount;
  final String grandTotal;
  final int count;
  final List<OrderItemResponse> items;

  OrderData({
    required this.id,
    required this.subTotal,
    required this.discount,
    required this.grandTotal,
    required this.count,
    required this.items,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    id: json['id'],
    subTotal: json['sub_total'],
    discount: json['discount'],
    grandTotal: json['grand_total'],
    count: json['count'],
    items: (json['items'] as List)
        .map((item) => OrderItemResponse.fromJson(item))
        .toList(),
  );
}

class OrderItemResponse {
  final int id;
  final String name;
  final String productId;
  final String image;
  final int quantity;
  final double price;
  final double discount;
  final double subTotal;

  OrderItemResponse({
    required this.id,
    required this.name,
    required this.productId,
    required this.image,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.subTotal,
  });

  factory OrderItemResponse.fromJson(Map<String, dynamic> json) =>
      OrderItemResponse(
        id: json['id'],
        name: json['name'],
        productId: json['product_id'],
        image: json['image'],
        quantity: json['quantity'],
        price: json['price'].toDouble(),
        discount: json['discount'].toDouble(),
        subTotal: json['sub_total'].toDouble(),
      );
}



