import 'dart:convert';
import 'dart:typed_data';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../features/log/log.service.dart';

class NetworkService {
  final String baseUrl;
  final log = GetIt.instance<LogService>();

  NetworkService({required this.baseUrl});

  // Generic GET request
  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      log.logInfo('Http GET [$endpoint]');
      final response =
          await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);
      if (response.statusCode == 200) {
        log.logInfo('Http GET [$endpoint] 200 OK');
        return response.body;
      } else {
        log.logError(
            'Failed to load data from [$endpoint].', Exception(response));
        throw Exception(
            'Failed to load data from [$endpoint]. ${response.toString()}');
      }
    } catch (e) {
      log.logError('Failed to get [$endpoint].', Exception(e));
      rethrow;
    }
  }

  // Generic POST request
  Future<dynamic> post(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    try {
      log.logInfo('Http POST [$endpoint]');
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log.logInfo('Http POST [$endpoint] 200 OK');
        return jsonDecode(response.body);
      } else {
        log.logError(
            'Failed to load data from [$endpoint].', Exception(response));
        throw Exception(
            'Failed to load data from [$endpoint]. ${response.toString()}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Download image or binary data
  Future<Uint8List> downloadImage(String imageUrl) async {
    try {
      log.logInfo('Http GetImage [$imageUrl]');
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        log.logInfo('Http GetImage [$imageUrl] 200 OK');
        return response.bodyBytes;
      } else {
        log.logError(
            'Failed to get image from [$imageUrl].', Exception(response));
        throw Exception(
            'Failed to get image from [$imageUrl]. ${response.toString()}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
