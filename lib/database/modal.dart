class StudentModal {
  int? id;
  String? name;
  String? contact;
  String? address;
  String? gender;

  StudentModal({
    required this.id,
    required this.name,
    required this.contact,
    required this.address,
    required this.gender,
  });

  StudentModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contact = json['contact'];
    address = json['address'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'address': address,
      'gender': gender,
    };
  }
}
