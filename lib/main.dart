import 'package:flutter/material.dart';
import 'package:di_isolates/model.dart';
import 'package:di_isolates/injector.dart';

import 'package:http/http.dart' as http;

void main() {
  Injector.configure(RepoType.PROD);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Injector injector;

  @override
  void initState() {
    super.initState();
    injector = Injector();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DI and Isoalte Demo"),
      ),
      body: FutureBuilder<List<Photo>>(
          future: injector.photoRepo.fetchPhotos(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? PhotoGrid(photos: snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class PhotoGrid extends StatelessWidget {
  final List<Photo> photos;

  PhotoGrid({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) => Image.network(photos[index].url),
    );
  }
}
