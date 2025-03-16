// To parse this JSON data, do
//
//     final driverWallet = driverWalletFromJson(jsondynamic);

import 'dart:convert';

DriverWallet driverWalletFromJson(dynamic str) =>
    DriverWallet.fromJson(json.decode(str));

dynamic driverWalletToJson(DriverWallet data) => json.encode(data.toJson());

class DriverWallet {
  List<Wallet>? data;
  Meta? meta;

  DriverWallet({
    this.data,
    this.meta,
  });

  factory DriverWallet.fromJson(Map<dynamic, dynamic> json) => DriverWallet(
        data: List<Wallet>.from(json["data"].map((x) => Wallet.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta!.toJson(),
      };
}

class Wallet {
  dynamic? weekStart;
  dynamic? weekEnd;
  List<Item>? items;
  Totals? totals;

  Wallet({
    this.weekStart,
    this.weekEnd,
    this.items,
    this.totals,
  });

  factory Wallet.fromJson(Map<dynamic, dynamic> json) => Wallet(
        weekStart: json["weekStart"],
        weekEnd: json["weekEnd"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        totals: Totals.fromJson(json["totals"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "weekStart": weekStart,
        "weekEnd": weekEnd,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "totals": totals!.toJson(),
      };
}

class Item {
  dynamic id;
  dynamic orderNumber;
  dynamic orderStatus;
  dynamic paymentStatus;
  dynamic paymentMethod;
  int? deliveryCharge;
  int? distance;
  int? amount;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic productId;
  int? quantity;
  dynamic productName;
  dynamic productImage;
  dynamic productVariant;
  DeliveryPayment? deliveryPayment;

  Item({
    this.id,
    this.orderNumber,
    this.orderStatus,
    this.paymentStatus,
    this.paymentMethod,
    this.deliveryCharge,
    this.distance,
    this.amount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.productId,
    this.quantity,
    this.productName,
    this.productImage,
    this.productVariant,
    this.deliveryPayment,
  });

  factory Item.fromJson(Map<dynamic, dynamic> json) => Item(
        id: json["id"],
        orderNumber: json["orderNumber"],
        orderStatus: json["orderStatus"],
        paymentStatus: json["paymentStatus"],
        paymentMethod: json["paymentMethod"],
        deliveryCharge: json["deliveryCharge"],
        distance: json["distance"],
        amount: json["amount"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        productId: json["productId"],
        quantity: json["quantity"],
        productName: json["productName"],
        productImage: json["productImage"],
        productVariant: json["productVariant"],
        deliveryPayment: DeliveryPayment.fromJson(json["deliveryPayment"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "orderNumber": orderNumber,
        "orderStatus": orderStatus,
        "paymentStatus": paymentStatus,
        "paymentMethod": paymentMethod,
        "deliveryCharge": deliveryCharge,
        "distance": distance,
        "amount": amount,
        "status": status,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "productId": productId,
        "quantity": quantity,
        "productName": productName,
        "productImage": productImage,
        "productVariant": productVariant,
        "deliveryPayment": deliveryPayment!.toJson(),
      };
}

class DeliveryPayment {
  dynamic id;
  dynamic status;
  dynamic paymentDate;
  dynamic amount;
  DateTime? createdAt;
  DateTime? updatedAt;

  DeliveryPayment({
    this.id,
    this.status,
    this.paymentDate,
    this.amount,
    this.createdAt,
    this.updatedAt,
  });

  factory DeliveryPayment.fromJson(Map<dynamic, dynamic> json) =>
      DeliveryPayment(
        id: json["id"],
        status: json["status"],
        paymentDate: json["paymentDate"],
        amount: json["amount"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "status": status,
        "paymentDate": paymentDate,
        "amount": amount,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class Totals {
  int? totalEarnings;
  int? totalDistance;
  int? totalDeliveryCharges;
  bool? status;

  Totals({
    this.totalEarnings,
    this.totalDistance,
    this.totalDeliveryCharges,
    this.status,
  });

  factory Totals.fromJson(Map<dynamic, dynamic> json) => Totals(
        totalEarnings: json["totalEarnings"],
        totalDistance: json["totalDistance"],
        totalDeliveryCharges: json["totalDeliveryCharges"],
        status: json["status"],
      );

  Map<dynamic, dynamic> toJson() => {
        "totalEarnings": totalEarnings,
        "totalDistance": totalDistance,
        "totalDeliveryCharges": totalDeliveryCharges,
        "status": status,
      };
}

class Meta {
  int? total;
  int? page;
  int? limit;
  int? lastPage;
  bool? hasNextPage;
  bool? hasPreviousPage;

  Meta({
    this.total,
    this.page,
    this.limit,
    this.lastPage,
    this.hasNextPage,
    this.hasPreviousPage,
  });

  factory Meta.fromJson(Map<dynamic, dynamic> json) => Meta(
        total: json["total"],
        page: json["page"],
        limit: json["limit"],
        lastPage: json["lastPage"],
        hasNextPage: json["hasNextPage"],
        hasPreviousPage: json["hasPreviousPage"],
      );

  Map<dynamic, dynamic> toJson() => {
        "total": total,
        "page": page,
        "limit": limit,
        "lastPage": lastPage,
        "hasNextPage": hasNextPage,
        "hasPreviousPage": hasPreviousPage,
      };
}
