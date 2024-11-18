import 'package:flutter_awesome_app/domain/entities/photo.dart';
import 'package:flutter_awesome_app/domain/repositories/photo_repository.dart';

class GetPhotoList {
  final PhotoRepository _repository;

  GetPhotoList(this._repository);

  Future<List<Photo>> exec(int page) async {
    return await _repository.getPhotoList(page);
  }
}
