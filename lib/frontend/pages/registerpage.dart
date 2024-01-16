import 'package:flutter/material.dart';
import 'package:uplace/frontend/colors.dart';
import 'package:uplace/frontend/routes/routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Controllers for textformfields
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();
  TextEditingController _userConfirmPasswordController =
      TextEditingController();
  //Booleands for password and email verification
  bool _isPasswordValid = true;
  bool _isEmailValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.greenUplace, size: 35),
        backgroundColor: AppColors.blueUplace,
        centerTitle: true,
        title: const Text(
          'Registrar conta',
          style: TextStyle(color: AppColors.greenUplace),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Nome",
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                controller: _userNameController,
                obscureText: false,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: AppColors.greenUplace,
                    border: OutlineInputBorder(),
                    labelText: 'Insira seu nome'),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "E-mail",
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                controller: _userEmailController,
                obscureText: false,
                decoration: _isEmailValid
                    ? const InputDecoration(
                        filled: true,
                        fillColor: AppColors.greenUplace,
                        border: OutlineInputBorder(),
                        labelText: 'Insira seu e-mail')
                    : const InputDecoration(
                        filled: true,
                        fillColor: Colors.red,
                        border: OutlineInputBorder(),
                        labelText: 'Digite um e-mail válido'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {
                    _isEmailValid = _isValidEmail(value);
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Senha",
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                controller: _userPasswordController,
                obscureText: true,
                decoration: _isPasswordValid
                    ? InputDecoration(
                        filled: true,
                        fillColor: AppColors.greenUplace,
                        border: OutlineInputBorder(),
                        labelText: 'Insira sua senha')
                    : InputDecoration(
                        filled: true,
                        fillColor: Colors.red,
                        border: OutlineInputBorder(),
                        labelText: 'A senha deve ter mais de 8 digitos'),
                onChanged: (value) {
                  setState(() {
                    _isPasswordValid = _isValidPassword(value);
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Confirme sua senha",
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                controller: _userConfirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: AppColors.greenUplace,
                    border: OutlineInputBorder(),
                    labelText: 'Insira sua senha novamente'),
              ),
              const SizedBox(
                height: 60,
              ),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  width: 220, // Ajuste a largura do botão conforme necessário
                  height: 60, // Ajuste a altura do botão conforme necessário
                  child: ElevatedButton(
                    onPressed: () {
                      //Local para enviar o valor dos controllers para o banco de dados
                      String senha = _userPasswordController.text;
                      String confirmarSenha =
                          _userConfirmPasswordController.text;
                      if (_isEmailValid && _isPasswordValid && senha == confirmarSenha){
                        RoutesFunctions.gotoHomePage(context);
                      } else {
                        _showAlertDialog(context);
                      }
                      //RoutesFunctions.gotoHomePage(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.blueUplace), // Cor de fundo do botão
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Criar conta',
                      style: TextStyle(
                        color:
                            AppColors.lightblueUplace, // Cor do texto 'Entrar'
                        fontSize: 28, // Ajusta o tamanho do texto
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    return email.contains('@') && email.contains('.');
  }

  bool _isValidPassword(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[a-zA-Z]')) &&
        password.contains(RegExp(r'[0-9]'));
  }
  void _showAlertDialog(BuildContext context) {
    // Cria o AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Erro no formulário!"),
      content: Text("Verifique se as informações estão válidas."),
      actions: [
        // Adiciona botões ao alerta
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Fecha o alerta
          },
          child: Text('Fechar'),
        ),
      ],
    );

    // Mostra o AlertDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
