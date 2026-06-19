class CartSummaryModel {
  final double subtotal;
  final double deliveryFee;
  final double taxAmount;
  final double discountAmount;

  const CartSummaryModel({
    required this.subtotal,
    required this.deliveryFee,
    required this.taxAmount,
    required this.discountAmount,
  });

  double get total => (subtotal + deliveryFee + taxAmount) - discountAmount;

  factory CartSummaryModel.fromJson(Map<String, dynamic> json) {
    return CartSummaryModel(
      subtotal: (json['subtotal'] as num).toDouble(),
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      taxAmount: (json['taxAmount'] as num).toDouble(),
      discountAmount: (json['discountAmount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'taxAmount': taxAmount,
      'discountAmount': discountAmount,
      'total': total,
    };
  }

  CartSummaryModel copyWith({
    double? subtotal,
    double? deliveryFee,
    double? taxAmount,
    double? discountAmount,
  }) {
    return CartSummaryModel(
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      taxAmount: taxAmount ?? this.taxAmount,
      discountAmount: discountAmount ?? this.discountAmount,
    );
  }

  factory CartSummaryModel.empty() {
    return const CartSummaryModel(
      subtotal: 0.0,
      deliveryFee: 0.0,
      taxAmount: 0.0,
      discountAmount: 0.0,
    );
  }
}
