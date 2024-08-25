import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/repository/models/member_expense.dart';
import '../dio.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';
import 'dart:convert';
import 'package:frontend/repository/models/expense.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';





class ExpenseDetails{
  final Api api = Api();
  final AuthStorage _authStorage = AuthStorage();

  Future<dynamic> createExpenseApi(Expense expense) async{

    try{
      var mytoken = await _authStorage.getToken('token');
      // Manually create the data map as per the required format
      Map<String, dynamic> data = {
        "expense_name": expense.expenseName,
        "expense_desc": expense.description,
        "amount": expense.amount,
        "group_id": int.parse(expense.group_id),
        "paid_by": expense.paidBy,
        "member_ids": expense.members,
      };

      Response res = await api.dio.post(
        'http://localhost:8080/expense/add',
          options: Options(
            headers: {'Authorization': 'Bearer $mytoken',
              'Content-Type': 'application/json',
            },
            validateStatus: (status) {
              // Accept all status codes to handle them manually
              return status != null && status < 500;
            },
          ),

        // data : data,
        //   data : json.encode(expense.toJson()),

          data : {
          "expense_name" : expense.expenseName,
            "expense_desc" : expense.description,
            "amount" : expense.amount,
            "group_id" : int.parse(expense.group_id),
            "paid_by" : expense.paidBy,
            "member_ids" : expense.members,

        }
      );

      print("api call res is first time $res");
      print(res.statusCode);
      var result = res.data;
      print('from api res is $result');
      final Map<String, dynamic> allData = result;
      print('from api, final res is $allData');
      return allData;


      //

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


  Future<dynamic> getAllUnsettledTransactionsApi(String group_id, String user_id) async{

    try{
      var mytoken = await _authStorage.getToken('token');
      // Manually create the data map as per the required format

      Response res = await api.dio.get(
        'http://localhost:8080/expense/unsettledtransactions/group_id/$group_id/user_id/$user_id',
          options: Options(
            headers: {'Authorization': 'Bearer $mytoken',
              'Content-Type': 'application/json',
            },
            validateStatus: (status) {
              // Accept all status codes to handle them manually
              return status != null && status < 500;
            },
          ),

      );

      print("api call res is first time $res");
      print(res.statusCode);
      var result = res.data;
      print('from api res is $result');
      final Map<String, dynamic> allData = result;
      print('from api, final res is $allData');
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


  Future <dynamic> SettleLoggedinUserTransactions(String trans_id, String user_id) async{

    try{
      var mytoken = await _authStorage.getToken('token');

      Response res = await api.dio.post(
        "http://localhost:8080/expense/settletransaction/transid/$trans_id/user_id/$user_id",
        options: Options(
          headers: {'Authorization': 'Bearer $mytoken',
            'Content-Type': 'application/json',
          },
          validateStatus: (status) {
            // Accept all status codes to handle them manually
            return status != null && status < 500;
          },
        ),

      );

      print("api call res is first time $res");
      print(res.statusCode);
      var result = res.data;
      print('from api res is $result');
      final Map<String, dynamic> allData = result;
      print('from api, final res is $allData');
      return allData;



    }on DioException catch (e) {
      if (e.response != null) {
        // Server error
        debugPrint('from dio exception ${e.response}');
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

  Future <dynamic> GetAllSettlementRecord(String user_id)async{

    try{
      var mytoken = await _authStorage.getToken('token');

      Response res = await api.dio.get(
        "http://localhost:8080/expense/allsettlements/user_id/$user_id",
        options: Options(
          headers: {'Authorization': 'Bearer $mytoken',
            'Content-Type': 'application/json',
          },
          validateStatus: (status) {
            // Accept all status codes to handle them manually
            return status != null && status < 500;
          },
        ),

      );

      print("api call res is first time $res");
      print(res.statusCode);
      var result = res.data;
      print('from api res is $result');
      final Map<String, dynamic> allData = result;
      print('from api, final res is $allData');
      return allData;



    }on DioException catch (e) {
      if (e.response != null) {
        // Server error
        debugPrint('from dio exception ${e.response}');
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


Future <MemberExpenseModal> GetExpensesMemberWise() async{
  try {
    // Response getUserInfo = await _authStorage.retrieveData();

    print("here in my api function to call api");
    print("calling api");
    final userInfo = await _authStorage.retrieveData();

    var mytoken = await _authStorage.getToken('token');
    var user_id = userInfo['user_id'].toString();
    Response res = await api.dio.get('http://localhost:8080/expense/members_expense/user_id/$user_id',
        options: Options(
          headers: {'Authorization': 'Bearer $mytoken'},
        ));
    // var result = res.data;


    // final result = res.data;
    final result = res.data as Map<String, dynamic>;


    print("from api the result is ${res.data}");

    // print(MemberExpense.fromJson(result));
    try {
      MemberExpenseModal myResponse = MemberExpenseModal.fromJson(res.data);
      return myResponse;

    }catch(err){
      print(err);

      throw err;
    }







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

  Future <void> DownloadCsvFile(String user_id) async{

    try{
      var mytoken = await _authStorage.getToken('token');

      Response res = await api.dio.get(
        'http://localhost:8080/expense/csv/settlerecord/user_id/$user_id',
        options: Options(
          headers: {'Authorization': 'Bearer $mytoken',
            // 'Content-Type': 'application/json',
             'responseType': ResponseType.bytes,

          },
          validateStatus: (status) {
            // Accept all status codes to handle them manually
            return status != null && status < 500;
          },
        ),

      );

      if (res.statusCode == 200) {
        // Get the directory to store the file
        Directory? directory;
        if (Platform.isAndroid) {
          // Use getExternalStorageDirectory() for Android
          directory = await getExternalStorageDirectory();
        } else if (Platform.isIOS || Platform.isMacOS) {
          // Use getApplicationDocumentsDirectory() for iOS/macOS
          directory = await getApplicationDocumentsDirectory();
        } else if (Platform.isWindows || Platform.isLinux) {
          // Use getApplicationDocumentsDirectory() for Windows/Linux
          directory = await getApplicationDocumentsDirectory();
        } else if (Platform.isFuchsia) {
          // Fuchsia may also use the application documents directory
          directory = await getApplicationDocumentsDirectory();
        } else {
          // Handle web or other platforms, or throw an error
          throw UnsupportedError("This platform is not supported.");
        }


        // final directory = await getExternalStorageDirectory();
        // String filePath = '${directory.path}/$fileName';

        final filePath = '${directory!.path}/report.csv';

        // Write the file to the device's storage
        final file = File(filePath);
        await file.writeAsString(res.data);

        print('File saved at $filePath');

        // Optionally open the file
        // openFile(filePath);
        // Open the file
        final result = await OpenFile.open(filePath);
        print('File opened: ${result.message}');

      } else {
        print('Failed to download file. Status code: ${res.statusCode}, res is $res');
      }
    }catch (e) {
      print('Error: $e');
    }

  }

  Future <void> RequestPermission(String user_id) async{
    final status = await Permission.storage.request();
    if (status.isGranted) {
      // Permission granted, proceed with download
      DownloadCsvFile(user_id);
    } else {
      // Permission denied
      print('Storage permission denied');
    }
  }

}