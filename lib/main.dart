//import 'dart:html';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CatService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

/// 고양이 서비스
class CatService extends ChangeNotifier {
  // 고양이 사진 담을 변수
  List<String> catImages = [];

  // 좋아요 사진 담을 변수
  List<String> favoriteImages = [];

  CatService() {
    getRandomCatImage();
  }

  void getRandomCatImage() async {
    Response result = await Dio().get(
        "https://api.thecatapi.com/v1/images/search?limit=10&mime_types=jpg");
    print(result.data);
    for (var i = 0; i < result.data.length; i++) {
      var map = result.data[i];
      print(map["url"]); // https://cdn2.thecatapi.com/images/aih.jpg

      catImages.add(map["url"]);
    }
    notifyListeners();
  }

  void toggleFavoriteImage(String catImage) {
    if (favoriteImages.contains(catImage)) {
      favoriteImages.remove(catImage); // 이미 좋아요한 경우 삭제
    } else {
      favoriteImages.add(catImage); // 추가
    }
    notifyListeners(); //새로고침
  }
}

/// 홈 페이지
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CatService>(
      builder: (context, catService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("랜덤 고양이"),
            backgroundColor: Colors.amber,
            actions: [
              // 좋아요 페이지로 이동
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritePage()),
                  );
                },
              )
            ],
          ),
          // 고양이 사진 목록
          body: GridView.count(
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            padding: EdgeInsets.all(8),
            crossAxisCount: 2,
            children: List.generate(
              catService.catImages.length,
              (index) {
                String catImage = catService.catImages[index];
                return GestureDetector(
                  onTap: () {
                    catService.toggleFavoriteImage(catImage);
                  },
                  child: Image.network(
                    catImage,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

/// 좋아요 페이지
class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CatService>(
      builder: (context, catService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("좋아요"),
            backgroundColor: Colors.amber,
          ),
        );
      },
    );
  }
}
