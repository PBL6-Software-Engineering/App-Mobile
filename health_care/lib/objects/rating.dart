import 'package:health_care/utils/api_constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:health_care/providers/http_provider.dart';
import 'package:intl/intl.dart';

class RatingService {
  final HttpProvider _httpProvider = HttpProvider();
  final String _url = ApiConstant.linkApi;

  Future<Rating> fetchRating(String api) async {
    //final response =
    //  await _httpProvider.getData('api/infor-doctor/more-rating/${id.toString()}');
    //print(response);
    final response = await _httpProvider.getData(api);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      //print(responseData);

      Rating rating = Rating.fromJson(responseData['data']);

      //print(doctorDetail);
      return rating;
    } else {
      throw Exception('Failed to fetch rating');
    }
  }

  // Future<List<Rating>> fetchRatingService(int id) async {
  //   final response =
  //       await _httpProvider.getData('api/hospital-service/more-rating/${id.toString()}');
  //   //print(response);
  //   if (response.statusCode == 200) {
  //     final responseData = json.decode(response.body);
  //     final List<dynamic> jsonList = responseData['data'];
  //     //print(responseData);

  //     List<Rating> RatingList =
  //         jsonList.map((json) => Rating.fromJson(json)).toList();
  //     return RatingList;
  //   } else {
  //     throw Exception('Failed to fetch rating service');
  //   }
  // }
}

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
      countDetails: RatingDetails.fromJson(json['cout_details']) ??
          RatingDetails(
            oneStar: 0,
            twoStar: 0,
            threeStar: 0,
            fourStar: 0,
            fiveStar: 0,
          ),
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
    final String _url = ApiConstant.linkApi;
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
      avatarUser:
          json['avatar_user'] != null ? (_url + json['avatar_user']) : '',
    );
  }
}
