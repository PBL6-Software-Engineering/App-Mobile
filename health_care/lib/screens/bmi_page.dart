import 'package:flutter/material.dart';
import 'package:health_care/screens/bmi_result_page.dart';
import 'package:health_care/utils/config.dart';
class BMIPage extends StatefulWidget {
  const BMIPage({super.key});
  @override
  _BMIPageState createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  // Biến để lưu trữ dữ liệu người dùng nhập vào
   String ? selectedGender;
   int ? age;
   double ? height;
   double ? weight;
   String ? selectedExerciseIntensity;
   bool _validateFields() {
  if (selectedGender == null ||
      age == null ||
      height == null ||
      weight == null ||
      selectedExerciseIntensity == null) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text('Vui lòng điền đầy đủ các trường'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
    return false;
  }
  return true;
}
  void calculateBMI() {
    if (_validateFields()) {
  if (height != null && weight != null) {
    double heightInMeter = height! / 100;
    
    double bmi = weight! / (heightInMeter * heightInMeter);
    
    List<String> advice =[];
    if (bmi < 18.5) {
      advice.add('Thiếu cân');
      advice.add('Các nghiên cứu chỉ ra rằng nững người bị thiếu cân nặng có nguy cơ bị suy dinh dưỡng cao hơn, khả năng miễn dịch giảm, bị vô sinh, loãng xương, vết thương lâu lành và dễ gặp các biến chứng sau phẫu thuật.');
    } else if (bmi < 23) {
      advice.add('Khoẻ mạnh');
      advice.add('Ngay cả những người có chỉ số BMI khỏe mạnh cũng có thể đứng trước nguy cơ mắc một số tình trạng sức khoẻ. Vì vậy, điều quan trọng là cần xây dựng một lối sống lành mạnh thông qua chế độ ăn uống thích hợp, vận động hợp lý và khám sức khỏe định kỳ để duy trì sức khỏe tốt nhất có thể.');
    } else if (bmi < 25) {
      advice.add('Thừa cân');
      advice.add('Thừa cân có thể làm tăng nguy cơ tiến triển bệnh tiểu đường týp 2, tăng huyết áp, bệnh tim mạch, đột quỵ, viêm xương khớp, bệnh gan nhiễm mỡ, bệnh thận và một số bệnh ung thư.');
    }else if (bmi < 30) {
      advice.add('Béo phì mức độ 1');
      advice.add('Béo phì có thể làm tăng nguy cơ tiến triển bệnh tiểu đường týp 2, tăng huyết áp, bệnh tim mạch, đột quỵ, viêm xương khớp, bệnh gan nhiễm mỡ, bệnh thận và một số bệnh ung thư.');
    } else {
      advice.add('Béo phì mức độ 2');
      advice.add('Thừa cân có thể làm tăng nguy cơ tiến triển bệnh tiểu đường týp 2, tăng huyết áp, bệnh tim mạch, đột quỵ, viêm xương khớp, bệnh gan nhiễm mỡ, bệnh thận và một số bệnh ung thư.');
    }
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BMIResultPage(bmi: bmi, advice: advice),
    )
    );

    
    // Hiển thị hộp thoại với chỉ số BMI và lời khuyên
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text('Chỉ số BMI của bạn'),
    //       content: Text('Chỉ số BMI: ${bmi.toStringAsFixed(1)}\n \nLời khuyên dành cho bạn: $advice'),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           child: Text('Đóng'),
    //         ),
    //       ],
    //     );
    //   },
    // );
    }
    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tính chỉ số BMI'),
        backgroundColor: Config.blueColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Chọn giới tính',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = 'Nam';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedGender == 'Nam'
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(children: [
                            Icon(Icons.male, color: Colors.blue
                            ,),
                            Text('Nam')],
                            )
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = 'Nữ';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedGender == 'Nữ'
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(children: [
                            Icon(Icons.female, color: Colors.pink),
                            Text('Nữ')],
                        ),
                      ),
                    ),
                  ),
                ),
                )
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Tuổi',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  age = int.tryParse(value);
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Chiều cao (cm)',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  height = double.tryParse(value);
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Cân nặng (kg)',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  weight = double.tryParse(value);
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Cường độ tập thể dục',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            DropdownButtonFormField<String>(
              value: selectedExerciseIntensity,
              onChanged: (value) {
                setState(() {
                  selectedExerciseIntensity = value;
                });
              },
              items: ['Ít hoặc không tập thể dục', 'Tập thể dục nhẹ 1-3 ngày mỗi tuần', 'Tập thể dục trung bình 3-5 ngày mỗi tuần','Tập thể dục nặng 6-7 ngày mỗi tuần','Chế độ tập thể dục thách thức'].map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed:  calculateBMI,
              
              child: Text('Tính ngay'),
            ),
          ],
        ),
      ),
    );
  }
}