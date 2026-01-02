import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = Dio();
  // hàm trả về true hoặc false nếu thất bại khi đăng nhập
  Future<bool> login(String username, String password) async {
    try {
      final response = await _dio.post(
        'https://dummyjson.com/auth/login',
        data: {
          'username': username,
          'password': password,
          'expiresInMins': 40000, // tăng thời gian hết hạn token
        },
        options: Options(contentType: Headers.jsonContentType),
      );

      // 
      if (response.statusCode == 200) {
        // lấy token từ cục dữ liệu trả về
        String token = response.data['accessToken']; 
        // lưu lại token về mấy, như lưu phiên đăng nhập vậy
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_token', token);

        return true; // Báo về màn hình là OK rồi
      }
    } catch (e) {
      //hiện lỗi
      print("Lỗi đăng nhập: $e");
    }
    return false; 
  }
}