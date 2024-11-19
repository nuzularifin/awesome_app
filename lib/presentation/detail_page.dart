import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_app/domain/entities/photo.dart';

class DetailPage extends StatelessWidget {
  final Photo photo;

  DetailPage({required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxisScrolled) {
          return [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.6,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding:
                    EdgeInsetsDirectional.only(start: 72, bottom: 16, end: 102),
                title: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  'Photo Detail',
                  style: TextStyle(
                    color: innerBoxisScrolled == true
                        ? Colors.black
                        : Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(0, 1),
                        blurRadius: 3,
                      )
                    ],
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      photo.src?.original ?? '',
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(16.0),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 12.0,
              ),
              Text(
                '${photo.alt}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Text(
                'Photographer',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 12.0,
                ),
              ),
              Text(
                '${photo.photographer}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'URL :',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 12.0,
                ),
              ),
              Text(
                '${photo.url}',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
