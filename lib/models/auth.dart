import 'dart:convert';

import 'user.dart';

class Auth {
  final User user;
  final String avatar;
  final String accessToken;
  final String tokenType;
  final String expiresAt;
  Auth({
    required this.user,
    required this.avatar,
    required this.accessToken,
    required this.tokenType,
    required this.expiresAt,
  });

  Auth copyWith({
    User? user,
    String? avatar,
    String? accessToken,
    String? tokenType,
    String? expiresAt,
  }) {
    return Auth(
      user: user ?? this.user,
      avatar: avatar ?? this.avatar,
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'avatar': avatar,
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_at': expiresAt,
    };
  }

  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      avatar: map['avatar'] as String,
      accessToken: map['access_token'] as String,
      tokenType: map['token_type'] as String,
      expiresAt: map['expires_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Auth.fromJson(String source) =>
      Auth.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Auth(user: $user, avatar: $avatar, accessToken: $accessToken, tokenType: $tokenType, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(covariant Auth other) {
    if (identical(this, other)) return true;

    return other.user == user &&
        other.avatar == avatar &&
        other.accessToken == accessToken &&
        other.tokenType == tokenType &&
        other.expiresAt == expiresAt;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        avatar.hashCode ^
        accessToken.hashCode ^
        tokenType.hashCode ^
        expiresAt.hashCode;
  }
}
