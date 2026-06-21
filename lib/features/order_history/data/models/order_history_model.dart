import 'order_item_model.dart';

class OrderHistoryModel {
  final String id;
  final String restaurantName;
  final String restaurantImage;
  final String status;
  final String date;
  final List<OrderItemModel> items;
  final double totalPrice;

  OrderHistoryModel({
    required this.id,
    required this.restaurantName,
    required this.restaurantImage,
    required this.status,
    required this.date,
    required this.items,
    required this.totalPrice,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      id: json['id'] ?? '',
      restaurantName: json['restaurantName'] ?? '',
      restaurantImage: json['restaurantImage'] ?? '',
      status: json['status'] ?? '',
      date: json['date'] ?? '',
      items: (json['items'] as List?)
              ?.map((item) => OrderItemModel.fromJson(item))
              .toList() ??
          [],
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantName': restaurantName,
      'restaurantImage': restaurantImage,
      'status': status,
      'date': date,
      'items': items.map((item) => item.toJson()).toList(),
      'totalPrice': totalPrice,
    };
  }

  OrderHistoryModel copyWith({
    String? id,
    String? restaurantName,
    String? restaurantImage,
    String? status,
    String? date,
    List<OrderItemModel>? items,
    double? totalPrice,
  }) {
    return OrderHistoryModel(
      id: id ?? this.id,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantImage: restaurantImage ?? this.restaurantImage,
      status: status ?? this.status,
      date: date ?? this.date,
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  factory OrderHistoryModel.fake() {
    return OrderHistoryModel(
      id: 'FG-48291',
      restaurantName: "L'Arte della Pasta",
      restaurantImage: '',
      status: 'Preparing',
      date: 'Oct 24, 2023',
      items: [OrderItemModel.fake()],
      totalPrice: 24.50,
    );
  }
}
