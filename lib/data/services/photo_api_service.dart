import 'package:flutter_awesome_app/core/api_provider.dart';
import 'package:flutter_awesome_app/core/base_response.dart';
import 'package:flutter_awesome_app/data/model/photo_model.dart';

class PhotoApiService extends ApiProvider {
  PhotoApiService(dio);

  Future<List<PhotoModel>> getPhotoList(int page) async {
    final response = await dio.get('v1/search', queryParameters: {
      'page': page,
      'per_page': 20,
      'query': 'nature',
    });

    if (response.statusCode == 200) {
      final results = BaseResponse.fromJson(response.data);
      return results.photos?.toList() ?? List.empty();
    } else {
      throw Exception('Failed to fetch photo list ${response.statusMessage}');
    }
  }
}
