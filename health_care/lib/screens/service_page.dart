import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/components/booking_form.dart';
import 'package:health_care/objects/services.dart';
import 'package:health_care/main_layout.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:health_care/objects/rating.dart';
import 'package:health_care/components/rating.dart';
import 'package:health_care/components/tag.dart';
import 'package:health_care/components/footer.dart';
import 'package:health_care/screens/all_ratings.dart';
import 'package:health_care/utils/config.dart';
import 'dart:math';

//import 'package:flutter_html/flutter_html.dart';
class ServicePage extends StatefulWidget {
  final Service service;
  ServicePage({required this.service});

  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  ServiceService serviceService = ServiceService();
  ServiceRating rating = ServiceRating(
    id: 0,
    countRating: 0,
    numberRating: 0,
    countDetails: RatingDetails(
      oneStar: 0,
      twoStar: 0,
      threeStar: 0,
      fourStar: 0,
      fiveStar: 0,
    ),
    ratings: [],
  );
  bool isExpanded = false;
  bool loading = true;
  void initState() {
    fetchServiceRating();
    super.initState();
  }

  void fetchServiceRating() async {
    try {
      loading = true;
      rating = await serviceService.fetchServiceRating(widget.service.id);
      // print(doctor.timeWork.times['monday']?.afternoon?.date);
      setState(() {
        loading = false;
      });
    } catch (e) {
      print('Error fetch service: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Color(0xFF59D4E9)),
      body: SingleChildScrollView(
        //padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                //borderRadius: BorderRadius.circular(40),
                image: DecorationImage(
                  image: NetworkImage(widget.service
                      .thumbnail), // Thay thế 'your_image.jpg' bằng đường dẫn đến hình ảnh của bạn
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Config.spaceSmall,
            Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.service.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Config.spaceSmall,
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money,
                            size: 16.0,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            'Giá dịch vụ: ' +
                                widget.service.price.toString() +
                                ' vnđ',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(
                            Icons.local_hospital,
                            size: 16.0,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            widget.service.hospital_name,
                            style: TextStyle(fontSize: 16.0),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(
                            Icons.visibility,
                            size: 16.0,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            widget.service.searchNumber.toString(),
                            style: TextStyle(fontSize: 16.0),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ])),
            Config.spaceSmall,
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TagContainer(tag: 'Thông tin về dịch vụ'),
                  SizedBox(height: 8.0),
                  Html(
                    data:
                        "<p><p style=' margin: 8px 0px 16px;  font-family: Inter, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Helvetica Neue&quot;, sans-serif; '>Quy trình đặt lịch thăm khám qua nền tảng Hello Bacsi:&nbsp;&nbsp;&nbsp;</p><p style=' margin: 8px 0px 16px;  font-family: Inter, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Helvetica Neue&quot;, sans-serif; '>Bước 1: Quý bệnh nhân tiến hành chọn thời gian và đặt lịch khám trong khung 'Đặt lịch hẹn'.&nbsp;&nbsp;</p><p style=' margin: 8px 0px 16px;  font-family: Inter, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Helvetica Neue&quot;, sans-serif; '>Bước 2: Sau khi hoàn tất đặt lịch, Hello Bacsi sẽ gửi email xác nhận thông tin lịch hẹn khám cho bệnh nhân.&nbsp;</p><p style=' margin: 8px 0px 16px;  font-family: Inter, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Helvetica Neue&quot;, sans-serif; '>Bước 3: Bệnh nhân đến bệnh viện/phòng khám theo lịch hẹn, đưa email xác nhận cho đội ngũ lễ tân/y tá và tiến hành thăm khám.</p><br /></p>",
                  ),
                  Html(data: widget.service.infor.aboutService
                      //data: "<p>hello<hello/p>",
                      //data: "<p> <p data-size='base' data-type='regular' class='wIj6fkD ' style='  font-family: Inter, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Helvetica Neue&quot;, sans-serif; '> <span >Nội soi đại tràng là thủ thuật nhằm mục đích hỗ trợ các y bác sĩ quan sát toàn bộ chiều dài của đại tràng và trực tràng, tầm soát các bất thường trong ruột cũng như khối u thịt nhỏ nằm trên thành đại tràng.<br /><br />Bệnh nhân có thể tiến hành nội soi đại tràng nhằm mục đích tìm kiếm nguyên nhân các dấu hiệu và triệu chứng đường ruột, tầm soát ung thư đại tràng, xem xét bệnh nhân có polyp đại tràng hay không.</span> </p> <p data-size='base' data-type='regular' class='wIj6fkD ' style='  font-family: Inter, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Helvetica Neue&quot;, sans-serif; '> <span ><br />Quá trình nội soi đại tràng thường mất khoảng từ 30 - 45 phút. Các bác sĩ sẽ đưa một ống nhựa dẻo có gắn camera và đèn vào hậu môn, quan sát các cấu trúc bên trong ruột cũng như tìm kiếm các tổn thương như viêm hoặc polyp.</span> </p><br /></p>",
                      //data: '<h2>Răng số 7 bị nhổ trong trường hợp nào? Nhổ răng số 7 có nguy hiểm không?&nbsp;</h2><p><img src="https://cdn.hellobacsi.com/wp-content/uploads/2023/10/nho-rang-so-7-co-nguy-hiem-khong-1.jpg"></p><h3>1. Răng số 7 bị nhổ trong trường hợp nào?</h3><p>Mặc dù gây ra ảnh hưởng không nhỏ đến sức khỏe khỏe miệng tổng thể nhưng răng số 7 vẫn được cân nhắc loại bỏ khi xuất hiện các tình trạng sau:&nbsp;</p><ul><li>Sâu răng nặng dẫn đến tình trạng không có đủ mô răng khỏe mạnh để có thể phục hồi dưới bất kỳ hình thức nào.</li><li>Vùng răng số 7 bị&nbsp;<a href="https://hellobacsi.com/suc-khoe-rang-mieng/viem-nuou-nha-chu/tat-ca-nhung-dieu-ban-can-biet-ve-benh-viem-nha-chu/" rel="noopener noreferrer" target="_blank" style="color: rgb(45, 135, 243);">viêm nha chu</a>, viêm chóp hoặc viêm xương, nhưng không thể điều trị dứt điểm bằng phương pháp nội nha.&nbsp;</li><li>Thân răng số 7 bị gãy do sâu răng hoặc chấn thương, nhưng vẫn còn chân răng, tăng nguy cơ nhiễm trùng và gây đau đớn. Khi đó, nhổ răng và lấy hoàn toàn chân răng ra ngoài là giải pháp duy nhất được lựa chọn.&nbsp;</li><li>Răng số 7 bị sưng nướu,&nbsp;<a href="https://hellobacsi.com/suc-khoe-rang-mieng/van-de-ve-rang/viem-tuy-rang/" rel="noopener noreferrer" target="_blank" style="color: rgb(45, 135, 243);">viêm tủy răng</a>&nbsp;và xuất hiện các triệu chứng tiêu xương hàm.</li><li>Răng có liên quan đến bệnh lý như u nang hàm hoặc khối u ác tính và có thể được chỉ định nhổ bỏ.</li><li>Một số trường hợp xạ trị do ung thư sẽ được yêu cầu đánh giá nha khoa trước khi thực hiện, nhằm xác định những chiếc răng có tiên lượng xấu hoặc có nguy cơ gây nhiễm trùng trong tương lai gần. Khi đó, nhổ răng là chỉ định cần thiết, vì chiếu xạ có thể gia tăng nguy cơ xương hàm bị hoại tử.&nbsp;</li></ul><p><br></p>",
                      ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TagContainer(tag: 'Chi tiết dịch vụ'),
                  SizedBox(height: 8.0),
                  Html(
                    data: widget.service.infor.serviceDetails,
                    //data: "<p>Hello word</p>"),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TagContainer(tag: 'Quá trình chuẩn bị'),
                  SizedBox(height: 8.0),
                  Html(
                      //data: "<p>Hello word</p>"
                      data: widget.service.infor.prepareProcess),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //TagContainer(tag: 'Đánh giá khách hàng'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TagContainer(tag: 'Đánh giá khách hàng'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllRatingPage(
                                    api:
                                        'api/hospital-service/more-rating/${widget.service.id.toString()}'),
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
                    // loading == false
                    //     ?
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(5, (index) {
                                if (index < rating.numberRating) {
                                  return Icon(Icons.star, color: Colors.yellow);
                                } else {
                                  return Icon(Icons.star, color: Colors.grey);
                                }
                              }),
                            ),
                            SizedBox(width: 16.0),
                            Text('(' +
                                rating.countRating.toString() +
                                ' đánh giá)')
                          ]),
                          SizedBox(height: 16.0),
                          rating.ratings.length != 0
                              ? ListView.builder(
                                  itemCount: isExpanded
                                      ? rating.ratings.length
                                      : min(
                                          3,
                                          rating.ratings
                                              .length), // Show only one item initially
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return RatingComponent(
                                        rating: rating.ratings[index]);
                                  },
                                )
                              : Center(
                                  child: Text('Chưa có đánh giá nào'),
                                )
                        ])
                    // : Center(
                    //     child: CircularProgressIndicator(),
                    //   )
                  ]),
            ),
            Center(
              child: BookingForm(
                id: widget.service.id,
                name: widget.service.name,
                hospitalName: widget.service.hospital_name,
                bookingType: 'service',
              ),
            ),
            Config.spaceSmall,
            Footer()
          ],
        ),
      ),
    );
  }
}
