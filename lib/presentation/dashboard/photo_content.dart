import 'package:flutter/material.dart';
import 'package:flutter_awesome_app/presentation/bloc/photo_bloc.dart';
import 'package:flutter_awesome_app/presentation/bloc/photo_state.dart';
import 'package:flutter_awesome_app/presentation/dashboard/book_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoContent extends StatelessWidget {
  final ScrollController scrollController;

  PhotoContent({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoBloc, PhotoState>(
      builder: (context, state) {
        if (state is PhotoListLoading || state is PhotoListInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is PhotoListSuccess) {
          if (state.style == PhotoListStyle.list) {
            return ListView.builder(
              shrinkWrap: true,
              controller: scrollController,
              scrollDirection: Axis.vertical,
              itemCount: state.hasReachedMax
                  ? state.photos.length
                  : state.photos.length + 1,
              itemBuilder: (context, index) {
                if (index < state.photos.length) {
                  return BookCard(
                    photo: state.photos[index],
                    onClick: () =>
                        {print('Movie : ${state.photos[index].photographer}')},
                  );
                } else {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          } else {
            return GridView.builder(
              padding: EdgeInsets.all(12.0),
              shrinkWrap: true,
              controller: scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0),
              itemCount: state.hasReachedMax
                  ? state.photos.length
                  : state.photos.length + 1,
              itemBuilder: (context, index) {
                if (index < state.photos.length) {
                  return BookCard(
                    photo: state.photos[index],
                    onClick: () =>
                        {print('Movie : ${state.photos[index].photographer}')},
                  );
                } else {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          }
        }

        if (state is PhotoListError) {
          return Center(
            child: Text('Error loading movies: ${state.message}'),
          );
        }

        return Container();
      },
    );
  }
}
