class LoginModel {
  int? id;
  String? name;
  String? password;
  String? email;
  int? age;
  String? city;

  LoginModel(
      {this.id, this.name, this.password, this.email, this.age, this.city});

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    password = json['password'];
    email = json['email'];
    age = json['age'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['password'] = this.password;
    data['email'] = this.email;
    data['age'] = this.age;
    data['city'] = this.city;
    return data;
  }
}
