class OnboardingModel {
  final String title;
  final String subtitle;
  final String image;

  OnboardingModel({
    required this.title,
    required this.subtitle,
    required this.image,
  });

  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
      title: json['title'],
      subtitle: json['subtitle'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'image': image,
    };
  }

  OnboardingModel copyWith({
    String? title,
    String? subtitle,
    String? image,
  }) {
    return OnboardingModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      image: image ?? this.image,
    );
  }
}
