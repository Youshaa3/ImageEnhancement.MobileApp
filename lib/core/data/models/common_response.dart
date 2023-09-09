class CommonResponse<T> {
  T? data;
  int? statusCode;
  String? message;

  CommonResponse.fromJson(Map<String, dynamic> json) {
    try {
      this.statusCode = json['statusCode'];
      if (json['response']['res'] == 'ok') {
        this.data = json['response']['data'];
      } else {
        if (json['response']['data'] != null &&
            json['response']['data'] is Map &&
            json['response']['res'] != null) {
          this.message = json['response']['res'];
        } else {
          switch (statusCode) {
            case 400:
              message = '400 Bad request';
              break;
            case 401:
              message = '401 Unauthorized';
              break;
            case 500:
              message = '500 Internal server error';
              break;
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  bool get getStatus => message != 'ok' ? true : false;
}
