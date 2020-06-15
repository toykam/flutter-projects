class User {
  final String name;
  final String email;
  final String level;
  final String phoneNumber;
  final String userName;

  User({this.name = 'toyiib', this.email = 'kab@gmail.com', this.level = '400 Level', this.phoneNumber = '080232333', this.userName = 'username'});





  @override
  String toString() {
    // TODO: implement toString
    super.toString();
    return 'User {name: $name, email: $email, level: $level}';
  }


}