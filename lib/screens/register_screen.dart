import 'package:flutter/material.dart';
import 'package:donghanh_flutter/widgets/CustomTextField.dart';
import 'package:donghanh_flutter/widgets/CustomPasswordField.dart';
import 'package:donghanh_flutter/widgets/CustomDropdownProvinceField.dart';
import 'package:donghanh_flutter/widgets/FormLayout.dart';
import 'package:donghanh_flutter/models/RegistrationFormModel.dart';
import 'package:donghanh_flutter/services/region_service.dart';
import 'package:donghanh_flutter/models/DropdownItemProvinceModel.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  String? _selectedCity, _selectedDistrict, _selectedWard;
  final _formKey = GlobalKey<FormState>();
  final RegionService _regionService = RegionService();

  // Sample dropdown values
  List<DropdownItemProvince> _cities = [];
  List<DropdownItemProvince> _districts = [];
  List<DropdownItemProvince> _wards = [];
  // Create an instance of the model
  final RegistrationFormModel _formModel = RegistrationFormModel(
    fullName: '',
    username: '',
    password: '',
    phoneNumber: '',
    address: '',
  );
  void initState() {
    super.initState();
    getDataProvince();
  }

  void getDataProvince() async {
    final response = await _regionService.getProvinceByRegion('DBSCL', 'VN');
    if (response['success']) {
        List<dynamic> dynamicCities = response['data'];        
           // Map dynamicCities to List<DropdownItemProvince>
        setState(() {
          _cities = dynamicCities.map((item) {
            return DropdownItemProvince(
              ProvinceName: item['ProvinceName'].toString(),
              ProvinceCode: item['ProvinceCode'].toString(), // or another field for value
            );
          }).toList();
        }); 
    }
  }
  
  void getDataDistrict() async{
    final response = await _regionService.getDetailProvinceByCode(_selectedCity.toString(), 'VN'); 
    if (response['success']) {
        List<dynamic> dynamicDistrict = response['data'];
      if (dynamicDistrict.isNotEmpty) {
        for (var city in dynamicDistrict) {
          if (city is Map<String, dynamic> &&
              city.containsKey('Child') &&
              city['Child'] != null) {
              List<dynamic> Districts = city['Child'];
              // Check if children list is not empty
              if (Districts.isNotEmpty) {
                   setState(() {
                  _districts = Districts.map((item) {
                    return DropdownItemProvince(
                      ProvinceName: item['ProvinceName'].toString(),
                      ProvinceCode: item['ProvinceCode'].toString(), // or another field for value                     
                    );
                  }).toList();
                }); 
              } else {
                print('No children found for this city.');
              }
          } else {
            print('This city does not have children.');
          }
        }
      }
    }
  }

  void getDataDetailWard() async{
    final response = await _regionService.getDetailProvinceByCode(_selectedDistrict.toString(), 'VN');    
    if (response['success']) {
       List<dynamic> dynamicWards = response['data'];
      if (dynamicWards.isNotEmpty) {
        for (var ward in dynamicWards) {
          if (ward is Map<String, dynamic> &&
              ward.containsKey('Child') &&
              ward['Child'] != null) {
              List<dynamic> Wards = ward['Child'];
              // Check if children list is not empty
              if (Wards.isNotEmpty) {
                   setState(() {
                  _wards = Wards.map((item) {
                    return DropdownItemProvince(
                      ProvinceName: item['ProvinceName'].toString(),
                      ProvinceCode: item['ProvinceCode'].toString(), // or another field for value                     
                    );
                  }).toList();
                }); 
              } else {
                print('No children found for this city.');
              }
          } else {
            print('This city does not have children.');
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: FormLayout(
          title: 'Đăng ký tài khoản', // Title of the form
          groupTitle: 'THÔNG TIN ĐĂNG KÝ',
          // Define form fields (e.g., TextFormFields, Dropdowns)
          formFields: [
            // Full Name Field
            CustomTextField(
              label: 'Họ tên',
              hintText: 'Nhập họ và tên',
              onSaved: (value) {
                _formModel.fullName = value!;
              },
            ),

            // Username Field
            CustomTextField(
              label: 'Tài khoản',
              hintText: 'Nhập tên tài khoản',
              onSaved: (value) {
                _formModel.username = value!;
              },
            ),

            // Password Field
            CustomPasswordField(label: 'Mật khẩu', defaultShowHide: true),

            // Confirm Password Field
            CustomPasswordField(label: 'Nhập lại', defaultShowHide: true),

            // Phone Number Field
            CustomTextField(
                label: 'Số điện thoại',
                hintText: 'Số điện thoại',
                keyboardType: TextInputType.phone),

            // City Dropdown
            CustomDropdownProvinceField(
              label: 'Tỉnh/Thành phố',
              value: _selectedCity,
              items: _cities,
              onChanged: (value) {
                setState(() {                  
                  _selectedCity = value;       
                  _selectedDistrict = null;
                  _districts=[];      
                  _selectedWard=null;
                  _wards=[];   
                });
                getDataDistrict();
              },
            ),

            // District Dropdown
            CustomDropdownProvinceField(
              label: 'Quận/Huyện',
              value: _selectedDistrict,
              items: _districts,
              onChanged: (value) { 
                _selectedWard=null;
                _wards=[];                 
                setState(() {
                  _selectedDistrict = value;
                });
                getDataDetailWard();
              },
            ),

            // Ward Dropdown
            CustomDropdownProvinceField(
              label: 'Phường/Xã',
              value: _selectedWard,
              items: _wards,
              onChanged: (value) {               
                setState(() {
                  _selectedWard = value;
                });
              },
            ),

            // Address Field
            CustomTextField(
                label: 'Địa chỉ', hintText: 'Nhập địa chỉ hiện tại'),

            SizedBox(height: 30),

            // You can add more fields like dropdowns for "Tỉnh/Thành phố" etc.
          ],

          // Define the action button (e.g., 'Register' button)
          actionButton: ElevatedButton(
            onPressed: () {
              // Handle form submission
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                _submitForm();
              }
            },
            child: Text(
              'ĐĂNG KÝ',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.lightBlue // Set full width and height
                ),
          ),
        ));
  }

  void _submitForm() {
    // Handle the form submission
    print('Form Submitted');
    print('Full Name: ${_formModel.fullName}');
    print('Username: ${_formModel.username}');
    print('Password: ${_formModel.password}');
    print('Phone Number: ${_formModel.phoneNumber}');
    print('Address: ${_formModel.address}');

    // You can now send the form data to an API, database, or other services.
  }
}

void main() {
  runApp(MaterialApp(home: RegistrationForm()));
}
