class SelectModel {
  SelectModel({
    required this.id,
    required this.name,
    required this.list,
  });
  final int id;
  final String name;
  final List<InnerSelectModel> list;
}

class InnerSelectModel {
  InnerSelectModel({
    required this.id,
    required this.value,
  });
  final int id;
  final String value;
}
