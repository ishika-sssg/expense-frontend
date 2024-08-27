import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

 class AuthStorage{
  final _storage = const FlutterSecureStorage();

// save token :
Future <void> saveToken(String key, String token) async{
  await _storage.write(key : key, value : token);
}

// retrieve token with key
Future <String?> getToken(String key) async{
 return await _storage.read(key : key);
}

// delete token with specific key
Future <void> deleteToken(String key)async{
  await _storage.delete(key:key);
}

//delete all data :
Future<void> clearAll()async{
  await _storage.deleteAll();

  // Clear non-sensitive data from Shared Preferences
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user_id');
  await prefs.remove('user_name');
  await prefs.remove('user_email');
  await prefs.remove("isLoggedIn");

}

// save logged in user details in shared preferences :
   Future<dynamic> storeData(int userId, String user_name, String user_email, bool isLoggedIn) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     await prefs.setInt('user_id', userId);
     await prefs.setString('user_name', user_name);
     await prefs.setString('user_email', user_email);
     await prefs.setBool("isLoggedIn", isLoggedIn);

     return {
       'user_id': userId,
       'user_email': user_email,
       'user_name': user_name,
       "isLoggedIn" : isLoggedIn,
     };

   }


//    retrieve data from shared preferences :
 Future<dynamic> retrieveData() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   final user_id = prefs.getInt('user_id');
   final user_email = prefs.getString('user_email');
   final user_name = prefs.getString('user_name');

   // var userDetails = {
   //   'user_id': user_id,
   //   'user_email': user_email,
   //   'user_name': user_name,
   // };

   // return userDetails;



   return {
     'user_id': user_id,
     'user_email': user_email,
     'user_name': user_name,
   };

 }
}
