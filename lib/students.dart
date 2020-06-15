class Student{
  int controlum;
  String name;
  String surname;
  String ap;
  String mat;
  String mail;
  String num;
  String photoName;
  Student(this.controlum, this.name, this.surname, this.ap, this.mat, this.mail, this.num, this.photoName);
  Map<String,dynamic>toMap(){
    var map = <String,dynamic>{
      'controlum':controlum,
      'name':name,
      'surname':surname,
      'ap':ap,
      'mat':mat,
      'mail':mail,
      'num':num,
      'photoName': photoName
    };
    return map;
  }
  Student.fromMap(Map<String,dynamic> map){
    controlum=map['controlum'];
    name=map['name'];
    surname=map['surname'];
    ap=map['ap'];
    mat=map['mat'];
    mail=map['mail'];
    num=map['num'];
    photoName = map['photoName'];
  }
}