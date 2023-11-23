import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/objects/services.dart';
import 'package:health_care/main_layout.dart';
import 'package:flutter_html/flutter_html.dart';
//import 'package:flutter_html/flutter_html.dart';

class ServicePage extends StatelessWidget {
  final Service service;

  ServicePage({required this.service});

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
          backgroundColor: Color(0xFF59D4E9)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                    image: NetworkImage(service
                        .thumbnail), // Thay thế 'your_image.jpg' bằng đường dẫn đến hình ảnh của bạn
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                service.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.attach_money,
                    size: 16.0,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    'Giá dịch vụ: ' + service.price.toString() + ' vnđ',
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
                    service.hospital_name,
                    style: TextStyle(fontSize: 16.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thông tin về dịch vụ',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Html(
                      data: service.infor.aboutService
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
                    Text(
                      'Quá trình chuẩn bị',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Html(//data: "<p>Hello word</p>"
                        data: service.infor.prepareProcess
                        ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chi tiết dịch vụ',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Html(
                        data: service.infor.serviceDetails,
                        //data: "<p>Hello word</p>"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
