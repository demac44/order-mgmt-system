

createHttpParams(dynamic params){
  var httpParams = '?';
  if (params != null) {
    params.forEach((key, value) {
      if (value != null) {
        httpParams += '$key=$value&';
      }
    });
  }
  return httpParams;
}