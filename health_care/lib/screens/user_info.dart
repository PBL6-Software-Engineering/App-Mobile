import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/utils/config.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  User user = User(
    image:
        'https://scontent.fdad1-3.fna.fbcdn.net/v/t39.30808-6/329955334_1312545392671404_3553447315934308919_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=a2f6c7&_nc_ohc=lAy4EDgnlYMAX_mJfWl&_nc_ht=scontent.fdad1-3.fna&oh=00_AfAfg4vsHSPWvHhXRCcyu6081Iwnr_2Li_RJQWoc91THxQ&oe=65242638',
    name: 'Quoc Tran',
    id: '123456',
    phone: '1234567890',
    email: 'quoctran@gmail.com',
    gender: 'Male',
  );
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin cá nhân'),
        backgroundColor: Config.blueColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Config.spaceSmall,
            Center(
              child: SvgPicture.asset(
                './assets/icons/logo.svg',
                width: 100.0,
                height: 100.0,
              ),
            ),
            Config.spaceSmall,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user.image),
                  radius: 40.0,
                ),
                Config.spaceSmall,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Config.spaceSmall,
                    Text('ID:' + user.id),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
              ],
            ),
            buildSettingItem('Phone', user.phone),
            buildSettingItem('Email', user.email),
            buildSettingItem('Gender', user.gender),
          ],
        ),
      ),
    );
  }

  Widget buildSettingItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(value),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Xử lý sự kiện nút chỉnh sửa
            },
          ),
        ],
      ),
    );
  }
}

class User {
  final String id;
  final String image;
  final String name;
  final String phone;
  final String email;
  final String gender;
  User(
      {required this.id,
      required this.image,
      required this.name,
      required this.phone,
      required this.email,
      required this.gender});
}
