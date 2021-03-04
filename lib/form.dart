class FeedbackForm {
  String name;
  String email;
  String age;
  String address;
  String mobileNo;
  String aadhar;
  String photo;

  FeedbackForm(this.name, this.email, this.age, this.address, this.mobileNo,
      this.aadhar, this.photo);

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm(
        "${json['name']}",
        "${json['email']}",
        "${json['age']}",
        "${json['address']}",
        "${json['aadhar']}",
        "${json['mobileNo']}",
        "${json['photo']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'name': name,
        'email': email,
        'address': address,
        'mobileNo': mobileNo,
        'aadhar': aadhar,
        'age': age,
        'photo': photo,
      };
}
