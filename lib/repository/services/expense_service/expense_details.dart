import 'package:dio/dio.dart';
import '../dio.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';
import 'dart:convert';
import 'package:frontend/repository/models/expense.dart';


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



}