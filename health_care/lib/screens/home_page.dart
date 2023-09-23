import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/utils/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
      ),
    );
  }
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
