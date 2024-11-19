import 'package:flutter/material.dart';
import 'package:flutter_awesome_app/domain/entities/photo.dart';
import 'package:flutter_awesome_app/presentation/bloc/photo_bloc.dart';
import 'package:flutter_awesome_app/presentation/bloc/photo_event.dart';
import 'package:flutter_awesome_app/presentation/bloc/photo_state.dart';
import 'package:flutter_awesome_app/presentation/dashboard/book_card.dart';
import 'package:flutter_awesome_app/presentation/detail_page.dart';
import 'package:flutter_awesome_app/presentation/shared/card_shimmer_placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoContent extends StatelessWidget {
  final ScrollController scrollController;

  PhotoContent({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    Future<void> refreshData() async {
      var currentPhotoBloc = BlocProvider.of<PhotoBloc>(context);
      currentPhotoBloc.add(RefreshFetchPhotoList());
    }

    return RefreshIndicator(
      onRefresh: refreshData,
      child: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, state) {
          if (state is PhotoListInitial) {
            return const Center(child: Text('Data Kosong'));
          }

          if (state is PhotoListLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PhotoListRefreshing) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PhotoListSuccess) {
            if (state.style == PhotoListStyle.list) {
              return ListView.builder(
                padding: EdgeInsets.all(12.0),
                shrinkWrap: true,
                controller: scrollController,
                scrollDirection: Axis.vertical,
                itemCount: state.hasReachedMax
                    ? state.photos.length
                    : state.photos.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.photos.length) {
                    return Container(
                      height: 200,
                      child: BookCard(
                        photo: state.photos[index],
                        onClick: () {
                          openDetailPage(state.photos[index], context);
                        },
                      ),
                    );
                  } else {
                    return CardShimmerPlaceHolder(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
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
                    : state.photos.length + 2,
                itemBuilder: (context, index) {
                  if (index < state.photos.length) {
                    return BookCard(
                        photo: state.photos[index],
                        onClick: () {
                          openDetailPage(state.photos[index], context);
                        });
                  } else {
                    return CardShimmerPlaceHolder(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
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
      ),
    );
  }
}

void openDetailPage(Photo photo, context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => DetailPage(photo: photo)));
}
