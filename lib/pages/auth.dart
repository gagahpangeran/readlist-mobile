import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:readlist/components/custom_input_text.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final String _loginMutation = """
    mutation Login(\$username: String!, \$password: String!) {
      login(username: \$username, password: \$password) {
        token
        username
      }
    }
  """;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        document: gql(_loginMutation),
        onCompleted: (data) {
          print("Login");
          print(data);
        },
      ),
      builder: (
        RunMutation runMutation,
        QueryResult? result,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
          ),
          body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomInputText(
                  controller: _usernameController,
                  icon: Icon(Icons.person),
                  labelText: 'Username',
                  validator: true,
                ),
                CustomInputText(
                  controller: _passwordController,
                  icon: Icon(Icons.vpn_key),
                  labelText: 'Password',
                  validator: true,
                  password: true,
                ),
                Center(
                  child: ElevatedButton(
                    child: Text('Login'),
                    onPressed: () {
                      runMutation({
                        'username': _usernameController.text,
                        'password': _passwordController.text,
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
