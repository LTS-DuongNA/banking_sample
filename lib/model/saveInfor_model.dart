class ResSaveIforModel {
  ResSaveIforModel({
    required this.StatusCode,
    required this.Message,
    // required this.ThongTinCaNhan,
  });
  late final String StatusCode;
  late final String Message;
  // late final ThongTinCaNhan ThongTinCaNhan;

  ResSaveIforModel.fromJson(Map<String, dynamic> json){
    StatusCode = json['StatusCode'];
    Message = json['Message'];
    // ThongTinCaNhan = ThongTinCaNhan.fromJson(json['ThongTinCaNhan']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StatusCode'] = StatusCode;
    _data['Message'] = Message;
    // _data['ThongTinCaNhan'] = ThongTinCaNhan.toJson();
    return _data;
  }
}

class ThongTinCaNhan {
  ThongTinCaNhan({
    this.ID,
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
    this.email,
  });
  late final Null ID;
  late final Null cmndNum;
  late final Null cmndName;
  late final Null cmndDob;
  late final Null cmndGender;
  late final Null cmndNation;
  late final Null cmndHouse;
  late final Null cmndHome;
  late final Null dkxPlates;
  late final Null dkxEngine;
  late final Null dkxChassis;
  late final Null urlFront;
  late final Null urlBehind;
  late final Null urlFrontDkx;
  late final Null urlBehindDkx;
  late final Null email;

  ThongTinCaNhan.fromJson(Map<String, dynamic> json){
    ID = null;
    cmndNum = null;
    cmndName = null;
    cmndDob = null;
    cmndGender = null;
    cmndNation = null;
    cmndHouse = null;
    cmndHome = null;
    dkxPlates = null;
    dkxEngine = null;
    dkxChassis = null;
    urlFront = null;
    urlBehind = null;
    urlFrontDkx = null;
    urlBehindDkx = null;
    email = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ID'] = ID;
    _data['cmnd_num'] = cmndNum;
    _data['cmnd_name'] = cmndName;
    _data['cmnd_dob'] = cmndDob;
    _data['cmnd_gender'] = cmndGender;
    _data['cmnd_nation'] = cmndNation;
    _data['cmnd_house'] = cmndHouse;
    _data['cmnd_home'] = cmndHome;
    _data['dkx_plates'] = dkxPlates;
    _data['dkx_engine'] = dkxEngine;
    _data['dkx_chassis'] = dkxChassis;
    _data['url_front'] = urlFront;
    _data['url_behind'] = urlBehind;
    _data['url_front_dkx'] = urlFrontDkx;
    _data['url_behind_dkx'] = urlBehindDkx;
    _data['email'] = email;
    return _data;
  }
}