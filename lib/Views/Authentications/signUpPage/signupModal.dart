class SignupData {
  final String? dateofbirth;
  final String? fullname;
  final String? email;
  final String? gender;
  final String? token;

  SignupData({
    this.dateofbirth,
    this.fullname,
    this.email,
    this.gender,
    this.token,
  });

  // Optional: toJson for API or storage
  Map<String, dynamic> toJson() => {
    'dob': dateofbirth,
    'name': fullname,
    'email': email,
    'gender': gender,
    'token': token,
  };

  // Optional: fromJson to create from Map
  factory SignupData.fromJson(Map<String, dynamic> json) => SignupData(
    dateofbirth: json['dob'],
    fullname: json['name'],
    email: json['email'],
    gender: json['gender'],
    token: json['token'],
  );
}
