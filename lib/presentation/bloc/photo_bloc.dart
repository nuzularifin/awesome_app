import 'package:flutter_awesome_app/domain/entities/photo.dart';
import 'package:flutter_awesome_app/domain/usecase/get_photo_list.dart';
import 'package:flutter_awesome_app/presentation/bloc/photo_event.dart';
import 'package:flutter_awesome_app/presentation/bloc/photo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final GetPhotoList getPhotoList;
  int currentPage = 1;
  final List<Photo> _photos = [];

  PhotoBloc(this.getPhotoList) : super(PhotoListInitial()) {
    on<FetchPhotoList>(_onGetPhotoList);
    on<FetchPhotoListMore>(_onGetPhotoListMore);
    on<ToogleListStyleEvent>(_onGetToogleListStyleEvent); //
  }

  Future<void> _onGetPhotoList(
      FetchPhotoList event, Emitter<PhotoState> emit) async {
    emit(PhotoListLoading());

    try {
      final response = await getPhotoList.exec(currentPage);
      _photos.addAll(response);
      if (response.isEmpty) {
        emit(PhotoListSuccess(photos: _photos, hasReachedMax: true));
      } else {
        emit(PhotoListSuccess(photos: _photos));
      }
    } catch (e) {
      emit(PhotoListError(message: 'Failed cause $e'));
    }
  }

  Future<void> _onGetPhotoListMore(
      FetchPhotoListMore event, Emitter<PhotoState> emit) async {
    if (state is PhotoListSuccess) {
      final currentState = state as PhotoListSuccess;
      if (currentState.hasReachedMax) return;

      try {
        currentPage++;
        final result = await getPhotoList.exec(currentPage);
        if (result.isEmpty) {
          emit(currentState.copyWith(
            photos: currentState.photos,
            hasReachedMax: true,
          ));
        } else {
          emit(currentState.copyWith(
            photos: currentState.photos + result,
            hasReachedMax: false,
          ));
        }
      } catch (e) {
        emit(PhotoListError(message: 'Failed cause $e'));
      }
    }
  }

  Future<void> _onGetToogleListStyleEvent(
    ToogleListStyleEvent event,
    Emitter<PhotoState> emit,
  ) async {
    if (state is PhotoListSuccess) {
      final currentState = state as PhotoListSuccess;
      emit(currentState.copyWith(
        style: currentState.style == PhotoListStyle.list
            ? PhotoListStyle.grid
            : PhotoListStyle.list,
      ));
    }
  }
}