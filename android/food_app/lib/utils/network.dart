import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http_parser;

/// ## Post json request
///
/// send a post request with body in json format and custom header
///
/// input:
///
///   **<span style="color: yellow">[uri]</span>** uri
///
///   **<span style="color: yellow">[header]</span>** request header
///
///   **<span style="color: yellow">[body]</span>** request body
///
/// return server response without any error catcher
Future<http.Response> postJsonRequest(String uri, Map<String, String> header, Map<String, dynamic> body) {
  return http.post(
    Uri.parse(uri),
    headers: header,
    body: jsonEncode(body)
  );
}

/// ## Put json request
///
/// send a put request with body in json format and custom header
///
/// ### input:
///
///   1. **<span style="color: yellow">[uri]</span>** uri
///
///   2. **<span style="color: yellow">[header]</span>** request header
///
///   3. **<span style="color: yellow">[body]</span>** request body
///
/// ### return:
///
///   - server response without any error catcher
Future<http.Response> putJsonRequest(String uri, Map<String, String> header, Map<String, dynamic> body) {
  return http.put(
      Uri.parse(uri),
      headers: header,
      body: jsonEncode(body)
  );
}

/// ## Get request
///
/// send a get request
///
/// input:
///
///   1. **<span style="color: yellow">[uri]</span>** uri
///
///   2. **<span style="color: yellow">[headers]</span>** headers
///
///   3. **<span style="color: yellow">[query]</span>** get query
///
/// return server response without any error catcher
Future<http.Response> getRequest(String uri, {Map<String, String>? headers, Map<String, String>? query}) {
  Uri requestUri = Uri.parse(uri);
  if (query != null) {
    requestUri = requestUri.replace(queryParameters: query);
  }
  return http.get(requestUri, headers: headers);
}

/// ## Delete request
///
/// send a delete request
///
/// ### input:
///
///   1. **<span style="color: yellow">[uri]</span>** uri
///
///   2. **<span style="color: yellow">[headers]</span>** headers
///
///   3. **<span style="color: yellow">[body]</span>** request body
///
///   4. **<span style="color: yellow">[encoding]</span>** request body where field value is encoded
///
/// ### return
///   - server response without any error catcher
Future<http.Response> deleteRequest(String uri,
    {Map<String, String>? headers, Object? body, Encoding? encoding}) {
  return http.delete(Uri.parse(uri), headers: headers, body: body, encoding: encoding);
}

/// ## Form request
///
/// send a form request
///
/// ### input:
///
///   **<span style="color: yellow">[uri]</span>** uri
///
///   **<span style="color: yellow">[method]</span>** method of form ('POST'/'PUT')
///
///   **<span style="color: yellow">[header]</span>** request header
///
///   **<span style="color: yellow">[fields]</span>** fields of form
///
///   **<span style="color: yellow">[files]</span>** files to upload along with form
///
///   **<span style="color: yellow">[onError]</span>**(optional) catch error
///
///   **<span style="color: yellow">[onException]</span>**(optional) catch exception
///   
/// ### note:
/// 
///   **<span style="color: yellow">[files]</span>** is Map<string, UploadFile>
///   
///   **<span style="color: yellow">key</span>** is field name
///   
///   **<span style="color: yellow">UploadFile</span>** contains:
///   
///   1. **<span style="color: yellow">filename</span>** file name to upload
///     
///   2. **<span style="color: yellow">contentType</span>** MIME type to upload
///
///   3. **<span style="color: yellow">data</span>** file data to upload
///
///   **<span style="color: yellow">[header]</span>** must contains Content-Type or it will default to x-www-form-urlencoded
///
///
/// ### return
///
///   server response
///
///   return null on some errors and exception
///
Future<http.StreamedResponse?> formRequest(
  String uri,
  String method,
  Map<String, String> header,
  Map<String, String> fields,
  Map<String, UploadFile> files,
  {
    void Function(Exception)? onException,
    void Function(String)? onError,
  }) async {
  if (RegExp(r'\b(PUT|POST)\b').hasMatch(method) == false) { // Throw exception on invalid method
    if (onError != null) {
      onError("Invalid form method $method! Can ether PUT or POST");
    }
    return null;
  }
  if (header.containsKey('Content-Type') == false ||                // Check if header contain required field
      FormTypes.list.contains(header['Content-Type']) == false) {   // Check if required field is valid
    if (onError != null) {
      if (header.containsKey('Content-Type') == false) {
        onError("Content-Type is missing default to x-www-form-urlencoded");
      }
      if (FormTypes.list.contains(header['Content-Type']) == false) {
        onError("Invalid Content-Type ${header['Content-Type']}! Default to x-www-form-urlencoded");
      }
    }
    header['Content-Type'] = "x-www-form-urlencoded"; // default content type of form
  }

  try {
    var request = http.MultipartRequest(method, Uri.parse(uri));
    request.headers.addAll(header);
    request.fields.addAll(fields);
    files.forEach((key, value) {
      request.files.add(http.MultipartFile.fromBytes(key, value.data.cast(), filename: value.filename, contentType: value.contentType));
    });
    return request.send();
  } on Exception catch(e) {
    if (onException != null) {
      onException(e);
    }
    return null;
  }
}

class FormTypes {
   static const List<String> list = [
    "x-www-form-urlencoded",
    "multipart/form-data",
    "text/plain",
    "application/json",
    "application/xml",
  ];
}

/// ## UploadFile
///
/// data struct contain file data, filename, content type
class UploadFile {
  
  String? filename;
  http_parser.MediaType? contentType;
  Uint8List data;

  /// ## UploadFile
  ///
  /// **<span style="color: green">[data]</span>** file data in bytes list
  ///
  /// **<span style="color: green">[filename]</span>** file name
  ///
  /// **<span style="color: green">[contentType]</span>** MIME type
  UploadFile({
    required this.data,
    this.filename,
    String? contentType,
  }) {
    if (contentType == null) {
      this.contentType = http_parser.MediaType('application', 'octet-stream');
    } else {
      try {
        // validate MIME type
        this.contentType = http_parser.MediaType.parse(contentType);
      } catch (e) {
        // back to default value if error happens
        this.contentType = http_parser.MediaType('application', 'octet-stream');
      }
    }
  }

}
