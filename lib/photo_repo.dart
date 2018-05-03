import 'package:di_isolates/model.dart';

import 'package:http/http.dart' as http;

import 'dart:async';

abstract class PhotoRepo {
  Future<List<Photo>> fetchPhotos(http.Client client);
}
