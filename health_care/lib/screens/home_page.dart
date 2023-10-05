import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/utils/config.dart';
import 'package:http/http.dart' as http;
import "dart:convert";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article> articles = [
    Article(
        image:
            'https://tse2.explicit.bing.net/th?id=OIP.edlZrGPHLygPXihyUuqq7AHaE7&pid=Api&P=0&h=180',
        title: 'Bài báo 1'),
    Article(
        image:
            'https://tse2.explicit.bing.net/th?id=OIP.edlZrGPHLygPXihyUuqq7AHaE7&pid=Api&P=0&h=180',
        title: 'Bài báo 1'),
    Article(
        image:
            'https://tse2.explicit.bing.net/th?id=OIP.edlZrGPHLygPXihyUuqq7AHaE7&pid=Api&P=0&h=180',
        title: 'Bài báo 1'),
  ];
  List<Category> categories = [
    Category(
        image:
            'https://tse2.explicit.bing.net/th?id=OIP.edlZrGPHLygPXihyUuqq7AHaE7&pid=Api&P=0&h=180',
        title: 'Tim mach'),
    Category(
        image:
            'https://tse4.mm.bing.net/th?id=OIP.xYpB4gI5Om_93NF7Ugfd3AHaFj&pid=Api&P=0&h=180',
        title: 'Răng miệng'),
    Category(
        image:
            'https://tse3.explicit.bing.net/th?id=OIP.RavAN79V5KK5qOAo9zWrhQHaFj&pid=Api&P=0&h=180',
        title: 'Tâm lí'),
  ];

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              width: Config.screenWidth,
              height: Config.screenHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Config.spaceMedium,
                      Center(
                        child: Container(
                          child: SvgPicture.asset(
                            'assets/icons/logo.svg',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                      Config.spaceMedium,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Row(
                            children: <Widget>[
                              Icon(Icons.location_on_outlined),
                              Text(
                                'Da Nang',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(
                              Icons.notifications,
                              color: Colors.black,
                              size: 30.0,
                            ),
                          ),
                        ],
                      ),
                      Config.spaceSmall,
                      Container(
                        padding: const EdgeInsets.only(top: .5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5.0,
                              ),
                              width: Config.screenWidth! * 0.9,
                              decoration: BoxDecoration(
                                color: Config.primaryColor.withOpacity(.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Colors.black54.withOpacity(.6),
                                  ),
                                  const Expanded(
                                    child: TextField(
                                      showCursor: false,
                                      decoration: InputDecoration(
                                        hintText: ' Enter your keyword',
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.mic,
                                    color: Colors.black54.withOpacity(.6),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Config.spaceSmall,
                      Center(
                        child: Image.asset(
                          'assets/images/eye.jpg',
                          width: 350,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 0.02),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: 6,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return GridItem(index: index);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 300,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Expanded(
                        child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: [
                              Image.network(categories[index].image),
                              SizedBox(height: 8.0),
                              Text(categories[index].title),
                            ],
                          ),
                        );
                      },
                    ))
                  ]),
            ),
            Container(
              height: 300,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Article",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Expanded(
                        child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: articles.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: [
                              Image.network(articles[index].image),
                              SizedBox(height: 8.0),
                              Text(articles[index].title),
                            ],
                          ),
                        );
                      },
                    ))
                  ]),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   //backgroundColor: Colors.lightBlue,
      //   items: [
      //     BottomNavigationBarItem(
      //       backgroundColor: Colors.lightBlueAccent,
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.message),
      //       label: 'Message',
      //     ),
      //     // BottomNavigationBarItem(
      //     //   icon: Icon(Icons.notifications),
      //     //   label: 'Notifications',
      //     // ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.calendar_month),
      //       label: 'Calendar',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
    );
  }
}

class Category {
  final String image;
  final String title;

  const Category({required this.image, required this.title});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      image: json['image'],
      title: json['title'],
    );
  }
}

Future<Category> fetchCategory() async {
  final response = await http.get(Uri.parse(''));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Category.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Category');
  }
}

class Article {
  final String image;
  final String title;
  Article({required this.image, required this.title});
}

class GridItem extends StatelessWidget {
  final int index;

  GridItem({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      padding: EdgeInsets.all(.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.star, size: 20),
          Text('Item $index'),
        ],
      ),
    );
  }
}
