import 'dart:convert';

DeliveryOrderModel deliveryOrderModelFromJson(dynamic str) =>
    DeliveryOrderModel.fromJson(json.decode(str));

dynamic deliveryOrderModelToJson(DeliveryOrderModel data) =>
    json.encode(data.toJson());

class DeliveryOrderModel {
  List<Datum>? data;
  Meta? meta;

  DeliveryOrderModel({
    this.data,
    this.meta,
  });

  factory DeliveryOrderModel.fromJson(Map<dynamic, dynamic> json) =>
      DeliveryOrderModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta!.toJson(),
      };
}

class Datum {
  dynamic assignmentId;
   OrderDetails? orderDetails;
  CustomerDetails? customerDetails;
   List<OrderItem>? orderItems;
  DeliveryDetails? deliveryDetails;

  Datum({
    this.assignmentId,
     this.orderDetails,
     this.customerDetails,
      this.orderItems,
     this.deliveryDetails,
  });

  factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        assignmentId: json["assignmentId"],
         orderDetails: OrderDetails.fromJson(json["orderDetails"]),
         customerDetails: CustomerDetails.fromJson(json["customerDetails"]),
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromJson(x))),
           deliveryDetails: DeliveryDetails.fromJson(json["deliveryDetails"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "assignmentId": assignmentId,
         "orderDetails": orderDetails!.toJson(),
         "customerDetails": customerDetails!.toJson(),
          "orderItems": List<dynamic>.from(orderItems!.map((x) => x.toJson())),
          "deliveryDetails": deliveryDetails!.toJson(),
      };
}

class CustomerDetails {
  dynamic customerId;
  dynamic name;
  dynamic email;
  dynamic phone;
  Address? deliveryAddress;

  CustomerDetails({
    this.customerId,
    this.name,
    this.email,
    this.phone,
    this.deliveryAddress,
  });

  factory CustomerDetails.fromJson(Map<dynamic, dynamic> json) =>
      CustomerDetails(
        customerId: json["customerId"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        deliveryAddress: Address.fromJson(json["deliveryAddress"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "customerId": customerId,
        "name": name,
        "email": email,
        "phone": phone,
        "deliveryAddress": deliveryAddress!.toJson(),
      };
}

class Address {
  dynamic id;
  dynamic pincode;
  dynamic phoneNumber;
  dynamic alternatePhoneNumber;
  dynamic addressLine;
  dynamic landmark;
  dynamic addressType;
  dynamic city;
  dynamic district;
  dynamic name;
  dynamic state;
  dynamic country;
  bool? isDeliverable;
  bool? isDefault;
  dynamic additionalInstructions;
  dynamic latitude;
  dynamic longitude;

  DateTime? createdAt;
  DateTime? updatedAt;

  Address({
    this.id,
    this.pincode,
    this.phoneNumber,
    this.alternatePhoneNumber,
    this.addressLine,
    this.landmark,
    this.addressType,
    this.city,
    this.district,
    this.name,
    this.state,
    this.country,
    this.isDeliverable,
    this.isDefault,
    this.additionalInstructions,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  factory Address.fromJson(Map<dynamic, dynamic> json) => Address(
        id: json["id"],
        pincode: json["pincode"],
        phoneNumber: json["phoneNumber"],
        alternatePhoneNumber: json["alternatePhoneNumber"],
        addressLine: json["addressLine"],
        landmark: json["landmark"],
        addressType: json["addressType"],
        city: json["city"],
        district: json["district"],
        name: json["name"],
        state: json["state"],
        country: json["country"],
        isDeliverable: json["isDeliverable"],
        isDefault: json["isDefault"],
        additionalInstructions: json["additionalInstructions"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "pincode": pincode,
        "phoneNumber": phoneNumber,
        "alternatePhoneNumber": alternatePhoneNumber,
        "addressLine": addressLine,
        "landmark": landmark,
        "addressType": addressType,
        "city": city,
        "district": district,
        "name": name,
        "state": state,
        "country": country,
        "isDeliverable": isDeliverable,
        "isDefault": isDefault,
        "additionalInstructions": additionalInstructions,
        "latitude": latitude,
        "longitude": longitude,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class DeliveryDetails {
  Driver? driver;
  dynamic status;
  DateTime? assignedAt;
  dynamic expectedDeliveryTime;
  dynamic deliveryNotes;

  DeliveryDetails({
    this.driver,
    this.status,
    this.assignedAt,
    this.expectedDeliveryTime,
    this.deliveryNotes,
  });

  factory DeliveryDetails.fromJson(Map<dynamic, dynamic> json) =>
      DeliveryDetails(
        driver: Driver.fromJson(json["driver"]),
        status: json["status"],
        assignedAt: DateTime.parse(json["assignedAt"]),
        expectedDeliveryTime: json["expectedDeliveryTime"],
        deliveryNotes: json["deliveryNotes"],
      );

  Map<dynamic, dynamic> toJson() => {
        "driver": driver!.toJson(),
        "status": status,
        "assignedAt": assignedAt,
        "expectedDeliveryTime": expectedDeliveryTime,
        "deliveryNotes": deliveryNotes,
      };
}

class Driver {
  dynamic name;
  dynamic email;
  dynamic phone;
  dynamic address;
  Vehicle? vehicle;
  dynamic currentLocation;

  Driver({
    this.name,
    this.email,
    this.phone,
    this.address,
    this.vehicle,
    this.currentLocation,
  });

  factory Driver.fromJson(Map<dynamic, dynamic> json) => Driver(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        vehicle: Vehicle.fromJson(json["vehicle"]),
        currentLocation: json["currentLocation"],
      );

  Map<dynamic, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "vehicle": vehicle!.toJson(),
        "currentLocation": currentLocation,
      };
}

class Vehicle {
  Vehicle();

  factory Vehicle.fromJson(Map<dynamic, dynamic> json) => Vehicle();

  Map<dynamic, dynamic> toJson() => {};
}

class OrderDetails {
  dynamic orderNumber;
  dynamic orderStatus;
  dynamic paymentStatus;
  dynamic finalTotal;
  dynamic paymentMethod;
  DateTime? createdAt;

  OrderDetails({
    this.orderNumber,
    this.orderStatus,
    this.paymentStatus,
    this.finalTotal,
    this.paymentMethod,
    this.createdAt,
  });

  factory OrderDetails.fromJson(Map<dynamic, dynamic> json) => OrderDetails(
        orderNumber: json["orderNumber"],
        orderStatus: json["orderStatus"],
        paymentStatus: json["paymentStatus"],
        finalTotal: json["finalTotal"],
        paymentMethod: json["paymentMethod"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "orderNumber": orderNumber,
        "orderStatus": orderStatus,
        "paymentStatus": paymentStatus,
        "finalTotal": finalTotal,
        "paymentMethod": paymentMethod,
        "createdAt": createdAt,
      };
}

class OrderItem {
   Product? product;
   Vendor? vendor;
  int? quantity;
  dynamic totalPrice;
   dynamic status;

  OrderItem({
     this.product,
     this.vendor,
    this.quantity,
    this.totalPrice,
    this.status,
  });

  factory OrderItem.fromJson(Map<dynamic, dynamic> json) => OrderItem(
         product: Product.fromJson(json["product"]),
         vendor: Vendor.fromJson(json["vendor"]),
        quantity: json["quantity"],
        totalPrice: json["totalPrice"],
        status: json["status"],
      );

  Map<dynamic, dynamic> toJson() => {
         "product": product!.toJson(),
         "vendor": vendor!.toJson(),
        "quantity": quantity,
        "totalPrice": totalPrice,
        "status": status,
      };
}

class Product {
  dynamic name;
  dynamic description;
  List<dynamic>? images;
  List<Highlight>? highlights;
  // dynamic brand;
  dynamic price;
  // dynamic discountPrice;
  // dynamic manufacturer;
  // DateTime? expiryDate;
  // dynamic careDetails;
  Store? store;
  // Category? category;
  // dynamic productType;
  // dynamic timeSlot;
  // List<ProductTag>? productTags;
  // List<dynamic>? zones;
  // List<dynamic>? questions;
  // List<dynamic>? productReviews;

  Product({
    this.name,
    this.description,
    this.images,
    this.highlights,
    // this.brand,
    this.price,
    // this.discountPrice,
    // this.manufacturer,
    // this.expiryDate,
    // this.careDetails,
    this.store,
    // this.category,
    // this.productType,
    // this.timeSlot,
    // this.productTags,
    // this.zones,
    // this.questions,
    // this.productReviews,
  });

  factory Product.fromJson(Map<dynamic, dynamic> json) => Product(
        name: json["name"],
        description: json["description"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        highlights: List<Highlight>.from(
            json["highlights"].map((x) => Highlight.fromJson(x))),
        // brand: json["brand"],
        price: json["price"],
        // discountPrice: json["discountPrice"],
        // manufacturer: json["manufacturer"],
        // expiryDate: DateTime.parse(json["expiryDate"]),
        // careDetails: json["careDetails"],
        store: Store.fromJson(json["store"]),
        // category: Category.fromJson(json["category"]),
        // productType: json["productType"],
        // timeSlot: json["timeSlot"],
        // productTags: List<ProductTag>.from(
        //     json["productTags"].map((x) => ProductTag.fromJson(x))),
        // zones: List<dynamic>.from(json["zones"].map((x) => x)),
        // questions: List<dynamic>.from(json["questions"].map((x) => x)),
        // productReviews:
        //     List<dynamic>.from(json["productReviews"].map((x) => x)),
      );

  Map<dynamic, dynamic> toJson() => {
        "name": name,
        "description": description,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "highlights": List<dynamic>.from(highlights!.map((x) => x.toJson())),
        // "brand": brand,
        "price": price,
        // "discountPrice": discountPrice,
        // "manufacturer": manufacturer,
        // "expiryDate": expiryDate,
        // "careDetails": careDetails,
        "store": store!.toJson(),
        // "category": category!.toJson(),
        // "productType": productType,
        // "timeSlot": timeSlot,
        // "productTags": List<dynamic>.from(productTags!.map((x) => x.toJson())),
        // "zones": List<dynamic>.from(zones!.map((x) => x)),
        // "questions": List<dynamic>.from(questions!.map((x) => x)),
        // "productReviews": List<dynamic>.from(productReviews!.map((x) => x)),
      };
}

class Category {
  dynamic id;
  dynamic name;
  dynamic slug;

  Category({
    this.id,
    this.name,
    this.slug,
  });

  factory Category.fromJson(Map<dynamic, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
      };
}

class Highlight {
  dynamic title;
  dynamic description;

  Highlight({
    this.title,
    this.description,
  });

  factory Highlight.fromJson(Map<dynamic, dynamic> json) => Highlight(
        title: json["title"],
        description: json["description"],
      );

  Map<dynamic, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}

class ProductTag {
  dynamic id;
  dynamic name;

  ProductTag({
    this.id,
    this.name,
  });

  factory ProductTag.fromJson(Map<dynamic, dynamic> json) => ProductTag(
        id: json["id"],
        name: json["name"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Store {
  dynamic storeName;
  dynamic storeAddress;
  dynamic officialPhoneNumber;
  dynamic gstNumber;

  Store({
    this.storeName,
    this.storeAddress,
    this.officialPhoneNumber,
    this.gstNumber,
  });

  factory Store.fromJson(Map<dynamic, dynamic> json) => Store(
        storeName: json["storeName"],
        storeAddress: json["storeAddress"],
        officialPhoneNumber: json["officialPhoneNumber"],
        gstNumber: json["gstNumber"],
      );

  Map<dynamic, dynamic> toJson() => {
        "storeName": storeName,
        "storeAddress": storeAddress,
        "officialPhoneNumber": officialPhoneNumber,
        "gstNumber": gstNumber,
      };
}

class Vendor {
  dynamic storeName;
  dynamic vendorName;
  dynamic vendorEmail;
  dynamic storeAddress;
  dynamic storePhone;
  dynamic gstNumber;
 // Address? vendorAddress;

  Vendor({
    this.storeName,
    this.vendorName,
    this.vendorEmail,
    this.storeAddress,
    this.storePhone,
    this.gstNumber,
   // this.vendorAddress,
  });

  factory Vendor.fromJson(Map<dynamic, dynamic> json) => Vendor(
        storeName: json["storeName"],
        vendorName: json["vendorName"],
        vendorEmail: json["vendorEmail"],
        storeAddress: json["storeAddress"],
        storePhone: json["storePhone"],
        gstNumber: json["gstNumber"],
      //  vendorAddress: Address.fromJson(json["vendorAddress"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "storeName": storeName,
        "vendorName": vendorName,
        "vendorEmail": vendorEmail,
        "storeAddress": storeAddress,
        "storePhone": storePhone,
        "gstNumber": gstNumber,
       // "vendorAddress": vendorAddress!.toJson(),
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
