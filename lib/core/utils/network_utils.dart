import 'package:dio/dio.dart';
import 'package:olofooto/core/errors/exception.dart';
import 'package:olofooto/core/utils/typedefs.dart';

abstract class NetworkUtils {
  const NetworkUtils();

  /// this function take the response and the status code we want
  /// check if the status code is incorrect and data is null
  /// throw server exception with the message from FastAPI.
  static void validResponse(Response<DataMap?> response, int statusCode) {
    if (response.data == null || response.statusCode != statusCode) {
      throw ServerException(
        errorMessage: response.data?['message'] as String?,
        statusCode: response.statusCode,
      );
    }
  }
}
