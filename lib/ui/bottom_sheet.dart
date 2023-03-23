import 'package:flutter/material.dart';
import 'package:flutter_sqflite/db/db_provider.dart';
import 'package:sqflite/sqflite.dart';

showBottom(BuildContext context, Null Function() callSetState){

  final db = TodoProvider();
  var text = "";
  final _formKey = GlobalKey<FormState>();

  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      expands: true,
                      // and this
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Note cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: "Add Note"),
                      onChanged: (value){
                        text = value;
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      if(_formKey.currentState != null && _formKey.currentState!.validate()){
                        await db.insert(Todo(text, true));
                        Navigator.pop(context);
                        callSetState();
                      }
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                        elevation: 2,
                        backgroundColor: Colors.blue),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}