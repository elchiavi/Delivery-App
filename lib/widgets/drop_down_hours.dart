import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/models/pedido_model.dart';

class DropDownHours extends StatefulWidget {
  const DropDownHours({Key key, this.pedido}) : super(key: key);

  final PedidoModel pedido;

  @override
  _DropDownHoursState createState() => _DropDownHoursState();
}

class _DropDownHoursState extends State<DropDownHours> {

  List<String> _horarios = ['11:00-11:30','11:30-12:00','12:00-12:30','12:30-13:00','13:00-13:30','13:30-14:00'];
  String _optSeleccionada = '11:00-11:30';
  
  @override
  Widget build(BuildContext context){
    widget.pedido.horaEntrega = _optSeleccionada;  
  return Row(
      children: <Widget> [
        Icon(Icons.watch_later_outlined, color: primaryColor, size: 26),
        SizedBox(width: 20),
        Expanded(
          child: DropdownButton(
            value: _optSeleccionada,
            items: getOpcionesDropDown(),
            icon: const Icon(Icons.arrow_drop_down, color: primaryColor),
            elevation: 16,
            style: const TextStyle(color: primaryColor),
            underline: Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide.none)
              )
            ),
            onChanged: (opt) {
              setState(() {
                if( opt != 'Hora de entrega' ) {
                  _optSeleccionada = opt;
                  widget.pedido.horaEntrega = _optSeleccionada;
                }
                
              });

            },
          )
        )
      ],

    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropDown() {

    List<DropdownMenuItem<String>> lista = [];
    _horarios.forEach((horario){
      lista.add(DropdownMenuItem(
      child: Text(horario),
      value: horario,
      ));

    });
    return lista;

  }

}