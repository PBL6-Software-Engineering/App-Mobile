import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:health_care/providers/http_provider.dart';
import 'package:intl/intl.dart';
class Rating {
  int countRating;
  double numberRating;
  RatingDetails countDetails;
  List<RatingItem> ratings;

  Rating({
    required this.countRating,
    required this.numberRating,
    required this.countDetails,
    required this.ratings,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    var ratingsList = json['ratings']['data'] as List;
    return Rating(
      countRating: json['cout_rating'],
      numberRating: json['number_rating'].toDouble(),
      countDetails: RatingDetails.fromJson(json['cout_details']),
      ratings: ratingsList.map((e) => RatingItem.fromJson(e)).toList() ?? [],
    );
  }
}

class RatingDetails {
  int oneStar;
  int twoStar;
  int threeStar;
  int fourStar;
  int fiveStar;

  RatingDetails({
    required this.oneStar,
    required this.twoStar,
    required this.threeStar,
    required this.fourStar,
    required this.fiveStar,
  });

  factory RatingDetails.fromJson(Map<String, dynamic> json) {
    return RatingDetails(
      oneStar: json['1_star'] ?? 0,
      twoStar: json['2_star'] ?? 0,
      threeStar: json['3_star'] ?? 0,
      fourStar: json['4_star'] ?? 0,
      fiveStar: json['5_star'] ?? 0,
    );
  }
}

class RatingItem {
  int idRating;
  int id;
  int idUser;
  int idWorkSchedule;
  int numberRating;
  String detailRating;
  String createdAt;
  DateTime updatedAt;
  String nameUser;
  String avatarUser;

  RatingItem({
    required this.idRating,
    required this.id,
    required this.idUser,
    required this.idWorkSchedule,
    required this.numberRating,
    required this.detailRating,
    required this.createdAt,
    required this.updatedAt,
    required this.nameUser,
    required this.avatarUser,
  });

  factory RatingItem.fromJson(Map<String, dynamic> json) {
    final HttpProvider _httpProvider = HttpProvider();
    final String _url = HttpProvider.url;
    return RatingItem(
      idRating: json['id_rating'],
      id: json['id'],
      idUser: json['id_user'],
      idWorkSchedule: json['id_work_schedule'],
      numberRating: json['number_rating'],
      detailRating: json['detail_rating'],
      createdAt:
          (DateFormat('dd/MM/yyyy').format(DateTime.parse(json['created_at'])))
              .toString(),
      updatedAt: DateTime.parse(json['updated_at']),
      nameUser: json['name_user'],
      avatarUser: json['avatar_user'] !=null ? (_url+json['avatar_user']) : '',
    );
  }
}