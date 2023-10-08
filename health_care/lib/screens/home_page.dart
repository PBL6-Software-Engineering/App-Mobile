import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/components/search_form.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/utils/text.dart';
import 'package:http/http.dart' as http;
import "dart:convert";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();

  final List<String> catNames = [
    "Đặt lịch hẹn",
    "Kiểm tra sức khoẻ",
    "Cửa hàng",
    "Cộng đồng",
  ];

  final List<String> catImageUrls = [
    'https://hhg-common.hellobacsi.com/common/nav-icons/shop.svg',
    'https://hhg-common.hellobacsi.com/common/nav-icons/care.svg',
    'https://hhg-common.hellobacsi.com/common/nav-icons/community.svg',
    'https://hhg-common.hellobacsi.com/common/nav-icons/health-tools.svg',
  ];

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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/icons/menu-search.svg',
                            width: 25,
                            height: 25,
                          ),
                          SvgPicture.asset(
                            'assets/icons/logo.svg',
                            width: 40,
                            height: 40,
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage("assets/images/Ellipse-1.png"),
                              ),
                              Config.gapSmall,
                              Text(
                                "Xin chào! \nProgram",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                          Config.spaceSmall,
                          Row(
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
                        ],
                      ),
                      Config.spaceSmall,
                      Container(
                        padding: const EdgeInsets.only(top: .5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              width: Config.screenWidth! * 0.9,
                              decoration: BoxDecoration(
                                color: Config.primaryColor.withOpacity(.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SearchInput(
                                hintText: AppText.enText['search_text']!,
                                controller: _searchController,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Specify crossAxisAlignment
                                children: <Widget>[
                                  GridView.builder(
                                    itemCount: catNames.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 2,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: SvgPicture.network(
                                                catImageUrls[index],
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            catNames[index],
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Category",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Config.spaceSmall,
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          categories[index].image,
                                        ),
                                        Config.spaceSmall,
                                        Text(categories[index].title),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Article",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Config.spaceSmall,
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: articles.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.network(articles[index].image),
                                        Config.spaceSmall,
                                        Text(articles[index].title),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
