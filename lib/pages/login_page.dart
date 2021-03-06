import 'package:flutter/material.dart';
import 'package:food_delivery/providers/usuarios_providers.dart';
import 'package:food_delivery/utils/utils.dart';
import 'package:food_delivery/widgets/custom_all_widgets.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: Column(
              mainAxisAlignment:  MainAxisAlignment.spaceBetween,
              children: <Widget> [
                CustomIcon(title: 'Ingresar'),
                _Form(),
                CustomLabel(route: 'register', question: '¿No tienes cuenta?', text: 'Crea una ahora'),  
                //Text('Terminos y condiciones de uso', style: TextStyle( fontWeight: FontWeight.w200),)
              ],
            ),

          ) 
        ) 
      ),
    );
  }
}


class _Form extends StatefulWidget {

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  
  @override
  Widget build(BuildContext context) {

    final usuarioProvider = Provider.of<UsuarioProvider>(context, listen: true);

    final emailCtrol = TextEditingController();
    final passCtrol = TextEditingController();

    return Container(
      padding: EdgeInsets.symmetric(horizontal:30),
       child: Column(
         children: <Widget> [

              CustomInput(icon: Icons.mail_outline, placeholder: 'Email', keyboardType: TextInputType.emailAddress, textController: emailCtrol),
              CustomInput(icon: Icons.lock_outline, placeholder: 'Contraseña', textController: passCtrol, isPassword: true),
              
              CustomButton(text: 'Ingresar', 
                onPressed: usuarioProvider.autenticando ? null : () async {
                  // quitar teclado
                  FocusScope.of(context).unfocus();
                  final loginOk =  await usuarioProvider.login(emailCtrol.text.trim(), passCtrol.text.trim() );
                  if (loginOk){
                      Navigator.pushReplacementNamed(context, 'home');
                 }else {
                      mostrarAlerta(context, 'Usuario y/o contraseña incorectos');
                 }
                },
              )
              
         ],
        ),
    );
  }

}