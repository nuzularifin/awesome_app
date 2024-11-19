import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_app/presentation/bloc/photo_bloc.dart';
import 'package:flutter_awesome_app/presentation/bloc/photo_event.dart';
import 'package:flutter_awesome_app/presentation/bloc/photo_state.dart';
import 'package:flutter_awesome_app/presentation/detail_page.dart';
import 'package:flutter_awesome_app/presentation/dashboard/photo_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_awesome_app/core/service_locator.dart' as di;

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final _scrollController = ScrollController();
  var _photoBloc;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _photoBloc.add(FetchPhotoListMore());
      }
    });

    _photoBloc = di.getIt<PhotoBloc>();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotoBloc>(
      create: (context) => _photoBloc..add(FetchPhotoList()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Awesome App'),
          actions: [
            BlocBuilder<PhotoBloc, PhotoState>(
              builder: (context, state) {
                return IconButton(
                  icon: Icon(state.style == PhotoListStyle.list
                      ? Icons.grid_view
                      : Icons.list),
                  onPressed: () => _photoBloc.add(ToogleListStyleEvent()),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 12.0,
              ),
              Flexible(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: PhotoContent(
                    scrollController: _scrollController,
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
