class Login {
  String usuario;
  String pwd;

  Login({required this.usuario, required this.pwd});

  factory Login.getJson(Map json){
    return Login(usuario: json["uss"], pwd: json["pass"]);
  }

  Map<String, dynamic> toJson(){
    return {
      "uss": usuario,
      "pass":pwd
    };
  }
}
