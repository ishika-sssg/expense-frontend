import 'package:dio/dio.dart';
import '../dio.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';
import 'dart:convert';

class GroupDetails {
  final Api api = Api();
  final AuthStorage _authStorage = AuthStorage();

  Future<dynamic> getGroupsByUserid() async {
    try {
      // Response getUserInfo = await _authStorage.retrieveData();
      final userInfo = await _authStorage.retrieveData();

      var mytoken = await _authStorage.getToken('token');
      // print("this is my token $mytoken");

      var user_id = userInfo['user_id'];
      // print("my user id $user_id");

      Response res =
          await api.dio.get('http://localhost:8080/group/all/$user_id',
              options: Options(
                headers: {'Authorization': 'Bearer $mytoken'},
              ));
      var result = res.data;

      // Map<dynamic, dynamic> apiResponse = jsonDecode(result);
      // print("in map format $apiResponse");

      print("original format $result");
      final Map<String, dynamic> allData = result;
      print(allData);
      var data = allData['data'];
      var a = data['alldata'];
      print('my array $a');
      // final Map parsed = json.decode(result);
      // print('from map $parsed');

      return allData;
    } on DioException catch (e) {
      // return e.response!.data;
      if (e.response != null) {
        // Server error
        print('from dio exception $e');
        var err = e.response?.data;
        print('from api $err');
        // return 'Error: ${e.response?.data['error'] ?? 'Unknown error'}';
        return err;
      } else {
        // Network error
        print('error from catch block $e');
        return 'Error: $e';
      }
    }
  }

  Future<dynamic> createGroup(
      String group_name, String description, String category) async {
    try {
      final userInfo = await _authStorage.retrieveData();
      var mytoken = await _authStorage.getToken('token');

      Response res = await api.dio.post('http://localhost:8080/group',
          options: Options(
            headers: {'Authorization': 'Bearer $mytoken'},
          ),
          data: {
            'group_name': group_name,
            'description': description,
            'category': category,
            'Group_admin_id': userInfo['user_id']
          });
      var result = res.data;
      final Map<String, dynamic> allData = result;
      // print(allData);
      return allData;
    } on DioException catch (e) {
      if (e.response != null) {
        // Server error
        print('from dio exception ${e.response}');
        var err = e.response;
        print('from api the error is $err');
        return err;
      } else {
        // Network error
        print('error from catch block $e');
        return 'Error: $e';
      }
    }
  }

  Future<dynamic> addMemberByEmailApi(
      String member_email, String group_id) async {
    print('api called');
    print('data ${member_email}, ${int.parse(group_id)}');
    try {
      final userInfo = await _authStorage.retrieveData();
      var mytoken = await _authStorage.getToken('token');
      Response res = await api.dio.post(
        'http://localhost:8080/group/add_group_member',
        options: Options(
          headers: {'Authorization': 'Bearer $mytoken'},
          validateStatus: (status) {
            // Accept all status codes to handle them manually
            return status != null && status < 500;
          },
        ),
        data: {
          'member_email': member_email,
          'groupId': int.parse(group_id),
        },
      );
      var result = res.data;

      final Map<String, dynamic> allData = result;

      // if (res.statusCode == 409) {
      //   // Handle the case where the member already exists
      //   print('Member already exists in the group.');
      //  return  allData;
      //   // You can display a message in the UI using a SnackBar, Dialog, etc.
      // } else if (res.statusCode == 200) {
      //   // Handle success
      //   print('Member added successfully.');
      //   return allData;
      // } else {
      //   // Handle other status codes if necessary
      //   print('Unexpected response: ${res.statusCode}');
      //   return allData;
      // }

      // print("result after calling api");
      // print(allData);
      return allData;
    } on DioException catch (e) {
      if (e.response != null) {
        // Server error
        print('from dio exception ${e.response}');
        var err = e.response;
        print('from api the error is $err');
        return err;
      } else {
        // Network error
        print('error from catch block $e');
        return 'Error: $e';
      }
    }
  }

  //api to get all members of a group:
  Future<dynamic> getAllMembersOfGroupApi(String group_id) async {
    try {
      final userInfo = await _authStorage.retrieveData();
      var mytoken = await _authStorage.getToken('token');

      Response res = await api.dio.get(
        'http://localhost:8080/group/get_allmembers/$group_id',
        options: Options(
          headers: {'Authorization': 'Bearer $mytoken'},
          validateStatus: (status) {
            // Accept all status codes to handle them manually
            return status != null && status < 500;
          },
        ),
      );
      var result = res.data;
      print('respons efrom api is $result');
      final Map<String, dynamic> allData = result;
      return allData;
    } on DioException catch (e) {
      if (e.response != null) {
        // Server error
        print('from dio exception ${e.response}');
        var err = e.response;
        print('from api the error is $err');
        return err;
      } else {
        // Network error
        print('error from catch block $e');
        return 'Error: $e';
      }
    }
  }


//   api to delete member from a group
Future<dynamic> deleteMemberFromGroupApi(String group_id, String member_id, String group_admin_id) async{
    try{
      final userInfo = await _authStorage.retrieveData();
      final user_id = userInfo["user_id"];
      var mytoken = await _authStorage.getToken('token');

      Response res = await api.dio.delete(
        'http://localhost:8080/group/delete/group_id/$group_id/member_id/$member_id/group_admin_id/$group_admin_id/loggedin_userid/$user_id',
        options: Options(
          headers: {'Authorization': 'Bearer $mytoken'},
          validateStatus: (status) {
            // Accept all status codes to handle them manually
            return status != null && status < 500;
          },
        ),

      );

      var result = res.data;
      print('response from api is $result');
      final Map<String, dynamic> allData = result;
      return allData;



    }on DioException catch (e) {
      if (e.response != null) {
        // Server error
        print('from dio exception ${e.response}');
        var err = e.response;
        print('from api the error is $err');
        return err;
      } else {
        // Network error
        print('error from catch block $e');
        return 'Error: $e';
      }
    }

}

// api to get all expenses by group id
  Future <dynamic> getAllExpensesByGroupApi(String group_id, String user_id)async{

    try {
      var mytoken = await _authStorage.getToken('token');

      Response res = await api.dio.get(
        'http://localhost:8080/expense/allexpenses/$group_id/user_id/$user_id',
        options: Options(
          headers: {'Authorization': 'Bearer $mytoken'},
          validateStatus: (status) {
            // Accept all status codes to handle them manually
            return status != null && status < 500;
          },
        ),
      );
      var result = res.data;
      print('response from api is $result');
      final Map<String, dynamic> allData = result;
      return allData;
    } on DioException catch (e) {
      if (e.response != null) {
        // Server error
        print('from dio exception ${e.response}');
        var err = e.response;
        return err;
      } else {
        // Network error
        print('error from catch block $e');
        return 'Error: $e';
      }
    }

  }

// api to get summary if all expenses in a group:
Future <dynamic> getExpenseSummaryOfGroupApi(String group_id, String user_id) async{

  try {
    var mytoken = await _authStorage.getToken('token');

    Response res = await api.dio.get(
      'http://localhost:8080/expense/expensedata/group_id/$group_id/user_id/$user_id',
      options: Options(
        headers: {'Authorization': 'Bearer $mytoken'},
        validateStatus: (status) {
          // Accept all status codes to handle them manually
          return status != null && status < 500;
        },
      ),
    );
    var result = res.data;
    print('response from api is $result');
    final Map<String, dynamic> allData = result;
    return allData;
  } on DioException catch (e) {
    if (e.response != null) {
      // Server error
      print('from dio exception ${e.response}');
      var err = e.response;
      return err;
    } else {
      // Network error
      print('error from catch block $e');
      return 'Error: $e';
    }
  }



}



}


