import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/components/article.dart';
import 'package:health_care/components/tag.dart';
import 'package:health_care/components/search_form.dart';
import 'package:health_care/components/search_results.dart';
import 'package:health_care/objects/articles.dart';
import 'package:health_care/objects/categories.dart';
import 'package:health_care/providers/http_provider.dart';
import 'package:health_care/screens/appointment_page.dart';
import 'package:health_care/screens/category_page.dart';
import 'package:health_care/screens/all_categories_page.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/objects/user.dart';
import 'package:health_care/components/category.dart';
import 'package:health_care/screens/all_articles_page.dart';
import 'package:health_care/screens/bmi_page.dart';
import 'package:health_care/providers/auth_manager.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user = AuthManager.getUser();

  TextEditingController _searchController = TextEditingController();
  CategoryService categoryService = CategoryService();
  ArticleService articleService = ArticleService();
  List<Category> categories = [];
  List<Article> articles = [];
  List<Article> hotarticles = [];
  List<Article> articleResults = [];
  bool loadingcate = true;
  bool loadingart = true;
  bool loadingsearch = true;
  final List<String> catNames = [
    "Đặt lịch hẹn",
    "Kiểm tra sức khoẻ",
    // "Cửa hàng",
    // "Cộng đồng",
  ];
  final List<String> catImageUrls = [
    'https://hhg-common.hellobacsi.com/common/nav-icons/shop.svg',
    'https://hhg-common.hellobacsi.com/common/nav-icons/care.svg',
    // 'https://hhg-common.hellobacsi.com/common/nav-icons/community.svg',
    // 'https://hhg-common.hellobacsi.com/common/nav-icons/health-tools.svg',
  ];

  @override
  void initState() {
    
    fetchCategoryList();
    fetchArticleList();
    super.initState();
  }

  void fetchArticleList() async {
    loadingart = true;
    try {
      articles = await articleService.fetchArticles('api/article');
      hotarticles = [...articles];
      hotarticles.sort((a, b) => b.searchNumber.compareTo(a.searchNumber));
      setState(() {
        loadingart = false;
      });
    } catch (e) {
      print('Error fetch article: $e');
    }
  }

  void fetchCategoryList() async {
    loadingcate = true;
    try {
      categories = await categoryService.fetchCategories();
      setState(() {
        loadingcate = false;
      });
      // Sử dụng danh sách category ở đây
    } catch (e) {
      print('Error fetch category: $e');
    }
  }

  void fetchSearchArticleList() async {
    loadingsearch = true;

    try {
      List<Article> fetchedArticles = await articleService.fetchArticles(
        'api/article?search=${_searchController.text}',
      );
      setState(() {
        articleResults = fetchedArticles;
        loadingsearch = false;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

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
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('search');
                            },
                            child: SvgPicture.asset(
                              'assets/icons/menu-search.svg',
                              width: 25,
                              height: 25,
                            ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed('setting');
                                },
                                child: user.avatar == ''
                                    ? CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/images/user.jpeg'),
                                        radius: 25,
                                      )
                                    : CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(user.avatar),
                                        radius: 25,
                                      ),
                              ),
                              Config.gapSmall,
                              Text(
                                "Xin chào! \n" + user.name,
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
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed('booking-search');
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                width: Config.screenWidth! * 0.9,
                                decoration: BoxDecoration(
                                  color: Config.primaryColor.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.search),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed('booking-search');
                                      },
                                    ),
                                    Text('Tìm kiếm bệnh viện, bác sĩ...'),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: _searchController.text.isEmpty,
                              child: Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        return GestureDetector(
                                          onTap: () {
                                            if (index == 0) {
                                              // "Đặt lịch hẹn" is clicked
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AppointmentPage(),
                                                ),
                                              );
                                            } else if (index == 1) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BMIPage(),
                                                ),
                                              );
                                            }
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
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
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                          visible: _searchController.text.isEmpty,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 250,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TagContainer(tag: "Chủ Đề"),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AllCategoryPage(
                                                        categories: categories),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Xem thêm >>',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Config.blueColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //Config.spaceSmall,
                                    loadingcate
                                        ? Expanded(
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )
                                        : Expanded(
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: categories.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return CategoryContainer(
                                                    category:
                                                        categories[index]);
                                              },
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              Config.spaceSmall,
                              Container(
                                height: 500,
                                child: 
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TagContainer(tag: 'Bài Viết Mới'),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AllArticlePage(
                                                        articles: articles),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Xem thêm >>',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Config.blueColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Config.spaceSmall,
                                    loadingart
                                        ? Expanded(
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )
                                        : Expanded(
                                            child:  
                                            ListView.builder(
                                              itemCount: min(5,articles.length),
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  child: ArticleContainer(
                                                      article: articles[index]),
                                                );
                                              },
                                            ),
                                          )
                                  ],
                                ),
                              ),
                              SizedBox(height: 16),
                              Container(
                                height: 500,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TagContainer(tag: 'Bài Viết Nổi Bật'),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AllArticlePage(
                                                        articles: hotarticles),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Xem thêm >>',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Config.blueColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //Config.spaceSmall,
                                    loadingart
                                        ? Expanded(
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )
                                        : Expanded(
                                            child: ListView.builder(
                                              itemCount: min(5,hotarticles.length),
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  child: ArticleContainer(
                                                      article:
                                                          hotarticles[index]),
                                                );
                                              },
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            ],
                          )),
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
