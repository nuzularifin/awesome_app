import 'package:equatable/equatable.dart';

abstract class PhotoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPhotoList extends PhotoEvent {}

class FetchPhotoListMore extends PhotoEvent {}

class ToogleListStyleEvent extends PhotoEvent {}

class RefreshFetchPhotoList extends PhotoEvent {}
