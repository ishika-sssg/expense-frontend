import 'package:dio/dio.dart';
import './auth_storage.dart';
import '../dio.dart';


class AuthApi {
  // final Dio _dio = Dio();
  final Api api = Api();


  // _dio.interceptors.add(LogInterceptor());
final AuthStorage _authStorage = AuthStorage();


  Future<dynamic> registerUser(String username, String email,
      String password) async {
    try {
      Response response = await api.dio.post(
        'http://localhost:8080/auth/register',
        data: {
          'name': username,
          'email': email,
          'password': password
        },
      );
      // return response.data;
      var responseData = response.data;
      print('from api call $responseData');
      // return responseData;

      if (response.statusCode == 200) {
        // print("from api call $res");
        return responseData;
      } else {
        // return 'Error: ${response.statusCode}';
        return responseData;
      }

    } on DioException catch (e) {
      // return e.response!.data;
      if (e.response != null) {
        // Server error
        print('from dio exception $e');
        var err = e.response?.data;
        // return 'Error: ${e.response?.data['error'] ?? 'Unknown error'}';
        return err;

      } else {
        // Network error
        print('error from catch block $e');
        return 'Error: $e';
      }
    }
  }


//   login api :
  Future<dynamic> loginUser(String email, String password) async {
    try {
      Response res = await api.dio.post(
          'http://localhost:8080/auth/login',
        // 'http://10.0.2.2:43802/auth/login',
          data: {
            'email': email,
            'password': password
          }
      );
      if (res.statusCode == 200) {
        // print("from api call $res");
        var responseData = res.data;
        var info = responseData['data'];
        // store token :
        var val = await _authStorage.saveToken("token", info['token']);
        // print(info['user']['user_name']);
        var save_details = await _authStorage.storeData(info['user']['ID'] , info['user']['user_name'], info['user']['email']);
        // print('saved $save_details');
        return responseData;
      } else {
        return 'Error: ${res.statusCode}';
      }
    } on DioException catch (err) {
      print('DioError: ${err.response?.data}');
      return err.response?.data ?? 'Unknown error';
    } catch (err) {
      print('from catch block $err');
      return 'An error occurred';
    }

  }
}