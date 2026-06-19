class OfferModel {
  final String id;
  final String title;
  final String description;
  final String image;
  final String code;

  OfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.code,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      code: json['code'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'code': code,
    };
  }

  OfferModel copyWith({
    String? id,
    String? title,
    String? description,
    String? image,
    String? code,
  }) {
    return OfferModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      code: code ?? this.code,
    );
  }

  factory OfferModel.fake() {
    return OfferModel(
      id: '0',
      title: 'Offer Title Placeholder',
      description: 'Special offer description placeholder',
      image: '',
      code: 'PROMO20',
    );
  }
}
