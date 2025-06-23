import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_health_monitor/l10n/app_localizations.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();

  var conditions = [
    "Alergi",
    "Batuk",
    "Lendir Batuk/Batuk berdahak"
    "Sesak nafas",
    "Demam",
    "Perokok"
  ];

  void register(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", name);
    await prefs.setString("email", email);

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Register",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              FormBuilderTextField(
                name: 'full_name',
                decoration: InputDecoration(labelText: localizations.name),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              SizedBox(height: 10),
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(labelText: 'Email'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              SizedBox(height: 10),
              FormBuilderDateTimePicker(
                name: 'birthdate',
                decoration: const InputDecoration(labelText: 'Tanggal Lahir'),
                inputType: InputType.date,
                initialDate: DateTime.now(),
                initialValue: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Riwayat",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              ...conditions.map((e) => SizedBox(height: 36, width:double.infinity, child: FormBuilderCheckbox(name: "disease", title: Text(e, style: TextStyle(fontSize: 16),))),),
              SizedBox(height: 16,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    var res = _formKey.currentState?.saveAndValidate();
                    if (res == true) {
                      register(
                        _formKey.currentState!.value["full_name"],
                        _formKey.currentState!.value["email"],
                      );
                    }
                  },
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
