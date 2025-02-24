import 'package:jocco/core/models/app_user.dart';

class PotentialMatchingContent {
    final List<AppUser> content;
    final Pageable pageable;
    final bool last;
    final int totalElements;
    final int totalPages;
    final int size;
    final int number;
    final Sort sort;
    final bool first;
    final int numberOfElements;
    final bool empty;

    PotentialMatchingContent({
        required this.content,
        required this.pageable,
        required this.last,
        required this.totalElements,
        required this.totalPages,
        required this.size,
        required this.number,
        required this.sort,
        required this.first,
        required this.numberOfElements,
        required this.empty,
    });

    PotentialMatchingContent copyWith({
        List<AppUser>? content,
        Pageable? pageable,
        bool? last,
        int? totalElements,
        int? totalPages,
        int? size,
        int? number,
        Sort? sort,
        bool? first,
        int? numberOfElements,
        bool? empty,
    }) => 
        PotentialMatchingContent(
            content: content ?? this.content,
            pageable: pageable ?? this.pageable,
            last: last ?? this.last,
            totalElements: totalElements ?? this.totalElements,
            totalPages: totalPages ?? this.totalPages,
            size: size ?? this.size,
            number: number ?? this.number,
            sort: sort ?? this.sort,
            first: first ?? this.first,
            numberOfElements: numberOfElements ?? this.numberOfElements,
            empty: empty ?? this.empty,
        );

    factory PotentialMatchingContent.fromJson(Map<String, dynamic> json) => PotentialMatchingContent(
        content: List<AppUser>.from((json["content"] as List).map((x) => AppUser.fromJson(x))),
        pageable: Pageable.fromJson(json["pageable"]),
        last: json["last"],
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
        size: json["size"],
        number: json["number"],
        sort: Sort.fromJson(json["sort"]),
        first: json["first"],
        numberOfElements: json["numberOfElements"],
        empty: json["empty"],
    );

    Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x)),
        "pageable": pageable.toJson(),
        "last": last,
        "totalElements": totalElements,
        "totalPages": totalPages,
        "size": size,
        "number": number,
        "sort": sort.toJson(),
        "first": first,
        "numberOfElements": numberOfElements,
        "empty": empty,
    };
}

class Pageable {
    final int pageNumber;
    final int pageSize;
    final Sort sort;
    final int offset;
    final bool paged;
    final bool unpaged;

    Pageable({
        required this.pageNumber,
        required this.pageSize,
        required this.sort,
        required this.offset,
        required this.paged,
        required this.unpaged,
    });

    Pageable copyWith({
        int? pageNumber,
        int? pageSize,
        Sort? sort,
        int? offset,
        bool? paged,
        bool? unpaged,
    }) => 
        Pageable(
            pageNumber: pageNumber ?? this.pageNumber,
            pageSize: pageSize ?? this.pageSize,
            sort: sort ?? this.sort,
            offset: offset ?? this.offset,
            paged: paged ?? this.paged,
            unpaged: unpaged ?? this.unpaged,
        );

    factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        sort: Sort.fromJson(json["sort"]),
        offset: json["offset"],
        paged: json["paged"],
        unpaged: json["unpaged"],
    );

    Map<String, dynamic> toJson() => {
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "sort": sort.toJson(),
        "offset": offset,
        "paged": paged,
        "unpaged": unpaged,
    };
}

class Sort {
    final bool empty;
    final bool sorted;
    final bool unsorted;

    Sort({
        required this.empty,
        required this.sorted,
        required this.unsorted,
    });

    Sort copyWith({
        bool? empty,
        bool? sorted,
        bool? unsorted,
    }) => 
        Sort(
            empty: empty ?? this.empty,
            sorted: sorted ?? this.sorted,
            unsorted: unsorted ?? this.unsorted,
        );

    factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        empty: json["empty"],
        sorted: json["sorted"],
        unsorted: json["unsorted"],
    );

    Map<String, dynamic> toJson() => {
        "empty": empty,
        "sorted": sorted,
        "unsorted": unsorted,
    };
}
