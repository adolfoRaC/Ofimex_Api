import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ofimex/models/usuario/login.dart';
import 'package:ofimex/models/usuario/oficio.dart';
import 'package:ofimex/models/usuario/oficoTrabajo.dart';

import 'package:ofimex/models/usuario/responseAuth.dart';
import 'package:ofimex/models/usuario/trabajador.dart';
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
        final usuario = Usuario.getJson(data); // Utilizando el método fromJson
        print(usuario);
        return ResponseAuth(codigo: 200, mensaje: mensaje, usuario: usuario);
      } else {
        print('La respuesta del servidor es nula');
        return ResponseAuth(
            codigo: 500, mensaje: "Respuesta del servidor nula");
      }
    } else {
      print('Error al hacer la solicitud: ${response.statusCode}');
      return ResponseAuth(
          codigo: 404, mensaje: "Usuario y/o contraseña incorrecta");
    }
  } catch (error) {
    print('Error en la solicitud POST: $error');
    return ResponseAuth(codigo: 500, mensaje: "Error en la solicitud");
  }
}

Future<ResponseAuth> actualizarUsuario(Usuario usuario) async{
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
      print('Error al hacer la solicitud: ${response.statusCode}');
      return ResponseAuth(codigo: 404, mensaje: "Algo salio mal! Intentelo más tarde");
    }
  } catch (error) {
    print('Error en la solicitud POST: $error');
    return ResponseAuth(codigo: 500, mensaje: "Error en la solicitud al registrar al trabajador");
  }
}

Future<ResponseAuth> registrarOficioTrabajador(List<OficioTrabajo> oficioTrabajo) async {
  final url = Uri.parse('http://$ip/oficios');

    List<Map<String, dynamic>> oficiosJson = oficioTrabajo.map((oficio) => oficio.toJson()).toList();
    print(oficiosJson);
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
      return ResponseAuth(codigo: 404, mensaje: "Algo salio mal al registrar los oficios! Intentelo más tarde");
    }
  } catch (error) {
    // print('Error en la solicitud POST: $error');
    return ResponseAuth(codigo: 500, mensaje: "Error en la solicitud trabajador oficio");
  }
}


Future<List<Oficio>> getOficios() async {
  final urlAPI = Uri.parse('http://$ip/oficios');
  
  try {
    var response = await http.get(urlAPI);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final productos = (jsonData as List).map((item) => Oficio.getJson(item)).toList();
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
      final jsonData = json.decode(response.body);
      final trabajador = (jsonData as List).map((item) => Trabajador.getJson(item)).toList();
      // print(trabajador);
      return trabajador;
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}