class CouponModel {
  final String code;
  final double discountPercentage;
  final double maxDiscountAmount;
  final bool isValid;

  const CouponModel({
    required this.code,
    required this.discountPercentage,
    required this.maxDiscountAmount,
    this.isValid = true,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      code: json['code'] as String,
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      maxDiscountAmount: (json['maxDiscountAmount'] as num).toDouble(),
      isValid: json['isValid'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'discountPercentage': discountPercentage,
      'maxDiscountAmount': maxDiscountAmount,
      'isValid': isValid,
    };
  }

  CouponModel copyWith({
    String? code,
    double? discountPercentage,
    double? maxDiscountAmount,
    bool? isValid,
  }) {
    return CouponModel(
      code: code ?? this.code,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      maxDiscountAmount: maxDiscountAmount ?? this.maxDiscountAmount,
      isValid: isValid ?? this.isValid,
    );
  }
}
