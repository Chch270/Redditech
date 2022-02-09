class Tokens {
  String accessToken = "";
  String tokenType = "";
  String refreshToken = "";
  int expire = 0;
  String scope = "";

  Tokens();

  void update(Map<String, dynamic> json) {
    accessToken = (json['access_token'] ?? "") as String;
    tokenType = (json['token_type'] ?? "") as String;
    refreshToken = (json['refresh_token'] ?? "") as String;
    scope = (json['scope'] ?? "") as String;
    expire = (json['expires_in'] ?? "") as int;
  }
}
