import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:health_care/components/search_form.dart';
import 'package:health_care/objects/location.dart';
import 'package:health_care/providers/http_provider.dart';
import 'package:health_care/screens/doctor_page.dart';
import 'package:health_care/screens/hospital_page.dart';
import 'package:health_care/utils/config.dart';

class BookingSearchPage extends StatefulWidget {
  @override
  _BookingSearchPageState createState() => _BookingSearchPageState();
}

class _BookingSearchPageState extends State<BookingSearchPage> {
  final String _url = HttpProvider.url;
  Location? selectedLocation;
  int? selectedId;
  TextEditingController _searchController = TextEditingController();
  final _userEditTextController = TextEditingController();

  // final List<Map<String, dynamic>> _categories = [
  //   {'id': 'departments', 'label': 'Chuyên khoa', 'icon': Icons.category},
  //   {
  //     'id': 'services',
  //     'label': 'Dịch vụ',
  //     'icon': Icons.medical_services,
  //   },
  //   {
  //     'id': 'hospitals',
  //     'label': 'Bệnh viện và phòng khám',
  //     'icon': Icons.local_hospital,
  //   },
  //   {'id': 'doctors', 'label': 'Bác sĩ', 'icon': Icons.person},
  // ];

  Map<String, List<Map<String, dynamic>>> categoryResults = {
    'departments': [],
    'services': [],
    'hospitals': [],
    'doctors': [],
  };

  List<Location> locations = [];

  @override
  void initState() {
    super.initState();
    fetchLocationData();
  }

  Future<void> fetchLocationData() async {
    try {
      locations = await LocationService().fetchLocation('api/province');
      if (locations.isNotEmpty) {
        setState(() {
          selectedLocation = locations.first;
          selectedId = selectedLocation?.provinceCode;
          print('selectedId ${selectedId}');
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchAll() async {
    if (selectedId == null) {
      return;
    }
    try {
      // Make an HTTP request based on the selected location's ID
      final response = await HttpProvider().getData(
        '/api/public/search-home?search=${_searchController.text ?? ' '}&province_code=${selectedId}',
      );

      final responseData = json.decode(response.body);
      final data = responseData['data'];

      if (data is Map<String, dynamic>) {
        setState(() {
          categoryResults['departments'] =
              (data['departments'] as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();
          categoryResults['services'] = (data['services'] as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();
          categoryResults['hospitals'] = (data['hospitals'] as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();
          categoryResults['doctors'] = (data['doctors'] as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Tìm kiếm',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        // Wrap the content with SingleChildScrollView
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              DropdownSearch<Location>(
                clearButtonProps: ClearButtonProps(isVisible: true),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    hintText: "Chọn tỉnh thành",
                  ),
                ),
                popupProps: PopupProps.menu(
                  showSelectedItems: false,
                  isFilterOnline: true,
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    controller: _userEditTextController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _userEditTextController.clear();
                        },
                      ),
                    ),
                  ),
                ),
                items: locations,
                itemAsString: (Location u) => u.name,
                onChanged: (Location? value) {
                  setState(() {
                    selectedLocation = value;
                    selectedId = value?.provinceCode;
                  });
                },
                selectedItem: selectedLocation,
              ),
              Config.spaceSmall,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: SearchInput(
                  hintText: 'Tìm kiếm',
                  controller: _searchController,
                  onSearch: fetchAll,
                ),
              ),
              Config.spaceSmall,
              Column(
                children: [
                  buildCategory(
                    icon: Icons.category,
                    label: 'Chuyên khoa',
                    getAll: () {
                      // Handle the getAll action here
                    },
                    getDetail: (int idx) {
                      // Handle the getAll action here
                    },
                    items: categoryResults['departments']!,
                  ),
                  buildCategory(
                    icon: Icons.medical_services,
                    label: 'Dịch vụ',
                    getAll: () {
                      // Handle the getAll action here
                    },
                    getDetail: (int idx) {
                      // Handle the getAll action here
                    },
                    items: categoryResults['services']!,
                    thumbnail: 'thumbnail_department',
                  ),
                  buildCategory(
                    icon: Icons.local_hospital,
                    label: 'Bệnh viện và phòng khám',
                    getAll: () {
                      // Handle the onAll action here
                    },
                    getDetail: (int idx) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HospitalPage(
                              id: categoryResults['hospitals']?[idx]['id']),
                        ),
                      );
                    },
                    items: categoryResults['hospitals']!,
                    thumbnail: 'avatar',
                  ),
                  buildCategory(
                    icon: Icons.person,
                    label: 'Bác sĩ',
                    getAll: () {
                      // Handle the onAll action here
                    },
                    getDetail: (int idx) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorPage(
                              id: categoryResults['doctors']?[idx]
                                  ['id_doctor']),
                        ),
                      );
                    },
                    items: categoryResults['doctors']!,
                    thumbnail: 'avatar',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategory({
    required IconData icon,
    required String label,
    required VoidCallback getAll,
    required Function(int) getDetail,
    required List<Map<String, dynamic>> items,
    String? thumbnail,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon),
                    SizedBox(width: 8),
                    Text(
                      label,
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                InkWell(
                  child: Text(
                    'Xem tất cả',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[300],
                    ),
                  ),
                  onTap: getAll,
                ),
              ],
            ),
          ),
        ),
        if (items.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, idx) {
              // Your custom list tile with a thumbnail
              return InkWell(
                onTap: () => getDetail(idx),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 25),
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(_url +
                              (items[idx][thumbnail] ??
                                  items[idx]["thumbnail"]))),
                      SizedBox(width: 20),
                      Text(items[idx]["name"]),
                    ],
                  ),
                ),
              );
            },
          )
        else
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 25),
            child: Text(
              'Không có kết quả',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
      ],
    );
  }
}
