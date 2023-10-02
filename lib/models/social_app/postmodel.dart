class PostModel{
  String? name;
  String? email;
  String? uId;
  String?   image;
  String?   dateTime;
  String?   text;
  String?   postImage;

  PostModel({
    this.email,
    this.uId,
     this.name,
    this.image,
    this.postImage,
    this.text,
    this.dateTime,
   });

  PostModel.fromJson(Map<String,dynamic> json){
    email = json['email'];
    name = json['name'];
    dateTime = json['dateTime'];
    uId = json['uId'];
    text = json['text'];
    image  = json['image'];
    postImage  = json['postImage'];
   }

  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'email':email,
       'uId':uId,
      'image' : image,
      'dateTime': dateTime   ,
      'text':text,
      'postImage':postImage,

  };

  }
}