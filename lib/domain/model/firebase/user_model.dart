class UserDataModel {
  String uid;
  String name;
  String town;
  String district;
  int age;
  int mobile;

  UserDataModel({
    required this.uid,
    required this.name,
    required this.district,
    required this.age,
    this.town = '',
    required this.mobile,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'district': district,
      'age': age,
      'town': town,
      'mobile': mobile,
    };
  }

  static UserDataModel fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      uid: json['uid'],
      name: json['name'],
      district: json['district'],
      age: json['age'],
      town: json['town'] ?? '', // Use empty string if 'own' is missing
      mobile: json['mobile'],
    );
  }
}
