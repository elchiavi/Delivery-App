import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/preferencias_usuario/preferencia_usuario.dart';
import 'package:food_delivery/providers/notification_provider.dart';
import 'package:food_delivery/utils/utils.dart';
import 'package:food_delivery/widgets/custom_all_widgets.dart';
import 'package:provider/provider.dart';

class AccountSettingsPage extends StatelessWidget {

  final formKey = GlobalKey<FormState>();
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      drawer: Menu(),
      body: Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                  child: Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: Column(
                    children: <Widget> [
                      Text('Mi Cuenta', style: Theme.of(context).textTheme.headline5.copyWith(
                                    color: Colors.black87, fontWeight: FontWeight.bold)
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                          onSaved: (value) => prefs.nombre = value,
                          textCapitalization: TextCapitalization.none,
                          style: const TextStyle(color: primaryColor),
                          initialValue: prefs.nombre,
                          decoration:  InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                            ),
                            labelText: 'Nombre',
                          ),
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                              if (value.length < 2) {
                                return 'Ingresa tu Nombre';
                              } else {
                                return null;
                              }
                          },                                
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                          onSaved: (value) => prefs.apellido = value,
                          textCapitalization: TextCapitalization.none,
                          initialValue: prefs.apellido,
                          style: const TextStyle(color: primaryColor),
                          decoration:  InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                            ),
                            labelText: 'Apellido',
                          ),
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                              if (value.length < 2) {
                                return 'Ingresa tu Apellido';
                              } else {
                                return null;
                              }
                          },                                
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                            onSaved: (value) => prefs.direccion = value,
                            textCapitalization: TextCapitalization.none,
                            initialValue: prefs.direccion,
                            style: const TextStyle(color: primaryColor),
                            decoration:  InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                              ),
                              labelText: 'Dirección',
                              helperText: 'Calle, Núm, Piso, Dpto..etc ',
                            ),
                            keyboardType: TextInputType.streetAddress,
                            validator: (value) {
                                if (value.length < 6) {
                                  return 'Ingrese la dirección';
                                } else {
                                  return null;
                                }
                            },                                
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                            style: const TextStyle(color: primaryColor),
                            initialValue: prefs.telefono,
                            textCapitalization: TextCapitalization.none,
                            onSaved: (value) => prefs.telefono = value,
                            decoration:  InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                labelText: 'Teléfono Móvil',
                                helperText: 'Cod Área + Num...Sin 0 y sin 15',
                            ),
                            keyboardType: TextInputType.number,
                              
                            validator:  (value) {
        
                              if (value.length < 8) {
                                return 'Ingrese su celular';
                              } else {
                                return null;
                              }
                            }, 
                                
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                            style: const TextStyle(color: primaryColor),
                            textCapitalization: TextCapitalization.none,
                            initialValue: prefs.email,
                            enabled: false,
                            decoration:  InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                labelText: 'E-Mail',
                            ),
                            keyboardType: TextInputType.number,
                                
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                            child: buttonActualiceAcount(context)
                      ), 
                    ],
                  ),
                ),
              ),
      ),
    );
  }
                      
  Widget buttonActualiceAcount(BuildContext context) {

    bool guardando = Provider.of<NotificationModel>(context).guardando;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),        
      ),
      child: Container(
        height: 70,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text('Actualizar',style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center,),
        ),
      ),
      onPressed: (guardando) ? null : () => {
        if (formKey.currentState.validate()) {
            formKey.currentState.save(),
            Provider.of<NotificationModel>(context, listen: false).guardando = true,
            mostrarSnackbar(context, 'Datos Actualizados'),
            Timer(
              Duration(milliseconds: 1200),
              () {
                Provider.of<NotificationModel>(context, listen: false).guardando = false;
                 Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
              }
            )
        }
      } ,
    );
  }
}