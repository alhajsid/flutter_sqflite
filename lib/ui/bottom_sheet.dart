import 'package:flutter/material.dart';
import 'package:flutter_sqflite/db/db_provider.dart';
import 'package:sqflite/sqflite.dart';

showBottom(BuildContext context, Null Function() callSetState){

  final db = TodoProvider();
  var text = "";
  final _formKey = GlobalKey<FormState>();

  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      height: 10,
                    ),
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
                        decoration: const InputDecoration(hintText: "Add Note"),
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
          ),
        );
      });
}