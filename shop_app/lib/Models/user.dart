class User{
  int? id;
  String? username;
  String? image;
  String? email;
  String? location;
  String? token;
  
  User({
    this.id,
    this.username,
    this.image,
    this.email,
    this.location,
    this.token,
  });
  
  // Function data to map json to user object
  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['user']['id'],
      username: json['user']['username'],
      image: json['user']['image'],
      email: json['user']['email'],
      location: json['user']['location'],
      token: json['token'],
    );
  }
  
}