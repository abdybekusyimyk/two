// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

class Todo {
  Todo(
      {required this.title,
      this.decription,
      required this.isselect,
      required this.author,
      this.id});

  final String title;
  final String? decription;
  final bool isselect;
  final String author;
  String? id;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'decription': decription,
      'isselect': isselect,
      'author': author,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> map) {
    return Todo(
      title: map['title'] as String,
      decription:
          map['decription'] != null ? map['decription'] as String : null,
      isselect: map['isselect'] as bool,
      author: map['author'] as String,
    );
  }
}
