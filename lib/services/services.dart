import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ofimex/models/usuario/direccion.dart';
import 'package:ofimex/models/usuario/getTrabajos.dart';

import 'package:ofimex/models/usuario/login.dart';
import 'package:ofimex/models/usuario/oficio.dart';
import 'package:ofimex/models/usuario/oficoTrabajo.dart';

import 'package:ofimex/models/usuario/responseAuth.dart';
import 'package:ofimex/models/usuario/trabajador.dart';
import 'package:ofimex/models/usuario/trabajo.dart';
import 'package:ofimex/models/usuario/usuario.dart';

const String ip = "192.168.1.67:3000";
// const String ip = "172.16.18.93:3000";

Future<ResponseAuth> agregarUsuario(Usuario usuario) async {
  final url = Uri.parse('http://$ip/usuario');

  try {
    // Hacemos la solicitud POST con un cuerpo JSON
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(usuario.toJson()),
    );

    if (response.statusCode == 200) {
      // Éxito: aquí manejamos la respuesta
      jsonDecode(response.body);
      // print('Respuesta del servidor: $responseData');
      return ResponseAuth(codigo: 200, mensaje: "Registrado correctamente");
    } else {
      // print('Error al hacer la solicitud: ${response.statusCode}');
      return ResponseAuth(codigo: 404, mensaje: "Algo salio mal");
    }
  } catch (error) {
    // print('Error en la solicitud POST: $error');
    return ResponseAuth(codigo: 500, mensaje: "Error en la solicitud");
  }
}

Future<ResponseAuth> loginUser(Login login) async {
  final url = Uri.parse("http://$ip/login");
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(login.toJson()),
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final mensaje = responseData['mensaje'];
      final data = responseData['usuario'];

      if (data != null) {
        // return ResponseAuth(codigo: 200, mensaje: "Listo");
        final usuario = Usuario.getJson(data); // Utilizando el método fromJson
        // printUsuario(usuario);
        return ResponseAuth(codigo: 200, mensaje: mensaje, usuario: usuario);
      } else {
        // print('La respuesta del servidor es nula');
        return ResponseAuth(
            codigo: 500, mensaje: "Respuesta del servidor nula");
      }
    } else {
      // print('Error al hacer la solicitud: ${response.statusCode}');
      return ResponseAuth(
          codigo: 404, mensaje: "Usuario y/o contraseña incorrecta");
    }
  } catch (error) {
    // print('Error en la solicitud POST: $error');
    return ResponseAuth(codigo: 500, mensaje: "Error en la solicitud");
  }
}

Future<ResponseAuth> actualizarUsuario(Usuario usuario) async {
  final url = Uri.parse("http://$ip/usuario/${usuario.id}");
  try {
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(usuario.toJson()),
    );
    // final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return ResponseAuth(codigo: 200, mensaje: "Actualizado correctamente");
    } else {
      // print('Error al hacer la solicitud: ${response.statusCode}');
      return ResponseAuth(
          codigo: 404, mensaje: "Usuario no se encontro el usuario");
    }
  } catch (error) {
    // print('Error en la solicitud POST: $error');
    return ResponseAuth(codigo: 500, mensaje: "Error en la solicitud");
  }
}

Future<ResponseAuth> registrarTrabajador(Trabajador trabajador, int idUsuario,
    String nombre, String apePat, String apeMat) async {
  final url = Uri.parse("http://$ip/conversion/$idUsuario");
  try {
    final data = {
      'edad': trabajador.edad,
      'experiencia': trabajador.experiencia,
      'nombre': nombre,
      'apePat': apePat,
      'apeMat': apeMat,
      'idUsuario': idUsuario,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // jsonDecode(response.body);
      // print('Respuesta del servidor: $responseData');
      return ResponseAuth(codigo: 200, mensaje: "Registrado correctamente");
    } else {
      // print('Error al hacer la solicitud: ${response.statusCode}');
      return ResponseAuth(
          codigo: 404, mensaje: "Algo salio mal! Intentelo más tarde");
    }
  } catch (error) {
    // print('Error en la solicitud POST: $error');
    return ResponseAuth(
        codigo: 500,
        mensaje: "Error en la solicitud al registrar al trabajador");
  }
}

Future<ResponseAuth> registrarOficioTrabajador(
    List<OficioTrabajo> oficioTrabajo) async {
  final url = Uri.parse('http://$ip/oficios');

  List<Map<String, dynamic>> oficiosJson =
      oficioTrabajo.map((oficio) => oficio.toJson()).toList();
  // print(oficiosJson);
  try {
    // Hacemos la solicitud POST con un cuerpo JSON
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(oficiosJson),
    );

    if (response.statusCode == 200) {
      jsonDecode(response.body);
      // print('Respuesta del servidor: $responseData');
      return ResponseAuth(codigo: 200, mensaje: "Registrado correctamente");
    } else {
      // print('Error al hacer la solicitud: ${response.statusCode}');
      return ResponseAuth(
          codigo: 404,
          mensaje:
              "Algo salio mal al registrar los oficios! Intentelo más tarde");
    }
  } catch (error) {
    // print('Error en la solicitud POST: $error');
    return ResponseAuth(
        codigo: 500, mensaje: "Error en la solicitud trabajador oficio");
  }
}

Future<List<Oficio>> getOficios() async {
  final urlAPI = Uri.parse('http://$ip/oficios');

  try {
    var response = await http.get(urlAPI);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final productos =
          (jsonData as List).map((item) => Oficio.getJson(item)).toList();
      return productos;
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

Future<List<Trabajador>> getTrabajadores() async {
  final urlAPI = Uri.parse('http://$ip/trabajadores');
  
  try {
    var response = await http.get(urlAPI);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List;
      final trabajadores = jsonData.map((item) => Trabajador.getJson(item)).toList();
      return trabajadores;
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  } catch (e) {
    // print('Error en getTrabajadores(): $e');
    throw Exception('Error en getTrabajadores(): $e');
  }
}


Future<List<Trabajador>> getTrabajadoresOficio(int idOficio) async {
  final urlAPI = Uri.parse('http://$ip/trabajadores/oficio/$idOficio');

  try {
    var response = await http.get(urlAPI);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final trabajador = (jsonData as List)
          .map((item) => Trabajador.getJson(item))
          .toList();
      // print(trabajador);
      return trabajador;
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

Future<ResponseAuth> contratarTrabajador(Trabajo trabajo) async {
  final url = Uri.parse('http://$ip/trabajos');
  // print(jsonDecode(trabajo.toJson()));
  try {
    // Hacemos la solicitud POST con un cuerpo JSON
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(trabajo.toJson()),
    );

    if (response.statusCode == 200) {
      // Éxito: aquí manejamos la respuesta
    final responseData = jsonDecode(response.body);
      final trabajo = Trabajo.getJson(responseData);
      // print('Respuesta del servidor: ${response.body}');
      return ResponseAuth(codigo: 200, mensaje: "Agregado", trabajo: trabajo);
    } else {
      // print('Error al hacer la solicitud: ${response.statusCode}');
      return ResponseAuth(codigo: 404, mensaje: "Algo salio mal");
    }
  } catch (error) {
    // print('Error en la solicitud POST: $error');
    return ResponseAuth(codigo: 500, mensaje: "Error en la solicitud");
  }
}

Future<ResponseAuth> agregarDireccionTrabajo(Direccion direccion) async {
// print(jsonEncode(direccion.toJson()));
  final url = Uri.parse('http://$ip/direccion');
  try {
    // Hacemos la solicitud POST con un cuerpo JSON
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(direccion.toJson()),
    );

    if (response.statusCode == 200) {
      // Éxito: aquí manejamos la respuesta
      jsonDecode(response.body);
      
      // print('Respuesta del servidor: ${response.body}');
      return ResponseAuth(codigo: 200, mensaje: "Agregado");
    } else {
      // print('Error al hacer la solicitud: ${response.statusCode}');
      return ResponseAuth(codigo: 404, mensaje: "Algo salio mal");
    }
  } catch (error) {
    print('Error en la solicitud POST: $error');
    return ResponseAuth(codigo: 500, mensaje: "Error en la solicitud");
  }
}

Future<List<Trabajo>> getTrabajosTrabajador(int idOficio, int idTrabajador) async {
  final urlAPI = Uri.parse('http://$ip/trabajos/t?idTrab=$idTrabajador&idOfic=$idOficio');

  try {
    final response = await http.get(urlAPI);

    if (response.statusCode == 200) {

      final jsonData = json.decode(response.body);
      final List<Trabajo> trabajo = (jsonData as List)
          .map((item) => Trabajo.getJson(item))
          .toList();

      return trabajo;
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

Future<ResponseAuth> aceptarTrabajo(Trabajo trabajo, idTrabajo) async {
  final url = Uri.parse('http://$ip/trabajos/$idTrabajo');

  try {
    // Hacemos la solicitud POST con un cuerpo JSON
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(trabajo.toJson()),
    );

    if (response.statusCode == 200) {

      jsonDecode(response.body);
      // print('Respuesta del servidor: $responseData');
      return ResponseAuth(codigo: 200, mensaje: "Trabajo aceptado");
    } else {
      print('Error al hacer la solicitud: ${response.statusCode}');
      return ResponseAuth(codigo: 404, mensaje: "Algo salio mal");
    }
  } catch (error) {
    // print('Error en la solicitud POST: $error');
    return ResponseAuth(codigo: 500, mensaje: "Error en la solicitud");
  }
}

// void printUsuario(Usuario usuario) {
//   print('Usuario:');
//   print('  id: ${usuario.id}');
//   print('  nombre: ${usuario.nombre}');
//   print('  apePat: ${usuario.apePat}');
//   print('  apeMat: ${usuario.apeMat}');
//   print('  sexo: ${usuario.sexo}');
//   print('  correo: ${usuario.correo}');
//   print('  usuario: ${usuario.usuario}');
//   print('  pwd: ${usuario.pwd}');
//   print('  idRol: ${usuario.idRol}');
//   print('  rol: ${usuario.rol != null ? usuario.rol!.toJson() : 'null'}');
  
//   if (usuario.oficio != null) {
//     print('  oficio:');
//     for (var oficio in usuario.oficio!) {
//       print('    ${oficio.toJson()}');
//     }
//   } else {
//     print('  oficio: null');
//   }

//   print('  trabajador: ${usuario.trabajador != null ? usuario.trabajador!.toJson() : 'null'}');
// }