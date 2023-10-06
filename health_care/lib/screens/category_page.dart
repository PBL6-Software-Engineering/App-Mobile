import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  final List<Article> articles = [
    Article(
      imageUrl:
          'https://scontent.fdad1-3.fna.fbcdn.net/v/t39.30808-6/329955334_1312545392671404_3553447315934308919_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=a2f6c7&_nc_ohc=lAy4EDgnlYMAX_mJfWl&_nc_ht=scontent.fdad1-3.fna&oh=00_AfAfg4vsHSPWvHhXRCcyu6081Iwnr_2Li_RJQWoc91THxQ&oe=65242638',
      title: 'Article Title 1',
      author: 'Author 1',
      timestamp: '2023-10-05',
    ),
    Article(
      imageUrl:
          'https://scontent.fdad1-3.fna.fbcdn.net/v/t39.30808-6/329955334_1312545392671404_3553447315934308919_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=a2f6c7&_nc_ohc=lAy4EDgnlYMAX_mJfWl&_nc_ht=scontent.fdad1-3.fna&oh=00_AfAfg4vsHSPWvHhXRCcyu6081Iwnr_2Li_RJQWoc91THxQ&oe=65242638',
      title: 'Article Title 2',
      author: 'Author 2',
      timestamp: '2023-10-04',
    ),
    // Thêm các Article khác tương tự ở đây
  ];
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // Xử lý sự kiện khi nhấn nút quay về
              },
            ),
            title: Center(
              child: SvgPicture.asset(
                './assets/icons/logo.svg',
                width: 30.0,
                height: 30.0,
              ),
            )),
        body: Column(children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Tim Mạch',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return ArticleContainer(article: articles[index]);
              },
            ),
          )
        ]));
  }
}

class Article {
  final String imageUrl;
  final String title;
  final String author;
  final String timestamp;

  Article({
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.timestamp,
  });
}

class ArticleContainer extends StatelessWidget {
  final Article article;

  const ArticleContainer({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(article.imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  article.author,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  article.timestamp,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
