// To parse this JSON data, do
//
//     final major = majorFromJson(jsonString);

import 'dart:convert';

Major majorFromJson(String str) => Major.fromJson(json.decode(str));

String majorToJson(Major data) => json.encode(data.toJson());

class Major {
    Major({
        this.content,
        this.pageable,
        this.totalElements,
        this.totalPages,
        this.last,
        this.sort,
        this.size,
        this.number,
        this.numberOfElements,
        this.first,
        this.empty,
    });

    List<Content> content;
    Pageable pageable;
    int totalElements;
    int totalPages;
    bool last;
    Sort sort;
    int size;
    int number;
    int numberOfElements;
    bool first;
    bool empty;

    factory Major.fromJson(Map<String, dynamic> json) => Major(
        content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
        pageable: Pageable.fromJson(json["pageable"]),
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
        last: json["last"],
        sort: Sort.fromJson(json["sort"]),
        size: json["size"],
        number: json["number"],
        numberOfElements: json["numberOfElements"],
        first: json["first"],
        empty: json["empty"],
    );

    Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "pageable": pageable.toJson(),
        "totalElements": totalElements,
        "totalPages": totalPages,
        "last": last,
        "sort": sort.toJson(),
        "size": size,
        "number": number,
        "numberOfElements": numberOfElements,
        "first": first,
        "empty": empty,
    };
}

class Content {
    Content({
        this.majorId,
        this.name,
    });

    int majorId;
    String name;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        majorId: json["majorId"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "majorId": majorId,
        "name": name,
    };
}

class Pageable {
    Pageable({
        this.sort,
        this.pageSize,
        this.pageNumber,
        this.offset,
        this.unpaged,
        this.paged,
    });

    Sort sort;
    int pageSize;
    int pageNumber;
    int offset;
    bool unpaged;
    bool paged;

    factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        sort: Sort.fromJson(json["sort"]),
        pageSize: json["pageSize"],
        pageNumber: json["pageNumber"],
        offset: json["offset"],
        unpaged: json["unpaged"],
        paged: json["paged"],
    );

    Map<String, dynamic> toJson() => {
        "sort": sort.toJson(),
        "pageSize": pageSize,
        "pageNumber": pageNumber,
        "offset": offset,
        "unpaged": unpaged,
        "paged": paged,
    };
}

class Sort {
    Sort({
        this.sorted,
        this.unsorted,
        this.empty,
    });

    bool sorted;
    bool unsorted;
    bool empty;

    factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        sorted: json["sorted"],
        unsorted: json["unsorted"],
        empty: json["empty"],
    );

    Map<String, dynamic> toJson() => {
        "sorted": sorted,
        "unsorted": unsorted,
        "empty": empty,
    };
}
