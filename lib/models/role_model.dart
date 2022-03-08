

class Role{
  int id;
  String name;
  
  Role({required this.id,required this.name});


  factory Role.fromJson(Map<String,dynamic> json){
    return Role(id: json["id"], name: json["name"]);
  }


  static Map<String,dynamic> toJson(Role role){
    return {
      "id":role.id,
      "name":role.name
    };
  }
}