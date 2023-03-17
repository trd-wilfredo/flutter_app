class TableList {
  String page;
  double bar;
  String pecent;
  String link;
  dynamic color;

  TableList(
      {required this.page,
      required this.bar,
      required this.pecent,
      required this.link,
      required this.color});

  factory TableList.fromJson(Map<String, dynamic> json) {
    return TableList(
      page: json['page'] as String,
      bar: json['bar'] as double,
      pecent: json['pecent'] as String,
      link: json['link'] as String,
      color: json['color'] as dynamic,
    );
  }
}
