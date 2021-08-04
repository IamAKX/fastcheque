import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fastcheque/model/manager_model.dart';
import 'package:fastcheque/model/staff_model.dart';
import 'package:fastcheque/model/store_model.dart';

class TransactionModel {
  String stockNumber;
  String customerName;
  String address;
  String city;
  String state;
  int zipCode;
  String requestDate;
  double chequeAmount;
  String phoneNumber;
  String email;
  List<String> photos;
  String chequeID;
  String id;
  DateTime createAt;
  String initiatorID;
  String asignedTo;
  String approvedBy;
  StoreModel storeDetail;
  StaffModel initiatorDetail;
  ManagerModel? approverDetail;
  String status;
  String chequeSequence;
  String rejectionReason;
  DateTime lastUpdated;
  TransactionModel({
    required this.stockNumber,
    required this.customerName,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.requestDate,
    required this.chequeAmount,
    required this.phoneNumber,
    required this.email,
    required this.photos,
    required this.chequeID,
    required this.id,
    required this.createAt,
    required this.initiatorID,
    required this.asignedTo,
    required this.approvedBy,
    required this.storeDetail,
    required this.initiatorDetail,
    this.approverDetail,
    required this.status,
    required this.chequeSequence,
    required this.rejectionReason,
    required this.lastUpdated,
  });

  TransactionModel copyWith({
    String? stockNumber,
    String? customerName,
    String? address,
    String? city,
    String? state,
    int? zipCode,
    String? requestDate,
    double? chequeAmount,
    String? phoneNumber,
    String? email,
    List<String>? photos,
    String? chequeID,
    String? id,
    DateTime? createAt,
    String? initiatorID,
    String? asignedTo,
    String? approvedBy,
    StoreModel? storeDetail,
    StaffModel? initiatorDetail,
    ManagerModel? approverDetail,
    String? status,
    String? chequeSequence,
    String? rejectionReason,
    DateTime? lastUpdated,
  }) {
    return TransactionModel(
      stockNumber: stockNumber ?? this.stockNumber,
      customerName: customerName ?? this.customerName,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      requestDate: requestDate ?? this.requestDate,
      chequeAmount: chequeAmount ?? this.chequeAmount,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      photos: photos ?? this.photos,
      chequeID: chequeID ?? this.chequeID,
      id: id ?? this.id,
      createAt: createAt ?? this.createAt,
      initiatorID: initiatorID ?? this.initiatorID,
      asignedTo: asignedTo ?? this.asignedTo,
      approvedBy: approvedBy ?? this.approvedBy,
      storeDetail: storeDetail ?? this.storeDetail,
      initiatorDetail: initiatorDetail ?? this.initiatorDetail,
      approverDetail: approverDetail ?? this.approverDetail,
      status: status ?? this.status,
      chequeSequence: chequeSequence ?? this.chequeSequence,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'stockNumber': stockNumber,
      'customerName': customerName,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'requestDate': requestDate,
      'chequeAmount': chequeAmount,
      'phoneNumber': phoneNumber,
      'email': email,
      'photos': photos,
      'chequeID': chequeID,
      'id': id,
      'createAt': createAt.millisecondsSinceEpoch,
      'initiatorID': initiatorID,
      'asignedTo': asignedTo,
      'approvedBy': approvedBy,
      'storeDetail': storeDetail.toMap(),
      'initiatorDetail': initiatorDetail.toMap(),
      'approverDetail': approverDetail?.toMap(),
      'status': status,
      'chequeSequence': chequeSequence,
      'rejectionReason': rejectionReason,
      'lastUpdated': lastUpdated.millisecondsSinceEpoch,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      stockNumber: map['stockNumber'],
      customerName: map['customerName'],
      address: map['address'],
      city: map['city'],
      state: map['state'],
      zipCode: map['zipCode'],
      requestDate: map['requestDate'],
      chequeAmount: map['chequeAmount'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      photos: List<String>.from(map['photos']),
      chequeID: map['chequeID'],
      id: map['id'],
      createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt']),
      initiatorID: map['initiatorID'],
      asignedTo: map['asignedTo'],
      approvedBy: map['approvedBy'],
      storeDetail: StoreModel.fromMap(map['storeDetail']),
      initiatorDetail: StaffModel.fromMap(map['initiatorDetail']),
      approverDetail: ManagerModel.fromMap(map['approverDetail']),
      status: map['status'],
      chequeSequence: map['chequeSequence'],
      rejectionReason: map['rejectionReason'],
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(map['lastUpdated']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransactionModel(stockNumber: $stockNumber, customerName: $customerName, address: $address, city: $city, state: $state, zipCode: $zipCode, requestDate: $requestDate, chequeAmount: $chequeAmount, phoneNumber: $phoneNumber, email: $email, photos: $photos, chequeID: $chequeID, id: $id, createAt: $createAt, initiatorID: $initiatorID, asignedTo: $asignedTo, approvedBy: $approvedBy, storeDetail: $storeDetail, initiatorDetail: $initiatorDetail, approverDetail: $approverDetail, status: $status, chequeSequence: $chequeSequence, rejectionReason: $rejectionReason, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionModel &&
        other.stockNumber == stockNumber &&
        other.customerName == customerName &&
        other.address == address &&
        other.city == city &&
        other.state == state &&
        other.zipCode == zipCode &&
        other.requestDate == requestDate &&
        other.chequeAmount == chequeAmount &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        listEquals(other.photos, photos) &&
        other.chequeID == chequeID &&
        other.id == id &&
        other.createAt == createAt &&
        other.initiatorID == initiatorID &&
        other.asignedTo == asignedTo &&
        other.approvedBy == approvedBy &&
        other.storeDetail == storeDetail &&
        other.initiatorDetail == initiatorDetail &&
        other.approverDetail == approverDetail &&
        other.status == status &&
        other.chequeSequence == chequeSequence &&
        other.rejectionReason == rejectionReason &&
        other.lastUpdated == lastUpdated;
  }

  @override
  int get hashCode {
    return stockNumber.hashCode ^
        customerName.hashCode ^
        address.hashCode ^
        city.hashCode ^
        state.hashCode ^
        zipCode.hashCode ^
        requestDate.hashCode ^
        chequeAmount.hashCode ^
        phoneNumber.hashCode ^
        email.hashCode ^
        photos.hashCode ^
        chequeID.hashCode ^
        id.hashCode ^
        createAt.hashCode ^
        initiatorID.hashCode ^
        asignedTo.hashCode ^
        approvedBy.hashCode ^
        storeDetail.hashCode ^
        initiatorDetail.hashCode ^
        approverDetail.hashCode ^
        status.hashCode ^
        chequeSequence.hashCode ^
        rejectionReason.hashCode ^
        lastUpdated.hashCode;
  }
}
