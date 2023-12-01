 import 'package:flutter_test/flutter_test.dart';
 import 'package:flutter/material.dart';
 import 'package:health_care/main.dart';
 import 'package:http/http.dart' as http;
 import 'dart:convert';
import 'package:health_care/objects/user.dart';
import 'package:flutter/services.dart';

// import 'package:flutter/material.dart';
// import 'package:health_care/components/Button.dart';
import 'package:health_care/components/login_form.dart';
import 'package:health_care/components/custom_text_field.dart';
import 'package:health_care/main_layout.dart';

void main() {
  testWidgets('Edit User Info Test', (WidgetTester tester) async {
    tester.view.physicalSize = Size(1600, 720);
    tester.view.devicePixelRatio = 274;
    // tester.binding.window.devicePixelRatioTestValue = 274;
    print("Open app");
    await tester.pumpWidget(MyApp());
    //await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text('Đăng nhập'), findsOneWidget);
    //debugDumpApp();
    //await expectLater(find.byType(MyApp), matchesGoldenFile('golden/edit_user_info_test.png'));

    print("Enter email and password");
    await tester.enterText(find.byKey(ValueKey('emailField')), 'quoctran1122@yopmail.com');
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(ValueKey('passwordField')), '123456');
    await tester.pumpAndSettle();
    expect(tester.getSemantics(find.text('quoctran1122@yopmail.com')), isNotNull);


    // final loginFormFinder = find.byType(LoginForm);
    // final buttonFinder = find.descendant(
    //   of: loginFormFinder,
    //   matching: find.byKey(ValueKey('loginButton')),
    // );
    print("Click Login");
    final buttonFinder = find.byKey(ValueKey('loginButton'));
    //await tester.tap(buttonFinder);
    //await tester.tapAt(Offset(15.0, 1410.0));
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    //await tester.pumpAndSettle(Duration(seconds: 5));
    await tester.pumpAndSettle();
 

    expect(find.text('Đăng nhập'), findsOneWidget);
     //await tester.tap(find.byIcon(Icons.settings));
    // await tester.tap(find.widgetWithText(BottomNavigationBarItem, 'Cài đặt'));
    // await tester.pumpAndSettle();
    // print('Click Setting');

    // final personalInfoTextFinder = find.text('Thông tin cá nhân');
    // await tester.tap(personalInfoTextFinder);
    // await tester.pump();
    // // Kiểm tra xem đã chuyển sang trang user_info.page hay chưa
    // final userInfoPageFinder = find.widgetWithText(AppBar, 'Thông tin cá nhân');
    // expect(userInfoPageFinder, findsOneWidget);
    // print("Click Infor User");

  //   // Tìm và tap vào button "Chỉnh sửa thông tin"
  //   final editButtonFinder = find.text('Chỉnh sửa thông tin');
  //   await tester.tap(editButtonFinder);
  //   await tester.pump();

  //   // Kiểm tra xem đã hiển thị form chỉnh sửa thông tin hay chưa
  //   //final editFormFinder = find.text('Chỉnh sửa thông tin');
  //   final editFormFinder = find.byWidgetPredicate((widget) => widget is TextField);
  //   expect(editFormFinder, findsOneWidget);

  //   // Nhập thông tin cần chỉnh sửa vào các trường
  //   final nameFieldFinder = find.byWidgetPredicate((widget) =>
  //   widget is TextField && widget.decoration?.labelText == 'Tên');
  //   await tester.tap(nameFieldFinder);
  //   await tester.enterText(nameFieldFinder, 'John Doe');

  //   final phoneFieldFinder = find.byWidgetPredicate((widget) =>
  //   widget is TextField && widget.decoration?.labelText == 'Số điện thoại');
  //   await tester.tap(phoneFieldFinder);
  //   await tester.enterText(phoneFieldFinder, '1234567890');

  //   final addressFieldFinder = find.byWidgetPredicate((widget) =>
  //   widget is TextField && widget.decoration?.labelText == 'Địa chỉ');
  //   await tester.tap(addressFieldFinder);
  //   await tester.enterText(addressFieldFinder, '123 Main Street');

  //   // Chọn giá trị trong dropdown (ví dụ: "Male")
  //   final genderFinder = find.byType(DropdownButtonFormField);
  //   await tester.tap(genderFinder);
  //   final genderItenFinder = find.text("Nữ");
  //   await tester.tap(genderItenFinder);

  //   await tester.pumpAndSettle();

  //   final dobFieldFinder = find.byWidgetPredicate((widget) =>
  //   widget is TextField && widget.decoration?.labelText == 'Ngày sinh');
  //   await tester.tap(dobFieldFinder);
  //   //await tester.clearText(dobFieldFinder);
  //   await tester.enterText(dobFieldFinder, '01/01/1990');

  //   // Tìm và tap vào button "Lưu thay đổi"
  //   final saveButtonFinder = find.text('Lưu thay đổi');
  //   await tester.tap(saveButtonFinder);
  //   await tester.pump();

  //   // Kiểm tra xem đã hiển thị thông báo hay chưa
  //   final successMessageFinder = find.text('thành công');
  //   expect(successMessageFinder, findsOneWidget);
   }); 
}