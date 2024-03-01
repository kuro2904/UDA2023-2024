import 'dart:convert';

class BasicAuthGenerateToken{
  final String username;
  final String password;
  BasicAuthGenerateToken(this.username,this.password);

  String generateToken(){
    return "Basic ${base64Encode(utf8.encode('$username:$password'))}";
  }

}