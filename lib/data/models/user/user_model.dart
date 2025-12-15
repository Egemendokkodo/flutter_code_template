class UserModel {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String birthDate;
  final LoginModel login;
  final AddressModel address;
  final String phone;
  final String website;
  final CompanyModel company;

  UserModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.birthDate,
    required this.login,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      birthDate: json['birthDate'],
      login: LoginModel.fromJson(json['login']),
      address: AddressModel.fromJson(json['address']),
      phone: json['phone'],
      website: json['website'],
      company: CompanyModel.fromJson(json['company']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'birthDate': birthDate,
      'login': login.toJson(),
      'address': address.toJson(),
      'phone': phone,
      'website': website,
      'company': company.toJson(),
    };
  }

  @override
  String toString() {
    return 'UserModel(id: $id, firstname: $firstname, lastname: $lastname, email: $email)';
  }
}
class LoginModel {
  final String uuid;
  final String username;
  final String password;
  final String md5;
  final String sha1;
  final String registered;

  LoginModel({
    required this.uuid,
    required this.username,
    required this.password,
    required this.md5,
    required this.sha1,
    required this.registered,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      uuid: json['uuid'],
      username: json['username'],
      password: json['password'],
      md5: json['md5'],
      sha1: json['sha1'],
      registered: json['registered'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'username': username,
      'password': password,
      'md5': md5,
      'sha1': sha1,
      'registered': registered,
    };
  }

  @override
  String toString() {
    return 'LoginModel(username: $username, uuid: $uuid)';
  }
}
class AddressModel {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final GeoModel geo;

  AddressModel({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
      geo: GeoModel.fromJson(json['geo']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'suite': suite,
      'city': city,
      'zipcode': zipcode,
      'geo': geo.toJson(),
    };
  }

  @override
  String toString() {
    return 'AddressModel(city: $city, street: $street)';
  }
}

class GeoModel {
  final String lat;
  final String lng;

  GeoModel({
    required this.lat,
    required this.lng,
  });

  factory GeoModel.fromJson(Map<String, dynamic> json) {
    return GeoModel(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  @override
  String toString() {
    return 'GeoModel(lat: $lat, lng: $lng)';
  }
}
class CompanyModel {
  final String name;
  final String catchPhrase;
  final String bs;

  CompanyModel({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      name: json['name'],
      catchPhrase: json['catchPhrase'],
      bs: json['bs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'catchPhrase': catchPhrase,
      'bs': bs,
    };
  }

  @override
  String toString() {
    return 'CompanyModel(name: $name)';
  }
}
