import 'package:flutter_awesome_app/data/model/photo_model.dart';

class BaseResponse<T> {
  int? totalResults;
  int? page;
  int? perPage;
  List<PhotoModel>? photos;
  String? nextPage;

  BaseResponse(
      {this.totalResults, this.page, this.perPage, this.photos, this.nextPage});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    totalResults = json['total_results'];
    page = json['page'];
    perPage = json['per_page'];
    if (json['photos'] != null) {
      photos = <PhotoModel>[];
      json['photos'].forEach((v) {
        photos!.add(PhotoModel.fromJson(v));
      });
    }
    nextPage = json['next_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_results'] = this.totalResults;
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    data['next_page'] = this.nextPage;
    return data;
  }
}
