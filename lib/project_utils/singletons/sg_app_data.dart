import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onlygym/models/user_model.dart';


class SgAppData {
  SgAppData._();

  static SgAppData instance = SgAppData._();


  static UserModel _user = UserModel();
  static int? _userId;
  static String? _password;
  static String? _avatar;
  static IconData? _localAvatar;

  set localAvatar(IconData? v) => _localAvatar = v;

  IconData? get localAvatar => _localAvatar;

  set avatar(String? v) => _avatar = v;

  String? get avatar => _avatar;

  set user(UserModel v) => _user = v;

  UserModel get user => _user;

  set userId(int? v) => _userId = v;

  int? get userId => _userId;

  set password(String? v) => _password = v;

  String? get password => _password;




}
