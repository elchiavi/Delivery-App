import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery/providers/usuarios_providers.dart';
import 'package:food_delivery/utils/utils.dart';
import 'package:provider/provider.dart';


import 'package:food_delivery/widgets/custom_all_widgets.dart';

class RegisterPage extends StatelessWidget {

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [
                CustomIcon(title:'Registrate'),
                _Form(),
                CustomLabel(route: 'login', question: '¿Ya tienes una cuenta?', text: 'Ingresa ahora',),  
                //Text('Terminos y condiciones de uso', style: TextStyle( fontWeight: FontWeight.w200),)

              ],
            ),
          ),
        ),
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

    final emailCtrol = TextEditingController();
    final passCtrol = TextEditingController();

    final usuarioProvider = Provider.of<UsuarioProvider>(context, listen: true);

    return Container(
      padding: EdgeInsets.symmetric(horizontal:30),
       child: Column(
         children: <Widget> [

              CustomInput(icon: Icons.mail_outline, placeholder: 'Email', keyboardType: TextInputType.emailAddress, textController: emailCtrol),
              CustomInput(icon: Icons.lock_outline, placeholder: 'Contraseña', textController: passCtrol, isPassword: true),
              
              CustomButton(text: 'Registrar', 
               onPressed: usuarioProvider.autenticando ? null : () async {
                  // quitar teclado
                  FocusScope.of(context).unfocus();
                  final registerOk =  await usuarioProvider.nuevoUsuario(emailCtrol.text.trim(), passCtrol.text.trim() );
                  if (registerOk){
                     mostrarSnackbar(context, 'Usuario creado correctamente');
                     Timer(
                          Duration(milliseconds: 1000),
                          () {
                          Navigator.pushReplacementNamed(context, 'login');
                          });
                 }else {
                     mostrarAlerta(context, 'El usuario ya existe');
                 }
                },
              )
              
         ],
        ),
    );
  }

  
}