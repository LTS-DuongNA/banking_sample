class ListSaveModel {
  String? statusCode;
  String? message;
  List<ThongTinCaNhanList>? thongTinCaNhanList;

  ListSaveModel({this.statusCode, this.message, this.thongTinCaNhanList});

  ListSaveModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    message = json['Message'];
    if (json['ThongTinCaNhanList'] != null) {
      thongTinCaNhanList = <ThongTinCaNhanList>[];
      json['ThongTinCaNhanList'].forEach((v) {
        thongTinCaNhanList!.add(new ThongTinCaNhanList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusCode'] = this.statusCode;
    data['Message'] = this.message;
    if (this.thongTinCaNhanList != null) {
      data['ThongTinCaNhanList'] =
          this.thongTinCaNhanList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ThongTinCaNhanList {
  String? iD;
  String? cmndNum;
  String? cmndName;
  String? cmndDob;
  String? cmndGender;
  String? cmndNation;
  String? cmndHouse;
  String? cmndHome;
  String? dkxPlates;
  String? dkxEngine;
  String? dkxChassis;
  String? urlFront;
  String? urlBehind;
  String? urlFrontDkx;
  String? urlBehindDkx;
  String? email;

  ThongTinCaNhanList(
      {this.iD,
        this.cmndNum,
        this.cmndName,
        this.cmndDob,
        this.cmndGender,
        this.cmndNation,
        this.cmndHouse,
        this.cmndHome,
        this.dkxPlates,
        this.dkxEngine,
        this.dkxChassis,
        this.urlFront,
        this.urlBehind,
        this.urlFrontDkx,
        this.urlBehindDkx,
        this.email});

  ThongTinCaNhanList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    cmndNum = json['cmnd_num'];
    cmndName = json['cmnd_name'];
    cmndDob = json['cmnd_dob'];
    cmndGender = json['cmnd_gender'];
    cmndNation = json['cmnd_nation'];
    cmndHouse = json['cmnd_house'];
    cmndHome = json['cmnd_home'];
    dkxPlates = json['dkx_plates'];
    dkxEngine = json['dkx_engine'];
    dkxChassis = json['dkx_chassis'];
    urlFront = json['url_front'];
    urlBehind = json['url_behind'];
    urlFrontDkx = json['url_front_dkx'];
    urlBehindDkx = json['url_behind_dkx'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['cmnd_num'] = this.cmndNum;
    data['cmnd_name'] = this.cmndName;
    data['cmnd_dob'] = this.cmndDob;
    data['cmnd_gender'] = this.cmndGender;
    data['cmnd_nation'] = this.cmndNation;
    data['cmnd_house'] = this.cmndHouse;
    data['cmnd_home'] = this.cmndHome;
    data['dkx_plates'] = this.dkxPlates;
    data['dkx_engine'] = this.dkxEngine;
    data['dkx_chassis'] = this.dkxChassis;
    data['url_front'] = this.urlFront;
    data['url_behind'] = this.urlBehind;
    data['url_front_dkx'] = this.urlFrontDkx;
    data['url_behind_dkx'] = this.urlBehindDkx;
    data['email'] = this.email;
    return data;
  }
}
