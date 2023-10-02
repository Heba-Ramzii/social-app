class SocialUserModel{
    String? name;
    String? email;
    String? phone;
    String? uId;
    String?   image;
    String? coverImage;
    String? bio;
    bool? isEmailVerified;

  SocialUserModel({
    this.email,
    this.uId,
    this.phone,
    this.name,
    this.image,
    this.coverImage,
    this.bio,
    this.isEmailVerified
});

  SocialUserModel.fromJson(Map<String,dynamic> json){
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    coverImage = json['coverImage'];
    image  = json['image'];
    bio  = json['bio'];
    isEmailVerified= json['isEmailVerified'];
  }

    Map<String,dynamic> toMap(){
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'image' : image,
      'coverImage' : coverImage,
      'bio' : bio,
      'isEmailVerified':isEmailVerified,
     };

  }
}