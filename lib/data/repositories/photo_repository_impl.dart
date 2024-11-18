import 'package:flutter_awesome_app/data/model/photo_model.dart';
import 'package:flutter_awesome_app/data/services/photo_api_service.dart';
import 'package:flutter_awesome_app/domain/entities/photo.dart';
import 'package:flutter_awesome_app/domain/repositories/photo_repository.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoApiService _service;

  PhotoRepositoryImpl(this._service);

  @override
  Future<List<PhotoModel>> getPhotoList(int page) async {
    return await _service.getPhotoList(page);
  }
}
