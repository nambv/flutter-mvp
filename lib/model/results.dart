import 'package:flutter_mvp/model/user.dart';

class UserResponse {
  List<User> results;
  Info info;

  UserResponse({this.results, this.info});

  UserResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = new List<User>();
      json['results'].forEach((v) {
        results.add(new User.fromJson(v));
      });
    }
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    return data;
  }
}

class Info {
  String seed;
  int results;
  int page;
  String version;

  Info({this.seed, this.results, this.page, this.version});

  Info.fromJson(Map<String, dynamic> json) {
    seed = json['seed'];
    results = json['results'];
    page = json['page'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seed'] = this.seed;
    data['results'] = this.results;
    data['page'] = this.page;
    data['version'] = this.version;
    return data;
  }
}
