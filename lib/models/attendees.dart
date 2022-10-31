import 'dart:convert';

Attendees attendeesFromJson(String str) => Attendees.fromJson(json.decode(str));

String attendeesToJson(Attendees data) => json.encode(data.toJson());

class Attendees {
  Attendees({
    required this.id,
    required this.phone,
    required this.shirtSize,
    required this.ticket,
    required this.validated,
    required this.credentialSent,
    required this.deleted,
    required this.fullName,
    required this.bevyFilled,
    required this.transferSupportUrl,
    required this.email,
    required this.foodRestriction,
  });

  String? id;
  String? phone;
  String? shirtSize;
  String? ticket;
  bool? validated;
  bool? credentialSent;
  bool? deleted;
  String? fullName;
  bool? bevyFilled;
  String? transferSupportUrl;
  String? email;
  String? foodRestriction;

  factory Attendees.fromJson(Map<String, dynamic> json) => Attendees(
    id: json["id"],
    phone: json["phone"],
    shirtSize: json["shirtSize"],
    ticket: json["ticket"],
    validated: json["validated"],
    credentialSent: json["credentialSent"],
    deleted: json["deleted"],
    fullName: json["fullName"],
    bevyFilled: json["bevyFilled"],
    transferSupportUrl: json["transferSupportURL"],
    email: json["email"],
    foodRestriction: json["foodRestriction"],
  );

  factory Attendees.fromFirestore(String id, Map<String, dynamic>? json) {
    if (json == null) {
      throw Exception('json is null');
    }

    return Attendees(
      id: id,
      phone: json["phone"],
      shirtSize: json["shirtSize"],
      ticket: json["ticket"],
      validated: json["validated"],
      credentialSent: json["credentialSent"],
      deleted: json["deleted"],
      fullName: json["fullName"],
      bevyFilled: json["bevyFilled"],
      transferSupportUrl: json["transferSupportURL"],
      email: json["email"],
      foodRestriction: json["foodRestriction"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "phone": phone,
    "shirtSize": shirtSize,
    "ticket": ticket,
    "validated": validated,
    "credentialSent": credentialSent,
    "deleted": deleted,
    "fullName": fullName,
    "bevyFilled": bevyFilled,
    "transferSupportURL": transferSupportUrl,
    "email": email,
    "foodRestriction": foodRestriction,
  };
}
