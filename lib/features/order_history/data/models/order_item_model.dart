class OrderItemModel {
  final String name;
  final int quantity;
  final double price;

  OrderItemModel({
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }

  OrderItemModel copyWith({
    String? name,
    int? quantity,
    double? price,
  }) {
    return OrderItemModel(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  factory OrderItemModel.fake() {
    return OrderItemModel(
      name: 'Margherita Pizza',
      quantity: 1,
      price: 12.50,
    );
  }
}
