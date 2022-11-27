import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_skeleton/src/config/routes/routesname.dart';

class CategoryBase extends StatefulWidget {
  final Map<String, dynamic> categoryData;
  const CategoryBase({Key? key, required this.categoryData}) : super(key: key);

  @override
  State<CategoryBase> createState() => _CategoryBaseState();
}

class _CategoryBaseState extends State<CategoryBase> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.category,
        color: Colors.black,
        size: 20,
      ),
      title: Text(
        widget.categoryData["categoryname"].toString().toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      trailing: PopupMenuButton(
        child: const Icon(
          Icons.more_vert,
          color: Colors.red,
        ),
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 0,
            child: ListTile(
              leading: Icon(Icons.add),
              title: Text("Add Menu Items"),
            ),
          ),
          const PopupMenuItem(
            value: 1,
            child: ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit"),
            ),
          ),
          const PopupMenuItem(
            value: 1,
            child: ListTile(
              leading: Icon(Icons.delete),
              title: Text("Delete"),
            ),
          ),
        ],
        onSelected: (value) {
          switchValue(value as int);
        },
      ),
    );
  }

  switchValue(int value) {
    switch (value) {
      case 0:
        return Navigator.pushNamed(context, RouteName.foodform,
            arguments: widget.categoryData["uid"]);
    }
  }
}
