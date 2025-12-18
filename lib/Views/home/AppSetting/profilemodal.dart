class ProfileModal {
  int? id;
  String? name;
  String? email;
  String? mobileNumber;
  String? emailVerifiedAt;
  String? dob;
  String? gender;
  int? userRole;
  int? userPin;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  ProfileModal(
      {this.id,
      this.name,
      this.email,
      this.mobileNumber,
      this.emailVerifiedAt,
      this.dob,
      this.gender,
      this.userRole,
      this.userPin,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  ProfileModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    emailVerifiedAt = json['email_verified_at'];
    dob = json['dob'];
    gender = json['gender'];
    userRole = json['user_role'];
    userPin = json['user_pin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['user_role'] = this.userRole;
    data['user_pin'] = this.userPin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
