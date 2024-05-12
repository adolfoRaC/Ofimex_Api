import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ofimex/models/usuario/login.dart';
import 'package:ofimex/models/usuario/ofico.dart';
import 'package:ofimex/models/usuario/responseAuth.dart';
import 'package:ofimex/models/usuario/trabajador.dart';
import 'package:ofimex/models/usuario/usuario.dart';

Future<ResponseAuth> agregarUsuario(Usuario usuario) async {
  final url = Uri.parse('http://192.168.1.67:84/usuario');

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
  final url = Uri.parse("http://192.168.1.67:84/login");
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
        // print(usuario);
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

Future<ResponseAuth> registrarTrabajador(Trabajador trabajador, int idUsuario,
    String nombre, String apePat, String apeMat) async {
  final url = Uri.parse("http://192.168.1.67:84//conversion/$idUsuario");
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
      return ResponseAuth(codigo: 404, mensaje: "Algo salio mal");
    }
  } catch (error) {
    // print('Error en la solicitud POST: $error');
    return ResponseAuth(codigo: 500, mensaje: "Error en la solicitud");
  }
}

Future<ResponseAuth> registrarOficio(Oficio oficio) async {
  final url = Uri.parse('http://192.168.1.67:84/oficio');

  try {
    // Hacemos la solicitud POST con un cuerpo JSON
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(oficio.toJson()),
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
// Future<List<>> getTrabajadores() async {
//   final urlAPI = Uri.parse('http://192.168.1.67:83/trabajadores');
  
//   try {
//     var response = await http.get(urlAPI);

//     if (response.statusCode == 200) {
//       final jsonData = json.decode(response.body);
//       final productos = (jsonData as List).map((item) => Producto.getJson(item)).toList();
//       return productos;
//     } else {
//       throw Exception('Error: ${response.statusCode}');
//     }
//   } catch (e) {
//     throw Exception('Error: $e');
//   }
// }