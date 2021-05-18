import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
    UsuarioModel({
        this.id,
        this.nombre,
        this.apellido,
        this.email,
        this.direccion,
        this.telefono,
    });

    String id;
    String nombre;
    String apellido;
    String email;
    String direccion;
    String telefono;

    factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        email: json["email"],
        direccion: json["direccion"],
        telefono: json["telefono"],
    );

    Map<String, dynamic> toJson() => {
        //"id": id,
        "nombre": nombre,
        "apellido": apellido,
        "email": email,
        "direccion": direccion,
        "telefono": telefono,
    };
}
