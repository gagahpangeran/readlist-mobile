import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:readlist/components/custom_input_text.dart';
import 'package:readlist/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  late Future<Map<String, String>?> _futureAuthData;

  Future<Map<String, String>?> _getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String? username = prefs.getString("username");

    if (token != null && username != null) {
      return {
        'token': token,
        'username': username,
      };
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    _futureAuthData = _getAuthData();
  }

  final String _loginMutation = """
    mutation Login(\$username: String!, \$password: String!) {
      login(username: \$username, password: \$password) {
        token
        username
      }
    }
  """;

  void _onLoginButtonPressed(RunMutation runMutation) {
    if (_formKey.currentState!.validate()) {
      final scaffold = ScaffoldMessenger.of(context);
      final onLoginSnackbar = Helper.buildSnackbar(text: "Login...");
      scaffold.showSnackBar(onLoginSnackbar);

      runMutation({
        'username': _usernameController.text,
        'password': _passwordController.text,
      });
    }
  }

  void _saveAuthData(dynamic data) async {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.hideCurrentSnackBar();

    String? token = data['login']['token'];
    String? username = data['login']['username'];

    if (token != null && username != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", token);
      await prefs.setString("username", username);

      final successSnackbar = Helper.buildSnackbar(text: "Login Success!");
      scaffold.showSnackBar(successSnackbar);

      Navigator.pop(context);
    } else {
      final errorSnackbar =
          Helper.buildSnackbar(text: "Error, there is something wrong!");
      scaffold.showSnackBar(errorSnackbar);
    }
  }

  void _onLoginError(OperationException? error) {
    // TODO: logging the error to somewhere
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.hideCurrentSnackBar();

    final errorSnackbar =
        Helper.buildSnackbar(text: "Error, there is something wrong!");
    scaffold.showSnackBar(errorSnackbar);
  }

  void _onLogoutButtonPressed() async {
    final scaffold = ScaffoldMessenger.of(context);
    final onLogoutSnackbar = Helper.buildSnackbar(text: "Logout...");
    scaffold.showSnackBar(onLogoutSnackbar);

    final prefs = await SharedPreferences.getInstance();
    var success = await prefs.clear();

    if (success) {
      final successLogoutSnackbar =
          Helper.buildSnackbar(text: "Logout Success!");
      scaffold.showSnackBar(successLogoutSnackbar);

      Navigator.pop(context);
    } else {
      final failedLogoutSnackbar =
          Helper.buildSnackbar(text: "Error, can't logout!");
      scaffold.showSnackBar(failedLogoutSnackbar);
    }
  }

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
        onCompleted: _saveAuthData,
        onError: _onLoginError,
      ),
      builder: (
        RunMutation runMutation,
        QueryResult? result,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
          ),
          body: FutureBuilder<Map<String, String>?>(
            future: _futureAuthData,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final username = snapshot.data!['username'];

                return Center(
                  child: Column(
                    children: <Widget>[
                      Text("You are logged in as $username"),
                      ElevatedButton(
                        onPressed: _onLogoutButtonPressed,
                        child: Text("Logout"),
                      ),
                    ],
                  ),
                );
              }

              return Form(
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
                        onPressed: () => _onLoginButtonPressed(runMutation),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
