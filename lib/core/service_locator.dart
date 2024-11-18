import 'package:dio/dio.dart';
import 'package:flutter_awesome_app/data/repositories/photo_repository_impl.dart';
import 'package:flutter_awesome_app/data/services/photo_api_service.dart';
import 'package:flutter_awesome_app/domain/repositories/photo_repository.dart';
import 'package:flutter_awesome_app/domain/usecase/get_photo_list.dart';
import 'package:flutter_awesome_app/presentation/bloc/photo_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<Dio>(() => Dio());

  // register api Service
  getIt.registerLazySingleton<PhotoApiService>(
      () => PhotoApiService(getIt<Dio>()));

  // register repisitory
  getIt.registerLazySingleton<PhotoRepository>(
      () => PhotoRepositoryImpl(getIt<PhotoApiService>()));

  // register usecase
  getIt.registerLazySingleton<GetPhotoList>(
      () => GetPhotoList(getIt<PhotoRepository>()));

  // registerBloc
  getIt.registerFactory(() => PhotoBloc(getIt<GetPhotoList>()));
}
