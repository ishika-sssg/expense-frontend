import 'package:dio/dio.dart';
import 'package:frontend/repository/models/all_groups_data.dart';
import '../dio.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';
import 'dart:convert';
import 'dart:io';


class GroupDetails {
  final Api api = Api();
  final AuthStorage _authStorage = AuthStorage();
  final String Base_url = Platform.isAndroid ? "http://10.0.2.2:8080" : "http://localhost:8080";

  // Future<dynamic> getGroupsByUserid() async {
  Future<AllGroupsData> getGroupsByUserid() async {

    print("first of all calling api here");

    try {

      print("my url, ${Base_url}");
      // Response getUserInfo = await _authStorage.retrieveData();
      final userInfo = await _authStorage.retrieveData();
      var mytoken = await _authStorage.getToken('token');
      var user_id = userInfo['user_id'];
      Response res =
          await api.dio.get('${Base_url}/group/all/$user_id',
              options: Options(
                headers: {'Authorization': 'Bearer $mytoken'},
              ));



      final result = res.data as Map<String, dynamic>;


      return AllGroupsData.fromJson(result);




      // Map<dynamic, dynamic> apiResponse = jsonDecode(result);
      // print("in map format $apiResponse");


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
        final error = e.response?.data;
        print('error from catch block $e');
        // return 'Error: $e';
        return error;
      }
    }
  }

  Future<dynamic> createGroup(
      String group_name, String description, String category) async {
    try {
      final userInfo = await _authStorage.retrieveData();
      var mytoken = await _authStorage.getToken('token');

      Response res = await api.dio.post('${Base_url}/group',
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
        '${Base_url}/group/add_group_member',
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
        '${Base_url}/group/get_allmembers/$group_id',
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
        '${Base_url}/group/delete/group_id/$group_id/member_id/$member_id/group_admin_id/$group_admin_id/loggedin_userid/$user_id',
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
        '${Base_url}/expense/allexpenses/$group_id/user_id/$user_id',
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
      '${Base_url}/expense/expensedata/group_id/$group_id/user_id/$user_id',
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


