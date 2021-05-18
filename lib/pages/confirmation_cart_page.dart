
import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/models/pedido_model.dart';
import 'package:food_delivery/models/usuario_model.dart';
import 'package:food_delivery/providers/cart_counter_provider.dart';
import 'package:food_delivery/providers/notification_provider.dart';
import 'package:food_delivery/providers/pedido_provider.dart';
import 'package:food_delivery/providers/usuarios_providers.dart';
import 'package:food_delivery/utils/utils.dart';
import 'package:food_delivery/widgets/custom_all_widgets.dart';
import 'package:provider/provider.dart';

class ConfirmationPage extends StatefulWidget {

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  final formKey = GlobalKey<FormState>();
  String _fecha = '';
  TextEditingController _inputFieldDataControlerFecha = new TextEditingController();
  TextEditingController _inputFieldDataControlerHora = new TextEditingController();

  @override
  Widget build(BuildContext context) {    
    final PedidoModel pedido = ModalRoute.of(context).settings.arguments;
    final usuario = Provider.of<UsuarioProvider>(context).userLogeado;
    return Scaffold(
      appBar: _customAppBar(),
      drawer: Menu(),
      body: Form(
              key: formKey ,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Container(
                            child: ListView(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              children: <Widget> [
                                (!pedido.delivery)
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Retira en la dirección:', style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                .copyWith(color: primaryColor)
                                      ),
                                      SizedBox(height: 5),
                                      Text('Pellegrini 1644',style: Theme.of(context)
                                                .textTheme
                                                .subtitle2
                                                .copyWith(color: primaryColor)
                                      ),
                                      Divider(
                                        height: 30,
                                        color: primaryColor,
                                      ),
                                    ],
                                ) 
                                : _crearDireccion(pedido,usuario),
                                  SizedBox(height: 5),
                                  _crearFechaEntrega(pedido),
                                  SizedBox(height: 10),
                                  _crearHoraEntrega(pedido),
                                  //DropDownHours(pedido: pedido),
                                  Divider(
                                    height: 30,
                                    color: primaryColor,
                                  ),
                                  _crearTelefono(pedido,usuario),
                                  SizedBox(height: 10),
                                  _crearAclaracion(pedido)
                              ],
                            )
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                      child: buttonGenerateOrder(context, pedido)
                    ),          
                  ],
                ),
        ),
      )
    );
  }

  Widget _crearDireccion(PedidoModel pedido, UsuarioModel usuario) {

      return TextFormField(
          onSaved: (value) => pedido.direccion = value,
          textCapitalization: TextCapitalization.none,
          style: const TextStyle(color: primaryColor),
          initialValue: usuario.direccion,
          decoration:  InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
            ),
            labelText: 'Dirección',
            helperText: 'Calle, Núm, Piso, Dpto..etc ',
            icon: Icon(Icons.delivery_dining, color: primaryColor)
          ),
          keyboardType: TextInputType.streetAddress,
          validator: (value) {
              if (value.length < 6) {
                return 'Ingrese la dirección';
              } else {
                return null;
              }
          },                                
      );
    
  }

  Widget _crearFechaEntrega(PedidoModel pedido) {
          
        return TextFormField(
            style: const TextStyle(color: primaryColor),
            onSaved: (value) => pedido.diaEntrega = value,
            enableInteractiveSelection: false,
            controller: _inputFieldDataControlerFecha,
            decoration:  InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                labelText: 'Día de entrega',
                icon: Icon(Icons.calendar_today, color: primaryColor),
            ),
            validator: (value) {
                if (value.isEmpty) {
                  return 'Ingrese fecha';
                } else {
                  return null;
                }
            },
            onTap: () async {
                FocusScope.of(context).requestFocus( new FocusNode());
                DateTime picked = await showDatePicker(
                    context: context, 
                    initialDate: new DateTime.now(), 
                    firstDate: new DateTime.now(), 
                    lastDate: new DateTime.now(),
                );
                if (picked != null) {
                  setState(() {
                      _fecha = formatDate(picked, [dd, '-', mm, '-', yyyy]).toString();
                      _inputFieldDataControlerFecha.text = _fecha;
                  });                                        
                }     
            },
      );
  }

  Widget _crearHoraEntrega(PedidoModel pedido) {

      List<int> _availableHours = [11, 12, 13, 20, 21, 22, 23];

      return TextFormField(
          style: const TextStyle(color: primaryColor),
          onSaved: (value) => pedido.horaEntrega = value,
          enableInteractiveSelection: false,
          controller: _inputFieldDataControlerHora,
          decoration:  InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              labelText: 'Hora de entrega',
              helperText: 'De 11:00 a 14:00 hs y de 20:00 a 00:00 hs',
              icon: Icon(Icons.watch_later_outlined, color: primaryColor),
          ),
          validator: (value) {
              if (value.isEmpty) {
                return 'Ingrese hora';
              } else {
                return null;
              }
          },
          onTap: () async {
              FocusScope.of(context).requestFocus( new FocusNode());
              TimeOfDay time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(DateTime.now()),
              );
              if (time != null)  {
                if (_availableHours.indexOf(time.hour.toInt()) != -1){
                  if (time.hour >= DateTime.now().hour) {
                      if (time.hour == DateTime.now().hour) {
                        if (time.minute <= DateTime.now().minute) {
                          return mostrarAlerta(context, 'Opción seleccionada menor a la hora actual');
                        } else if (time.minute >= DateTime.now().minute + 30) {

                                  setState(() {
                                      _inputFieldDataControlerHora.text = time.toString().substring(10,15);
                                  }); 
                        } else { 
                            return mostrarAlerta(context, 'Hora sugerida: 30 minutos del horario actual');
                          }
                      }

                  } else {
                      return mostrarAlerta(context, 'Opción seleccionada menor a la hora actual');
                  }
                  if (time.hour == DateTime.now().hour + 1) {
                    if (time.minute + 30 >= DateTime.now().minute) {
                      setState(() {
                        _inputFieldDataControlerHora.text = time.toString().substring(10,15);
                      }); 
                    } else {
                      return mostrarAlerta(context, 'Hora sugerida: 30 minutos del horario actual');
                    }
                  } else {

                    setState(() {
                      _inputFieldDataControlerHora.text = time.toString().substring(10,15);
                    });

                  }
                } else {
                  return mostrarAlerta(context, 'Nuestro horario es de 11:00 a 14:00 hs y de 20:00 a 00:00 hs');
                }
              }
              
          },
    );

  }

  Widget _crearTelefono(PedidoModel pedido, UsuarioModel usuario) {

    return TextFormField(
        style: const TextStyle(color: primaryColor),
        textCapitalization: TextCapitalization.none,
        onSaved: (value) => pedido.celular = value,
        initialValue: usuario.telefono,
        decoration:  InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            labelText: 'Teléfono Móvil',
            helperText: 'Cod Área + Num...Sin 0 y sin 15',
            icon: Icon(Icons.smartphone, color: primaryColor)
        ),
        keyboardType: TextInputType.number,
          
        validator:  (value) {

          if (value.length < 8) {
            return 'Ingrese su celular';
          } else {
            return null;
          }
        },                                      
    );
  }

  Widget _crearAclaracion(PedidoModel pedido) {

    return TextFormField(
        style: const TextStyle(color: primaryColor),
        maxLines: 6,
        onSaved: (value) => pedido.aclaraciones = value,
        decoration:  InputDecoration(    
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
          ),
        labelText: 'Aclaraciones',
        icon: Icon(Icons.book, color: primaryColor)
      ),
      keyboardType: TextInputType.multiline,
        
    );
  }
  
  Widget buttonGenerateOrder(BuildContext context, PedidoModel pedido) {

    final pedidoProvider = new PedidosProvider();
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
          child: Text('Realizar Pedido',style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center,),
        ),
      ),
      onPressed: (guardando)  ? null : () => {

        if (formKey.currentState.validate()) {

            formKey.currentState.save(),
            Provider.of<NotificationModel>(context, listen: false).guardando = true,
            pedidoProvider.crearPedido(pedido),
            mostrarSnackbar(context, 'Pedido Realizado'),
                        Timer(
                          Duration(milliseconds: 1200),
                          () {
                            Provider.of<NotificationModel>(context, listen: false).numero = 0;
                            Provider.of<CartCounterProvider>(context, listen: false).listaProductos = [];
                            Provider.of<NotificationModel>(context, listen: false).guardando = false;
                            Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
                          }
                        )
                    }
                  } ,
    );
  }

}      

  Widget _customAppBar() {
    return AppBar(
      elevation: 0,
      title: Text('Italian Pizza & Pasta', style: TextStyle(fontSize: 18) ),
      centerTitle: true,
      //leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
      backgroundColor: backColor,
      
    );
}
