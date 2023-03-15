class CMND_Data {
  String? status;
  String? message;
  Data? data;

  CMND_Data({this.status, this.message, this.data});

  factory CMND_Data.fromJson(Map<String, dynamic> json) => CMND_Data(
      status: json["status"],
      message: json["message"],
      data: json['data'] != null ? Data.fromJson(json['data']) : null);
}

class Data {
  String? email;

  String? cmnd_num;
  String? cmnd_name;
  String? cmnd_dob;
  String? cmnd_nation;
  String? cmnd_gender;
  String? cmnd_house;
  String? cmnd_home;

  String? dkx_plates;
  String? dkx_engine;
  String? dkx_chassis;
  String? url_front_dkx;
  String? url_behind_dkx;

  Data({
    this.email,
    this.cmnd_num,
    this.cmnd_name,
    this.cmnd_dob,
    this.cmnd_house,
    this.cmnd_home,
    this.cmnd_nation,
    this.cmnd_gender,
    this.dkx_plates,
    this.dkx_engine,
    this.dkx_chassis,
    this.url_front_dkx,
    this.url_behind_dkx,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
        cmnd_num: json["cmnd_num"],
        cmnd_name: json["cmnd_name"],
        cmnd_dob: json["cmnd_dob"],
        cmnd_gender: json["cmnd_gender"],
        cmnd_house: json["cmnd_house"],
        cmnd_nation: json["cmnd_nation"],
        cmnd_home: json["cmnd_home"],
        dkx_plates: json["dkx_plates"],
        dkx_engine: json["dkx_engine"],
        dkx_chassis: json["dkx_chassis"],
        url_front_dkx: json["url_front_dkx"],
        url_behind_dkx: json["url_behind_dkx"],
      );
}
