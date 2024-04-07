import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> postJsonRequest(
    String uri, Map<String, String> header, Map<String, String> body) async {
  return http.post(Uri.parse(uri), headers: header, body: jsonEncode(body));
}

Future<http.Response> getRequest(String uri) {
  return http.get(Uri.parse(uri));
}
