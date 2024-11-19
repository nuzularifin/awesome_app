import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_app/domain/entities/photo.dart';
import 'package:flutter_awesome_app/themes/app_text_styles.dart';

class DetailPage extends StatelessWidget {
  final Photo photo;

  const DetailPage({super.key, required this.photo});

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
                'Alt:',
                style: AppTextStyles.labelblacknormal12,
              ),
              Text(
                '${photo.alt}',
                style: AppTextStyles.labelblackbold16,
              ),
              SizedBox(
                height: 12.0,
              ),
              Text(
                'Photographer',
                style: AppTextStyles.labelblacknormal12,
              ),
              Text(
                '${photo.photographer}',
                style: AppTextStyles.labelblackbold16,
              ),
              SizedBox(height: 12),
              Text(
                'Resource:',
                style: AppTextStyles.labelblacknormal12,
              ),
              Text(
                '${photo.url}',
                style: AppTextStyles.labelblackbold12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
