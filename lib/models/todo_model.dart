class TodoModel {
  final String text;
  bool isDone;

  TodoModel({
    required this.text,
    this.isDone = false,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        text: json["text"],
        isDone: json["isDone"],
      );

  Map<String, dynamic> toJason() => {
        "text": text,
        "isDone": isDone,
      };
}
