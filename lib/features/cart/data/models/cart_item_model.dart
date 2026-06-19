class CartItemModel {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;
  final String restaurantName;

  const CartItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.restaurantName,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      imageUrl: json['imageUrl'] as String,
      restaurantName: json['restaurantName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'restaurantName': restaurantName,
    };
  }

  CartItemModel copyWith({
    String? id,
    String? name,
    double? price,
    int? quantity,
    String? imageUrl,
    String? restaurantName,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      restaurantName: restaurantName ?? this.restaurantName,
    );
  }

  // To simulate fake data in Skeletonizer
  factory CartItemModel.fake() {
    return const CartItemModel(
      id: 'fake_id',
      name: 'Loading Item Name...',
      price: 15.00,
      quantity: 1,
      imageUrl: '',
      restaurantName: 'Loading Restaurant...',
    );
  }
}
