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

  List<DateTime> _horarios = [
    DateTime.utc(2021,01,01,10,00), DateTime.utc(2021,01,01,10,30), DateTime.utc(2021,01,01,11,00), DateTime.utc(2021,01,01,11,30),
    DateTime.utc(2021,01,01,12,00), DateTime.utc(2021,01,01,12,30), DateTime.utc(2021,01,01,13,00), DateTime.utc(2021,01,01,13,30),
    DateTime.utc(2021,01,01,20,00), DateTime.utc(2021,01,01,20,30), DateTime.utc(2021,01,01,21,00), DateTime.utc(2021,01,01,21,30), 
    DateTime.utc(2021,01,01,22,00), DateTime.utc(2021,01,01,22,30),
  ];

  List<DateTime> _horariosFiltrados = [];
    
  @override
  Widget build(BuildContext context){ 
  _horarios.forEach((horario){
        if (horario.hour.toInt() > DateTime.now().hour.toInt()) {
            _horariosFiltrados.add(horario);
        } else if (horario.hour.toInt() == DateTime.now().hour.toInt() && horario.minute.toInt() > DateTime.now().minute.toInt() ){
            _horariosFiltrados.add(horario);
        }
  });
  DateTime _optSeleccionada = _horariosFiltrados[0];
    
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
                  _optSeleccionada = opt;
                  widget.pedido.horaEntrega = _optSeleccionada.toString().substring(11,16);
              });              
            },
          )
        )
      ],
    );
  }

  List<DropdownMenuItem<DateTime>> getOpcionesDropDown() {

    List<DropdownMenuItem<DateTime>> lista = [];
    _horarios.forEach((horario){
        if (horario.hour.toInt() > DateTime.now().hour.toInt()) {
          lista.add(DropdownMenuItem(
          child: Text(horario.toString().substring(11,16)),
          value: horario,
        ));
        } else if (horario.hour.toInt() == DateTime.now().hour.toInt() && horario.minute.toInt() > DateTime.now().minute.toInt()) {
                    lista.add(DropdownMenuItem(
                    child: Text(horario.toString().substring(11,16)),
                    value: horario,
                  ));
        }
    });
    return lista;

  }

}