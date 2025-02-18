class WishlistModel {
  final int id;
  final String name;
  final String productId;
  final String image;
  int quantity;
  final double price;
  final double discount;
  final double subTotal;
  final int wishlistId;
  final String createdAt;
  final String updatedAt;

  WishlistModel({
    required this.id,
    required this.name,
    required this.productId,
    required this.image,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.subTotal,
    required this.wishlistId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      id: json['id'],
      name: json['name'],
      productId: json['product_id'],
      image: json['image'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      discount: json['discount'].toDouble(),
      subTotal: json['sub_total'].toDouble(),
      wishlistId: json['wishlist_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class WishlistResponse {
  final bool success;
  final String message;
  final WishlistData product;

  WishlistResponse({
    required this.success,
    required this.message,
    required this.product,
  });

  factory WishlistResponse.fromJson(Map<String, dynamic> json) {
    return WishlistResponse(
      success: json['success'],
      message: json['message'],
      product: WishlistData.fromJson(json['product']),
    );
  }
}

class WishlistData {
  final int id;
  final String discount;
  final String subTotal;
  final String grandTotal;
  final int count;
  final int userId;
  final String createdAt;
  final String updatedAt;
  final List<WishlistModel> items;

  WishlistData({
    required this.id,
    required this.discount,
    required this.subTotal,
    required this.grandTotal,
    required this.count,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory WishlistData.fromJson(Map<String, dynamic> json) {
    return WishlistData(
      id: json['id'],
      discount: json['discount'],
      subTotal: json['sub_total'],
      grandTotal: json['grand_total'],
      count: json['count'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      items: (json['items'] as List)
          .map((item) => WishlistModel.fromJson(item))
          .toList(),
    );
  }
}
