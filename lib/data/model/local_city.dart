class LocalCity {
  String? city;
  String? cityAscii;
  num? lat;
  num? lng;
  String? country;
  String? iso2;
  String? iso3;
  String? adminName;
  String? capital;
  dynamic? population;
  num? id;

  LocalCity(
      {this.city,
        this.cityAscii,
        this.lat,
        this.lng,
        this.country,
        this.iso2,
        this.iso3,
        this.adminName,
        this.capital,
        this.population,
        this.id});

  LocalCity.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    cityAscii = json['city_ascii'];
    lat = json['lat'];
    lng = json['lng'];
    country = json['country'];
    iso2 = json['iso2'];
    iso3 = json['iso3'];
    adminName = json['admin_name'];
    capital = json['capital'];
    population = json['population'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['city_ascii'] = this.cityAscii;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['country'] = this.country;
    data['iso2'] = this.iso2;
    data['iso3'] = this.iso3;
    data['admin_name'] = this.adminName;
    data['capital'] = this.capital;
    data['population'] = this.population;
    data['id'] = this.id;
    return data;
  }
}