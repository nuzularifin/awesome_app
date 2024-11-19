import 'package:flutter_awesome_app/domain/entities/photo.dart';

class PhotoModel extends Photo {
  PhotoModel({
    required int? id,
    required int? width,
    required int? height,
    required String? url,
    required String? photographer,
    required String? photographerUrl,
    required int? photographerId,
    required String? avgColor,
    required Src? src,
    required bool liked,
    required String? alt,
  }) : super(
          id: id,
          width: width,
          height: height,
          url: url,
          photographer: photographer,
          photographerUrl: photographerUrl,
          photographerId: photographerId,
          avgColor: avgColor,
          src: src,
          liked: liked,
          alt: alt,
        );

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'] as int,
      width: json['width'] as int,
      height: json['height'] as int,
      url: json['url'] as String,
      photographer: json['photographer'] as String,
      photographerUrl: json['photographer_url'] != null
          ? json['photographerUrl'].toString()
          : '',
      photographerId: json['photographer_id'] as int,
      avgColor: json['avg_color'] as String,
      src: json['src'] != null ? Src.fromJson(json['src']) : null,
      liked: json['liked'] as bool,
      alt: json['alt'] as String,
    );
  }
}
