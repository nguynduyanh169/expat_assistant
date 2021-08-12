// To parse this JSON data, do
//
//     final locationDetails = locationDetailsFromJson(jsonString);

import 'dart:convert';

LocationDetails locationDetailsFromJson(String str) =>
    LocationDetails.fromJson(json.decode(str));

String locationDetailsToJson(LocationDetails data) =>
    json.encode(data.toJson());

class LocationDetails {
  LocationDetails({
    this.htmlAttributions,
    this.result,
    this.status,
  });

  List<dynamic> htmlAttributions;
  Result result;
  String status;

  factory LocationDetails.fromJson(Map<String, dynamic> json) =>
      LocationDetails(
        htmlAttributions:
            List<dynamic>.from(json["html_attributions"].map((x) => x)),
        result: Result.fromJson(json["result"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
        "result": result.toJson(),
        "status": status,
      };
}

class Result {
  Result({
    this.addressComponents,
    this.adrAddress,
    this.businessStatus,
    this.formattedAddress,
    this.formattedPhoneNumber,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.openingHours,
    this.photos,
    this.placeId,
    this.plusCode,
    this.priceLevel,
    this.rating,
    this.reference,
    this.reviews,
    this.types,
    this.url,
    this.userRatingsTotal,
    this.utcOffset,
    this.vicinity,
  });

  List<AddressComponent> addressComponents;
  String adrAddress;
  String businessStatus;
  String formattedPhoneNumber;
  String formattedAddress;
  Geometry geometry;
  String icon;
  String iconBackgroundColor;
  String iconMaskBaseUri;
  String name;
  OpeningHours openingHours;
  List<Photo> photos;
  String placeId;
  PlusCode plusCode;
  int priceLevel;
  double rating;
  String reference;
  List<Review> reviews;
  List<String> types;
  String url;
  int userRatingsTotal;
  int utcOffset;
  String vicinity;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        addressComponents: List<AddressComponent>.from(
            json["address_components"]
                .map((x) => AddressComponent.fromJson(x))),
        adrAddress: json["adr_address"],
        businessStatus: json["business_status"],
        formattedAddress: json["formatted_address"],
        formattedPhoneNumber: json["formatted_phone_number"] == null ? null : json["formatted_phone_number"],
        geometry: Geometry.fromJson(json["geometry"]),
        icon: json["icon"],
        iconBackgroundColor: json["icon_background_color"],
        iconMaskBaseUri: json["icon_mask_base_uri"],
        name: json["name"],
        openingHours: json["opening_hours"] != null
            ? OpeningHours.fromJson(json["opening_hours"])
            : null,
        photos: json["photos"] != null?
             List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x)))
            : null,
        placeId: json["place_id"],
        plusCode:json["plus_code"] == null ? null: PlusCode.fromJson(json["plus_code"]),
        priceLevel: json["price_level"],
        rating: json["rating"] == null ? 0.0 : json["rating"].toDouble(),
        reference: json["reference"],
        reviews:json["reviews"] == null ? null :
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        types: List<String>.from(json["types"].map((x) => x)),
        url: json["url"],
        userRatingsTotal: json["user_ratings_total"],
        utcOffset: json["utc_offset"],
        vicinity: json["vicinity"],
      );

  Map<String, dynamic> toJson() => {
        "address_components":
            List<dynamic>.from(addressComponents.map((x) => x.toJson())),
        "adr_address": adrAddress,
        "business_status": businessStatus,
        "formatted_address": formattedAddress,
        "geometry": geometry.toJson(),
        "icon": icon,
        "icon_background_color": iconBackgroundColor,
        "icon_mask_base_uri": iconMaskBaseUri,
        "name": name,
        "opening_hours": openingHours.toJson(),
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "place_id": placeId,
        "plus_code": plusCode.toJson(),
        "price_level": priceLevel,
        "rating": rating,
        "reference": reference,
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "types": List<dynamic>.from(types.map((x) => x)),
        "url": url,
        "user_ratings_total": userRatingsTotal,
        "utc_offset": utcOffset,
        "vicinity": vicinity,
      };
}

class AddressComponent {
  AddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  String longName;
  String shortName;
  List<String> types;

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      AddressComponent(
        longName: json["long_name"],
        shortName: json["short_name"],
        types: List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "long_name": longName,
        "short_name": shortName,
        "types": List<dynamic>.from(types.map((x) => x)),
      };
}

class Geometry {
  Geometry({
    this.location,
    this.viewport,
  });

  Location location;
  Viewport viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json["location"]),
        viewport: Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "viewport": viewport.toJson(),
      };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Viewport {
  Viewport({
    this.northeast,
    this.southwest,
  });

  Location northeast;
  Location southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: Location.fromJson(json["northeast"]),
        southwest: Location.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast.toJson(),
        "southwest": southwest.toJson(),
      };
}

class OpeningHours {
  OpeningHours({
    this.openNow,
    this.periods,
    this.weekdayText,
  });

  bool openNow;
  List<Period> periods;
  List<String> weekdayText;

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        openNow: json["open_now"] != null ? json["open_now"] : false,
        periods:
            List<Period>.from(json["periods"].map((x) => Period.fromJson(x))),
        weekdayText: List<String>.from(json["weekday_text"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "open_now": openNow,
        "periods": List<dynamic>.from(periods.map((x) => x.toJson())),
        "weekday_text": List<dynamic>.from(weekdayText.map((x) => x)),
      };
}

class Period {
  Period({
    this.close,
    this.open,
  });

  Close close;
  Close open;

  factory Period.fromJson(Map<String, dynamic> json) => Period(
        close: json["close"] == null ? null : Close.fromJson(json["close"]),
        open: Close.fromJson(json["open"]),
      );

  Map<String, dynamic> toJson() => {
        "close": close.toJson(),
        "open": open.toJson(),
      };
}

class Close {
  Close({
    this.day,
    this.time,
  });

  int day;
  String time;

  factory Close.fromJson(Map<String, dynamic> json) => Close(
        day: json["day"] == null ? null : json['day'],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "time": time,
      };
}

class Photo {
  Photo({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  int height;
  List<String> htmlAttributions;
  String photoReference;
  int width;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        height: json["height"],
        htmlAttributions:
            List<String>.from(json["html_attributions"].map((x) => x)),
        photoReference: json["photo_reference"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
        "photo_reference": photoReference,
        "width": width,
      };
}

class PlusCode {
  PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  String compoundCode;
  String globalCode;

  factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
        compoundCode: json["compound_code"],
        globalCode: json["global_code"],
      );

  Map<String, dynamic> toJson() => {
        "compound_code": compoundCode,
        "global_code": globalCode,
      };
}

class Review {
  Review({
    this.authorName,
    this.authorUrl,
    this.language,
    this.profilePhotoUrl,
    this.rating,
    this.relativeTimeDescription,
    this.text,
    this.time,
  });

  String authorName;
  String authorUrl;
  String language;
  String profilePhotoUrl;
  int rating;
  String relativeTimeDescription;
  String text;
  int time;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        authorName: json["author_name"],
        authorUrl: json["author_url"],
        language: json["language"],
        profilePhotoUrl: json["profile_photo_url"],
        rating: json["rating"],
        relativeTimeDescription: json["relative_time_description"],
        text: json["text"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "author_name": authorName,
        "author_url": authorUrl,
        "language": language,
        "profile_photo_url": profilePhotoUrl,
        "rating": rating,
        "relative_time_description": relativeTimeDescription,
        "text": text,
        "time": time,
      };
}
