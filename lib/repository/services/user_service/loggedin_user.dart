import 'package:dio/dio.dart';
import '../auth_service/auth_storage.dart';
import '../dio.dart';


class LoggedinUser {
  // final Dio _dio = Dio();
  final Api api = Api();


  // _dio.interceptors.add(LogInterceptor());
  final AuthStorage _authStorage = AuthStorage();



//   login api :
  Future<dynamic> getLoggedinUserDetails() async {
    final token = await _authStorage.getToken('token');
    var us_name;


    try {
      Response res = await api.dio.get(
          'http://localhost:8080/auth/user/profile',
        options: Options(
          // headers: {'Authorization': 'Bearer $token'},
          headers: {'Cookie': 'Authorization=$token'},

        ),
      );

      if (res.statusCode == 200) {
        // print("from api call $res");
        var responseData = res.data;

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