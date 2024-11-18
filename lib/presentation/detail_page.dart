import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_app/domain/entities/photo.dart';

class DetailPage extends StatelessWidget {
  final Photo photo;

  DetailPage({required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(photo.photographer ?? '')),
      body: Column(
        children: [
          CachedNetworkImage(imageUrl: photo.photographerUrl ?? ''),
          const SizedBox(height: 16),
          Text('Photographer: ${photo.photographer}'),
          Text('Photo URL: ${photo.photographerUrl}'),
        ],
      ),
    );
  }
}
