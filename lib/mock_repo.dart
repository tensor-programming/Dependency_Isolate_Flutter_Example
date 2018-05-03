import 'package:di_isolates/model.dart';
import 'package:di_isolates/photo_repo.dart';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'dart:async';

class MockRepo extends PhotoRepo {
  @override
  Future<List<Photo>> fetchPhotos(http.Client client) async {
    return compute(createPhotos, 400);
  }
}

List<Photo> createPhotos(int x) {
  return List.generate(
      x,
      (int i) => Photo(
          id: i,
          title: 'example $i',
          url: 'https://placeimg.com/640/480/tech/$i'));
}
