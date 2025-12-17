import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class ApiClient {
   Dio dio = Dio();

  // Post Api
 
  Future<Response<dynamic>?> postApi(
    Map<String, dynamic> map, {
    required String url,
  }) async {
    try {
      final box = GetStorage();

      ///
      String? token = box.read('token') as String?;

      // checkin for Expiration of the Token

      //
      final headers = {"accept": "application/json"};

      // Safely get and attach token if present
      token = box.read('token');
      if (token != null && token.isNotEmpty) {
        headers["Authorization"] = "Bearer $token";
        log('Request: Attaching Authorization header');
      }

      final response = await dio.post(
        url,
        data: map,
        options: Options(headers: headers),
      );

      // Safely handle token in response
      try {
        if (response.data is Map<String, dynamic>) {
          final responseToken = response.data['token'];
          if (responseToken is String && responseToken.isNotEmpty) {
            box.write('token', responseToken);
            log('Response: New token saved');
          }
        }
      } catch (e) {
        log('Warning: Could not process token from response: $e');
      }

      log('Request succeeded: ${response.statusCode}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        log(
          'HTTP Error: ${e.response?.statusCode} - ${e.response?.statusMessage}',
        );
        // Return response so caller can handle error status/body
        return e.response;
      } else {
        log('Network Error: ${e.message}');
        // Network/configuration errors return null
        return null;
      }
    } catch (e) {
      log('Unexpected error in postApi: $e');
      return null;
    }
  }

  //
  //Get Api

  Future<Response<dynamic>?> getApi({required String url}) async {
    try {
      final box = GetStorage();
      print("API==>[$url]");

      ///
      String? token = box.read('token') as String?;
      final headers = {"accept": "application/json"};
      token = box.read('token');
      if (token != null && token.isNotEmpty) {
        headers["Authorization"] = "Bearer $token";
        log('Request: Attaching Authorization header');
      }

      final response = await dio.get(url, options: Options(headers: headers));

      // Safely handle token in response
      try {
        if (response.data is Map<String, dynamic>) {
          final responseToken = response.data['token'];
          if (responseToken is String && responseToken.isNotEmpty) {
            box.write('token', responseToken);
            log('Response: New token saved');
          }
        }
      } catch (e) {
        log('Warning: Could not process token from response: $e');
      }

      log('Request succeeded: ${response.statusCode}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        log(
          'HTTP Error: ${e.response?.statusCode} - ${e.response?.statusMessage}',
        );
        // Return response so caller can handle error status/body
        return e.response;
      } else {
        log('Network Error: ${e.message}');
        // Network/configuration errors return null
        return null;
      }
    } catch (e) {
      log('Unexpected error in postApi: $e');
      return null;
    }
  }

  



}
