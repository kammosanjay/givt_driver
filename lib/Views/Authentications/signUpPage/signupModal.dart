class SignupData {
  final String? dateofbirth;
  final String? fullname;
  final String? lastName;
  final String? salutation;
  final String? email;
  final String? gender;
  final String? token;
  final int? userRole;

  SignupData({
    this.dateofbirth,
    this.fullname,
    this.lastName,
    this.salutation,
    this.email,
    this.gender,
    this.token,
    this.userRole,
  });

  // Optional: toJson for API or storage
  Map<String, dynamic> toJson() => {
    'dob': dateofbirth,
    'name': fullname,
    'last_name': lastName,
    'salutation': salutation,
    'email': email,
    'gender': gender,
    'token': token,
    'user_role': userRole,
  };

  // Optional: fromJson to create from Map
  factory SignupData.fromJson(Map<String, dynamic> json) => SignupData(
    dateofbirth: json['dob'],
    fullname: json['name'],
    lastName: json['last_name'],
    salutation: json['salutation'],
    email: json['email'],
    gender: json['gender'],
    token: json['token'],
    userRole: json['user_role'],
  );
}
