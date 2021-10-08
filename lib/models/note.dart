import 'package:flutter/cupertino.dart';

class SiteD_model {
  String id;
  String site_name;
  String site_type;
  String site_location;
  String site_detail;
  String picture;

  SiteD_model({ this.id, this.site_name, this.site_type, this.site_location, this.site_detail,this.picture});
  factory SiteD_model.fromJson(Map<String, dynamic> item) {
    return SiteD_model(
      id: (item['id']).toString(),
      site_name: item['site_name'],
      site_type: item['site_type'],
      site_location: item['site_location'],
      site_detail:item['site_detail'],
      picture:item['picture'].toString(),
    );
  }
}


