class OrderSuccessModel {
  final String orderNumber;
  final String restaurantName;
  final String restaurantImage;
  final int itemCount;
  final double totalPrice;
  final String paymentMethod;
  final String paymentDetails;
  final int etaMinutes;

  OrderSuccessModel({
    required this.orderNumber,
    required this.restaurantName,
    required this.restaurantImage,
    required this.itemCount,
    required this.totalPrice,
    required this.paymentMethod,
    required this.paymentDetails,
    required this.etaMinutes,
  });

  factory OrderSuccessModel.fromJson(Map<String, dynamic> json) {
    return OrderSuccessModel(
      orderNumber: json['orderNumber'] ?? '',
      restaurantName: json['restaurantName'] ?? '',
      restaurantImage: json['restaurantImage'] ?? '',
      itemCount: json['itemCount'] ?? 0,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: json['paymentMethod'] ?? '',
      paymentDetails: json['paymentDetails'] ?? '',
      etaMinutes: json['etaMinutes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderNumber': orderNumber,
      'restaurantName': restaurantName,
      'restaurantImage': restaurantImage,
      'itemCount': itemCount,
      'totalPrice': totalPrice,
      'paymentMethod': paymentMethod,
      'paymentDetails': paymentDetails,
      'etaMinutes': etaMinutes,
    };
  }

  OrderSuccessModel copyWith({
    String? orderNumber,
    String? restaurantName,
    String? restaurantImage,
    int? itemCount,
    double? totalPrice,
    String? paymentMethod,
    String? paymentDetails,
    int? etaMinutes,
  }) {
    return OrderSuccessModel(
      orderNumber: orderNumber ?? this.orderNumber,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantImage: restaurantImage ?? this.restaurantImage,
      itemCount: itemCount ?? this.itemCount,
      totalPrice: totalPrice ?? this.totalPrice,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentDetails: paymentDetails ?? this.paymentDetails,
      etaMinutes: etaMinutes ?? this.etaMinutes,
    );
  }

  factory OrderSuccessModel.fake() {
    return OrderSuccessModel(
      orderNumber: 'FG-2847',
      restaurantName: "L'Arte della Pasta",
      restaurantImage: '',
      itemCount: 3,
      totalPrice: 29.47,
      paymentMethod: 'Credit Card',
      paymentDetails: '•••• 8829',
      etaMinutes: 30,
    );
  }
}
