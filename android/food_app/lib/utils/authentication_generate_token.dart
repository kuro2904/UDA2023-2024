import 'dart:convert';

class BasicAuthGenerateToken{
  final String username;
  final String password;
  BasicAuthGenerateToken(this.username,this.password);

  static String generateToken(String username, String password){
    return "Basic ${base64Encode(utf8.encode('$username:$password'))}";
  }

}