import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/components/article.dart';
import 'package:health_care/components/search_form.dart';
import 'package:health_care/components/search_results.dart';
import 'package:health_care/objects/articles.dart';
import 'package:health_care/objects/categories.dart';
import 'package:health_care/providers/http_provider.dart';
import 'package:health_care/screens/category_page.dart';
import 'package:health_care/utils/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _url = HttpProvider.url;
  TextEditingController _searchController = TextEditingController();
  CategoryService categoryService = CategoryService();
  ArticleService articleService = ArticleService();
  List<Category> categories = [];
  List<Article> articles = [];
  List<Article> articleResults = [];
  bool loading = true;

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
      articles = await articleService.fetchArticles('api/article');
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

  void fetchSearchArticleList() async {
    loading = true;

    try {
      List<Article> fetchedArticles = await articleService.fetchArticles(
        'api/article?search=${_searchController.text}',
      );
      setState(() {
        articleResults = fetchedArticles;
        loading = false;
        print(articleResults);
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
                                hintText: 'Tìm kiếm bài viết',
                                controller: _searchController,
                                onSearch: fetchSearchArticleList,
                                
                              ),
                            ),
                            Visibility(
                              visible: _searchController.text.isNotEmpty,
                              child: loading || _searchController.text.isEmpty
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : articleResults.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: articleResults.length,
                                          itemBuilder: (context, index) {
                                            return ArticleContainer(
                                              article: articleResults[index],
                                            );
                                          },
                                        )
                                      : Center(
                                          child: Text('Không tìm thấy kết quả'),
                                        ),
                            ),
                            Visibility(
                                visible: _searchController.text.isEmpty,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, 
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
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CategoryPage(
                                                            categoryName:
                                                                categories[
                                                                        index]
                                                                    .name),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: 150,
                                                height: 200,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 120,
                                                      height: 120,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              categories[index]
                                                                  .thumbnail),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      categories[index].name,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Color.fromARGB(
                                                            255, 43, 52, 179),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                CategoryPage(
                                                                    categoryName:
                                                                        categories[index]
                                                                            .name),
                                                          ),
                                                        );
                                                      },
                                                      child:
                                                          Text('Xem chi tiết'),
                                                    ),
                                                  ],
                                                ),
                                              ));
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
                                            child: ArticleContainer(
                                                article: articles[index]),
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
