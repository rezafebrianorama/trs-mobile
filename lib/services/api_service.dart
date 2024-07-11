import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchData() async {
    try {
      final response = await _dio.get(
          'https://tiraapi-dev.tigaraksa.co.id/tes-programer-mobile/api/karyawan/all');
      List emp = [];
      if (response.statusCode == 200) {
        var res = await response.data;
        emp = res['values'];
      }
      return emp;
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  Future<String> postData(List<Map<String, dynamic>> data) async {
    try {
      final response = await _dio.post(
        'https://tiraapi-dev.tigaraksa.co.id/tes-programer-mobile/karyawan/insert',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return response.statusCode.toString();
    } catch (e) {
      return e.toString();
    }
  }
}
