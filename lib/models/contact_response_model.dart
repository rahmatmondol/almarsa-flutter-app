class ContactResponseModel {
  ContactResponseModel({
    bool? success,
    String? message,
    Data? data,
  }) {
    _success = success;
    _message = message;
    _data = data;
  }

  ContactResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _success;
  String? _message;
  Data? _data;

  ContactResponseModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      ContactResponseModel(
        success: success ?? _success,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get success => _success;

  String? get message => _message;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// title : "Contact"
/// subtitle : "Contact"
/// contact : "Please do not hesitate to get in touch with any questions or feedback. TAP ICONS BELOW TO CALL OR EMAIL"
/// contact_list : [{"title":"Email","link":"mailto:qI8mD@example.com","icon":"https://cdn-icons-png.flaticon.com/512/25/25231.png"},{"title":"Phone","link":"tel:0123456789","icon":"https://cdn-icons-png.flaticon.com/512/25/25231.png"}]

class Data {
  Data({
    String? title,
    String? subtitle,
    String? contact,
    List<ContactList>? contactList,
  }) {
    _title = title;
    _subtitle = subtitle;
    _contact = contact;
    _contactList = contactList;
  }

  Data.fromJson(dynamic json) {
    _title = json['title'];
    _subtitle = json['subtitle'];
    _contact = json['contact'];
    if (json['contact_list'] != null) {
      _contactList = [];
      json['contact_list'].forEach((v) {
        _contactList?.add(ContactList.fromJson(v));
      });
    }
  }

  String? _title;
  String? _subtitle;
  String? _contact;
  List<ContactList>? _contactList;

  Data copyWith({
    String? title,
    String? subtitle,
    String? contact,
    List<ContactList>? contactList,
  }) =>
      Data(
        title: title ?? _title,
        subtitle: subtitle ?? _subtitle,
        contact: contact ?? _contact,
        contactList: contactList ?? _contactList,
      );

  String? get title => _title;

  String? get subtitle => _subtitle;

  String? get contact => _contact;

  List<ContactList>? get contactList => _contactList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['subtitle'] = _subtitle;
    map['contact'] = _contact;
    if (_contactList != null) {
      map['contact_list'] = _contactList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// title : "Email"
/// link : "mailto:qI8mD@example.com"
/// icon : "https://cdn-icons-png.flaticon.com/512/25/25231.png"

class ContactList {
  ContactList({
    String? title,
    String? link,
    String? icon,
  }) {
    _title = title;
    _link = link;
    _icon = icon;
  }

  ContactList.fromJson(dynamic json) {
    _title = json['title'];
    _link = json['link'];
    _icon = json['icon'];
  }

  String? _title;
  String? _link;
  String? _icon;

  ContactList copyWith({
    String? title,
    String? link,
    String? icon,
  }) =>
      ContactList(
        title: title ?? _title,
        link: link ?? _link,
        icon: icon ?? _icon,
      );

  String? get title => _title;

  String? get link => _link;

  String? get icon => _icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['link'] = _link;
    map['icon'] = _icon;
    return map;
  }
}
