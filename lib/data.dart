import 'package:get_storage/get_storage.dart';

class TempData {
  final List<Map<String, dynamic>> userList = [
    {
      'name': 'Alice Johnson',
      'email': 'alice.johnson@example.com',
      'password': 'alice123'
    },
    {'name': 'smith', 'email': 'bob.smith@example.com', 'password': 'bob123'},
    {
      'name': 'Charlie Brown',
      'email': 'charlie.brown@example.com',
      'password': 'charlie123'
    },
    {
      'name': 'smith',
      'email': 'diana.prince@example.com',
      'password': 'diana123'
    },
    {
      'name': 'Ethan Hunt',
      'email': 'ethan.hunt@example.com',
      'password': 'ethan123'
    }
  ];
}

class LocalDB {
  final _db=GetStorage();
  writeProfileData(Map<String,dynamic> data){
    _db.write("Profile", data);
  }
  Map<String,dynamic> readProfileData(){
   return _db.read("Profile") as Map<String,dynamic>;
  }


}