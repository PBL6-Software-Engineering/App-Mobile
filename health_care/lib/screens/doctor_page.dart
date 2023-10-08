import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: SvgPicture.asset(
                './assets/icons/logo.svg',
                width: 50.0,
                height: 50.0,
              ),       
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container chứa ảnh và thông tin bác sĩ
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage('https://scontent.fdad1-3.fna.fbcdn.net/v/t39.30808-6/329955334_1312545392671404_3553447315934308919_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=a2f6c7&_nc_ohc=lAy4EDgnlYMAX_mJfWl&_nc_ht=scontent.fdad1-3.fna&oh=00_AfAfg4vsHSPWvHhXRCcyu6081Iwnr_2Li_RJQWoc91THxQ&oe=65242638'),
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bác Sĩ Quốc',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Khoa Tim mạch',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Xử lý khi nhấn nút nhắn tin
                            },
                            child: Text('Tư vấn'),
                          ),
                          SizedBox(width: 8.0),
                          ElevatedButton(
                            onPressed: () {
                              // Xử lý khi nhấn nút đặt lịch hẹn
                            },
                            child: Text('Đặt lịch hẹn'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Đoạn text chứa tên bệnh viện và địa chỉ
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.local_hospital,
                    size: 24.0,
                  ),
                  SizedBox(width: 8.0),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 100,
                    ),
                    child: Text(
                      'Bệnh viện đa khoa Đà Nẵng',
                      style: TextStyle(fontSize: 18.0),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    size: 24.0,
                  ),
                  SizedBox(width: 8.0),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 100,
                    ),
                    child: Text(
                      '54 Nguyễn Lưong Bằng, Liên Chiểu, Đà Nẵng',
                      style: TextStyle(fontSize: 18.0),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),

            // Container chứa tiêu đề thông tin nổi bật
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thông tin nổi bật:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Dr.Quốc đã hoàn thành chương trình đào tạo tại Trường Y khoa Quốc gia và hiện đang làm việc tại Bệnh viện Trung ương. Dr. A đã được công nhận là một chuyên gia hàng đầu trong điều trị các bệnh tim mạch phức tạp và đã tham gia vào nhiều nghiên cứu lâm sàng để cải thiện phương pháp điều trị. Anh cũng chú trọng đến việc tư vấn và giáo dục bệnh nhân về lối sống lành mạnh và quan trọng của việc duy trì sức khỏe tim mạch. Bác sĩ Quốc luôn tận tâm và chu đáo trong việc chăm sóc bệnh nhân, mang đến cho họ sự an tâm và hy vọng trong quá trình điều trị',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),

            // Kinh nghiệm làm việc
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kinh nghiệm làm việc',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Dr. Quoc là một bác sĩ chuyên khoa tim mạch với hơn 10 năm kinh nghiệm trong lĩnh vực này. Anh đã hoàn thành chương trình đào tạo tại Trường Y khoa Quốc gia và hiện đang làm việc tại Bệnh viện Trung ương.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),

            // Giờ làm việc trong tuần
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thời gian làm việc:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        leading: Text('Thứ 2:'),
                        title: Text('8:00 AM - 5:00 PM'),
                      ),
                      ListTile(
                        leading: Text('Thứ 3:'),
                        title: Text('9:00 AM - 6:00 PM'),
                      ),
                      ListTile(
                        leading: Text('Thứ 4:'),
                        title: Text('8:30 AM - 4:30 PM'),
                      ),
                      ListTile(
                        leading: Text('Thứ 5:'),
                        title: Text('10:00 AM - 7:00 PM'),
                      ),
                      ListTile(
                        leading: Text('Thứ 6:'),
                        title: Text('8:00 AM - 5:00 PM'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
