import 'package:equatable/equatable.dart';
import 'package:flutter_awesome_app/domain/entities/photo.dart';

enum PhotoListStyle { grid, list }

abstract class PhotoState extends Equatable {
  final PhotoListStyle style;

  PhotoState({this.style = PhotoListStyle.list});

  @override
  List<Object?> get props => [style];
}

class PhotoListInitial extends PhotoState {}

class PhotoListLoading extends PhotoState {}

class PhotoListSuccess extends PhotoState {
  final List<Photo> photos;
  bool hasReachedMax = false;
  final PhotoListStyle style;

  PhotoListSuccess(
      {required this.photos,
      this.hasReachedMax = false,
      this.style = PhotoListStyle.list});

  PhotoListSuccess copyWith({
    List<Photo>? photos,
    bool? hasReachedMax,
    PhotoListStyle? style,
  }) {
    return PhotoListSuccess(
      photos: photos ?? this.photos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      style: style ?? this.style,
    );
  }

  @override
  List<Object?> get props => [photos, style];
}

class PhotoListError extends PhotoState {
  final String message;

  PhotoListError({required this.message});

  @override
  List<Object?> get props => [message];
}
