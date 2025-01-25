Map<String, String> authHeaders({required String token}) => {
      'Content-type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token',
      'Accept-Charset': 'utf-8'
    };

Map<String, String> header() =>
    {'Content-type': 'application/json; charset=utf-8', 'Accept-Charset': 'utf-8'};

bool checkIfSuccess({required int statusCode}) {
  return statusCode >= 200 && statusCode < 300;
}

Uri kProdUri({required String endPoint}) => 
    Uri.parse("https://api.audiance.app/$endPoint");
