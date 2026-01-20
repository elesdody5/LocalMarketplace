import 'package:domain/user/entity/country.dart';
import 'package:domain/user/entity/state.dart';

class User {
  final String? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final Country? country;
  final CountryState? state;

  User({this.id, this.name, this.email, this.phoneNumber, this.country, this.state});

  bool equals(User other) {
    return id == other.id;
  }
@override
    bool operator ==(Object other) {
      if (identical(this, other)) return true;
      return other is User && other.id == id;
    }

    @override
    int get hashCode => id.hashCode;

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? region,
    Country? country,
    CountryState? state,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      country: country ?? this.country,
      state: state ?? this.state,
    );
  }
}
