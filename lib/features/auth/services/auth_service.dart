import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<bool> login(String username, String password) async {
    try {
      final String apiUrl = 'https://dummyjson.com/auth/login'; 

      final response = await _dio.post(
        apiUrl,
        data: {
          'username': username,
          'password': password,
          
          'expiresInMins': 40000, 
        },
        options: Options(
          contentType: Headers.jsonContentType, // Đảm bảo gửi dạng JSON
        ),
      );

      if (response.statusCode == 200) {
        // DummyJSON trả về key là 'accessToken' (hoặc 'token' tùy phiên bản, nhưng thường là accessToken)
        // Chúng ta in ra để kiểm tra
        print("Đăng nhập thành công!");
        print("User: ${response.data['username']}");
        print("Token (sống 40000 phút): ${response.data['accessToken']}"); // <-- Token xịn ở đây
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("Lỗi Server: ${e.response?.data['message']}");
      } else {
        print("Lỗi kết nối: ${e.message}");
      }
      return false;
    }
  }
}