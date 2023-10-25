import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/components/search_form.dart';
import 'package:health_care/objects/articles.dart';
import 'package:health_care/objects/categories.dart';
import 'package:health_care/providers/http_provider.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/utils/text.dart';
import 'package:health_care/components/article.dart';
import 'package:health_care/screens/article_page.dart';
import 'package:health_care/screens/category_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _url = HttpProvider.url;
  final _searchController = TextEditingController();
  CategoryService categoryService = CategoryService();
  ArticleService articleService = ArticleService();
  List<Category> categories = [];
  List<Article> articles = [];
  Future<List<String>>? searchResults;
  bool isSearching = false;

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

  @override
  void initState() {
    fetchArticleList();
    fetchCategoryList();
    super.initState();
  }

  void fetchArticleList() async {
    try {
      articles = await articleService.fetchArticles();
      setState(() {});
    } catch (e) {
      print('Error: $e');
    }
  }

  void fetchCategoryList() async {
    try {
      categories = await categoryService.fetchCategories();
      setState(() {});
      // Sử dụng danh sách category ở đây
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
                            if (searchResults != null)
                              FutureBuilder<List<String>>(
                                future: searchResults,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasData) {
                                    final results = snapshot.data!;
                                    return ListView.builder(
                                      itemCount: results.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(results[index]),
                                        );
                                      },
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text('Error: ${snapshot.error}'));
                                  } else {
                                    return Center(
                                        child: Text('Không tìm thấy kết quả'));
                                  }
                                },
                              ),
                            Visibility(
                                visible: _searchController.text.isEmpty,
                                child: Padding(
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
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Visibility(
                          visible: _searchController.text.isEmpty,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 300,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Chủ đề",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Config.spaceSmall,
                                    Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: categories.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                              return InkWell(
                                              onTap: () {
                                                // Xử lý sự kiện click tại đây
                                                Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => CategoryPage(categoryName: categories[index].name),
                                                ),
                                              );
                                              },
                                              child: Container(
                                                width: 155,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8.0),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Image.network(
                                                          categories[index]
                                                              .thumbnail,
                                                      width:
                                                          150, // Chiều rộng mong muốn
                                                      height:
                                                          150, // Chiều cao mong muốn
                                                      fit: BoxFit.contain,
                                                    ),
                                                    Config.spaceSmall,
                                                    Text(
                                                      categories[index].name,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                              );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 500,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Bài viết mới",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Config.spaceSmall,
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: articles.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            // onTap: () {
                                            //   Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) => ArticlePage(article: articles[index]),
                                            //     ),
                                            //   );
                                            // },
                                            // splashColor: Colors.blue.withOpacity(0.5), // Màu sắc hiệu ứng lan tỏa
                                            // highlightColor: const Color.fromARGB(0, 226, 22, 22), // Màu sắc hiệu ứng khi đang click
                                            child: ArticleContainer(article: articles[index]),
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
