import 'package:flutter_awesome_app/domain/entities/photo.dart';

abstract class PhotoRepository {
  Future<List<Photo>> getPhotoList(int page);
}
