class CredentialModel {
  final String username;
  final String password;

  CredentialModel.empty()
      : username = '',
        password = '';

  CredentialModel(this.username, this.password);

  bool get isEmpty => username.isEmpty && password.isEmpty;

  CredentialModel.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}
