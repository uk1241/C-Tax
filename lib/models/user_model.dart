class User 
{
  final String userid;
  final String password;

  User({required this.userid, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userid: json['userid'],
      password: json['password'],
    );
  }
}
