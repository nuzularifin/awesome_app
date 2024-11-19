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

class PhotoListRefreshing extends PhotoState {
  final DateTime timeStamp;

  PhotoListRefreshing() : timeStamp = DateTime.now();

  @override
  List<Object?> get props => [timeStamp];
}

class PhotoListSuccess extends PhotoState {
  final List<Photo> photos;
  bool hasReachedMax = false;
  PhotoListStyle style;
  bool hasLoadingMore = true;

  PhotoListSuccess(
      {required this.photos,
      this.hasReachedMax = false,
      this.style = PhotoListStyle.list,
      this.hasLoadingMore = true});

  PhotoListSuccess copyWith({
    List<Photo>? photos,
    bool? hasReachedMax,
    PhotoListStyle? style,
    bool? hasLoadingMore,
  }) {
    return PhotoListSuccess(
      photos: photos ?? this.photos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      style: style ?? this.style,
      hasLoadingMore: hasLoadingMore ?? this.hasLoadingMore,
    );
  }

  @override
  List<Object?> get props => [photos, style, hasLoadingMore];
}

class PhotoListError extends PhotoState {
  final String message;

  PhotoListError({required this.message});

  @override
  List<Object?> get props => [message];
}

class PhotoListMoreError extends PhotoState {
  final String message;

  PhotoListMoreError({required this.message});

  @override
  List<Object?> get props => [message];
}
