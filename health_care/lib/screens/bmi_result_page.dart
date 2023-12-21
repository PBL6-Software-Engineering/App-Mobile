import 'package:flutter/material.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/components/Tag.dart';
class BMIResultPage extends StatelessWidget {
  final double bmi;
  final List<String> advice;

  BMIResultPage({required this.bmi, required this.advice});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        title: Text('Kết quả'),
        backgroundColor: Config.blueColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding (
        padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('(*) Công cụ này chỉ mang tính chất tham khảo thông tin, không thay thế cho việc chẩn đoán hoặc điều trị y khoa. Hãy tham vấn thêm ý kiến bác sĩ bên cạnh việc tìm kiếm phương pháp điều trị trên trang chúng tôi. Nếu bạn bị rối loạn ăn uống, kết quả tính chỉ số BMI sẽ không chính xác. Xin vui lòng liên hệ các chuyên gia y tế để được tư vấn thêm.', style: TextStyle(
                                                fontSize: 16.0,
                                                fontStyle: FontStyle.italic,
                                              ),),
          SizedBox(height: 16),
          TagContainer(tag: "Chỉ số BMI"),
          SizedBox(height: 8),
          Text('Chỉ số BMI của bạn là ${bmi.toStringAsFixed(1)}.', style: TextStyle(fontSize: 16.0)),
          SizedBox(height: 16),
          TagContainer(tag: "Tình trạng"),
          SizedBox(height: 8),
          Text('Chỉ số BMI của bạn cho thấy bạn đang ở tình trạng ${advice[0]}',style: TextStyle(fontSize: 16.0)),
          SizedBox(height: 16),
          TagContainer(tag: "Nguy cơ"),
          SizedBox(height: 8),
          Text(advice[1], style: TextStyle(fontSize: 16.0)),
          SizedBox(height: 16),
          TagContainer(tag: "Duy trì cân nặng lí tưởng"),
          SizedBox(height: 8),
          Text('Nếu bạn muốn duy trì trọng lượng cơ thể, đầu tiên hãy xác định bạn cần bao nhiêu calo mỗi ngày để thực hiện các chức năng cơ bản và các hoạt động hàng ngày của cơ thể.Chọn các thực phẩm và đồ uống cung cấp một lượng calo tương đương với nhu cầu calo hàng ngày của bạn. Ví dụ: Nếu nhu cầu calo hàng ngày của bạn là 1950 kcal, bạn cần tiêu thụ tổng cộng 1950 kcal mỗi ngày để duy trì cân nặng của mình.', style: TextStyle(fontSize: 16.0)),

        ],)
      )
    );

  }

  // ...
}