class Expat {
    Expat({
        this.id,
        this.nationEntity,
        this.email,
        this.password,
        this.fullname,
        this.phone,
        this.avatarLink,
        this.status,
        this.createDate,
        this.updateDate,
    });

    int id;
    NationEntity nationEntity;
    String email;
    String password;
    String fullname;
    String phone;
    dynamic avatarLink;
    dynamic status;
    List<int> createDate;
    dynamic updateDate;

    factory Expat.fromJson(Map<String, dynamic> json) => Expat(
        id: json["id"],
        nationEntity: NationEntity.fromJson(json["nationEntity"]),
        email: json["email"],
        password: json["password"],
        fullname: json["fullname"],
        phone: json["phone"],
        avatarLink: json["avatarLink"],
        status: json["status"],
        createDate: List<int>.from(json["createDate"].map((x) => x)),
        updateDate: json["updateDate"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nationEntity": nationEntity.toJson(),
        "email": email,
        "password": password,
        "fullname": fullname,
        "phone": phone,
        "avatarLink": avatarLink,
        "status": status,
        "createDate": List<dynamic>.from(createDate.map((x) => x)),
        "updateDate": updateDate,
    };
}

class NationEntity {
    NationEntity({
        this.nationId,
        this.nationName,
    });

    int nationId;
    String nationName;

    factory NationEntity.fromJson(Map<String, dynamic> json) => NationEntity(
        nationId: json["nationId"],
        nationName: json["nationName"],
    );

    Map<String, dynamic> toJson() => {
        "nationId": nationId,
        "nationName": nationName,
    };
}
