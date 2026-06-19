class ReviewModel {
  final String id;
  final String userName;
  final String userImage;
  final double rating;
  final String comment;
  final DateTime date;

  ReviewModel({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.rating,
    required this.comment,
    required this.date,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      userName: json['userName'],
      userImage: json['userImage'],
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'userImage': userImage,
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
    };
  }

  ReviewModel copyWith({
    String? id,
    String? userName,
    String? userImage,
    double? rating,
    String? comment,
    DateTime? date,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      date: date ?? this.date,
    );
  }

  factory ReviewModel.fake() {
    return ReviewModel(
      id: '1',
      userName: 'John Doe',
      userImage: 'https://i.pravatar.cc/150?u=1',
      rating: 4.5,
      comment: 'The food was amazing and the service was great!',
      date: DateTime.now(),
    );
  }
}
