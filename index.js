const express = require('express')


const cors = require('cors');
const { PrismaClient } = require('@prisma/client')

const prisma = new PrismaClient();

const cloudinary = require('cloudinary').v2;

const multer = require('multer');

const path = require('path')

const storage = multer.diskStorage({
    destination: './images',
    filename: (req, file, cb) => {
        const nombre = `${Date.now()} - ${Math.round(Math.random() * 1000)}`;
        const ext = path.extname(file.originalname)
        cb(null, file.fieldname + " - " + nombre + ext)
    }
});

const upload = multer({ storage })

cloudinary.config({
    cloud_name: "dfcxpfylu",
    api_key: '433233238563563',
    api_secret: 'mHyA_W045Ntyito2DLqKtdWGjHk'
});

const { ImageAnalysisClient } = require('@azure-rest/ai-vision-image-analysis');
const createClient = require('@azure-rest/ai-vision-image-analysis').default;
const { AzureKeyCredential } = require('@azure/core-auth');

// Load the .env file if it exists
require("dotenv").config();

const endpoint = 'https://ofimex.cognitiveservices.azure.com/';
const key = '13bcade2f8114c0ab14f4c56fff7d97c';
const credential = new AzureKeyCredential(key);

const client = createClient(endpoint, credential);

const features = [
    'Read'
];


async function analyzeImageFromUrl(imageUrl) {

    const result = await client.path('/imageanalysis:analyze').post({
        body: {
            url: imageUrl
        },
        queryParameters: {
            features: features,
            'smartCrops-aspect-ratios': [0.9, 1.33]
        },
        contentType: 'application/json'
    });

    const iaResult = result.body;

    let lines;

    if (iaResult.readResult) {
        iaResult.readResult.blocks.forEach(block => {
            lines = block.lines.map(line => line.text); 
            console.log(lines)
          
        });
    }

    return lines

}

function belong(text) {
    if (text == "FECHA DE NACIMIENTO" || text == "FECHA NACIMIENTO" || text == "DOMICILIO" || text == "SEXO M" || text == "SEXO H" || String(text).match(/\b\d{2}\/\d{2}\/\d{4}\b/)) {
        return false
    }else{
        return true
    }
}

const app = express();
app.use(express.json());
app.use(cors());

app.use(cors({
    origin: '*',
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    allowedHeaders: ['Content-Type', 'Authorization'],
}));

//Azure's Endpoint 
app.post('/image/analyze', upload.single('picture'), async (req, res) => {
    

    let path = req.file.destination + '/' + req.file.filename;
    let url = "";
    cloudinary.uploader.upload(path,
        { public_id: "INEPrueba"+new Date() },
        async (error, result) => {
            console.log(error)
    const lines = await analyzeImageFromUrl(result.url)
    let name;
    let fathLastName;
    let mothLastName;
    let countNames = 0;
    let counter = 0;
     lines.forEach(text => {
        if (text == "NOMBRE") {
            counter++
            for (let index = 0; index < 5; index++) {
                
                if (belong(lines[(counter+index)])) {

                    console.log(lines[[counter+index]])
                    switch (countNames) {
                        case 0:
                            fathLastName = lines[(counter+index)];
                            countNames++
                            break;
                        case 1:
                                mothLastName = lines[(counter+index)];
                                countNames++
                                break;        
                        case 2:
                            name = lines[(counter+index)];
                            countNames++
                            break;
                        default:
                            break;
                    }
                }
                    
            }
        }else{
            counter ++
        }
     });
     
     res.json({nombre: name, apellidoPaterno: fathLastName, apellidoMaterno: mothLastName})
 })

});

//EndPoints donde se utiliza la tabla Usuarios

//Login
app.post('/login', async (req, res) => {
    const { uss, pass } = req.body;
    const usser = await prisma.usuario.findFirst({
        where: {
            usuario: String(uss),
            pwd: String(pass)
        },
        include: {
            rol: true,
            oficio: true,
            trabajador: true
        }
    });

    if (usser != null) {
        usser.pwd = "*****";
        // Verificar si 'trabajador' es un array y extraer el primer elemento
        if (Array.isArray(usser.trabajador) && usser.trabajador.length > 0) {
            usser.trabajador = usser.trabajador[0];
        }
        return res.status(200).json({ mensaje: 'Bienvenido', usuario: usser });
    } else {
        return res.status(404).json({ mensaje: 'No encontrado' });
    }
});




//Buscar un usuario por id
app.get('/usuario/:id', async (req, res) => {
    const id = req.params.id
    const usser = await prisma.usuario.findFirst({
        where: {
            id: Number(id)
        },
        include: {
            rol: true,
            oficio: true,
            trabajador: true
        }
    })
    if (usser != null) {
        usser.pwd = "*****"
        return res.status(200).json({ mensaje: 'Bienvenido', usuario: usser })
    } else {
        return res.status(404).json({ mensaje: 'No encontrado' })
    }
})

//Crear un usuario
app.post('/usuario', upload.single('foto'), async (req, res) => {
    const { nombre, apePat, apeMat, sexo, correo, usuario, pwd, idRol } = req.body;

    // Verificar si idRol es un entero
    const idRolInt = parseInt(idRol);

    if (!req.file) {
        // Si no se proporciona ningún archivo, manejar el error apropiadamente
        return res.status(400).json({ error: 'No se proporcionó ninguna imagen' });
    }

    let path = req.file.destination + '/' + req.file.filename;
    let url = "";
    let fecha = new Date();

    cloudinary.uploader.upload(path,
        { public_id: nombre + fecha },
        async (error, result) => {
            if (error) {
                // Si ocurre un error al subir la imagen, manejarlo apropiadamente
                return res.status(500).json({ error: 'Error al subir la imagen' });
            }
            const resultado = await prisma.usuario.create({
                data: {
                    nombre, apePat, apeMat, sexo, correo, usuario, pwd, idRol: idRolInt, imagen: result.url
                }
            });

            res.json(resultado);
        });
});



//Actualizar un usuario
app.put('/usuario/:id', async (req, res) => {
    const idQuery = req.params.id;
    const { id, nombre, apePat, apeMat, sexo, correo, usuario, pwd, idRol, imagen } = req.body
    if (Number(idQuery) !== Number(id)) {
        return res.status(400).json({ mensaje: 'No coinciden los id proporcionados' })
    }
    const resultado = await prisma.usuario.update({
        where: { id: Number(id) },
        data: {
            nombre, apePat, apeMat, sexo, correo, usuario, pwd, idRol, imagen
        }
    })
    if (resultado == null)
        return res.status(404).json({ mensaje: 'No encontrado' })
    res.json(resultado);

})

app.put('/usuarioF/:id', upload.single('foto'), async (req, res) => {
    const idQuery = parseInt(req.params.id); // Convertir idQuery a entero
    const { id, nombre, apePat, apeMat, sexo, correo, usuario, pwd, idRol } = req.body;

    // Convertir id y idRol a enteros
    const idInt = parseInt(id);
    const idRolInt = parseInt(idRol);

    // Verificar si el ID en la ruta coincide con el ID en el cuerpo de la solicitud
    if (idQuery !== idInt) {
        return res.status(400).json({ mensaje: 'No coinciden los id proporcionados' });
    }
    let path = req.file.destination + '/' + req.file.filename;
    let fecha = new Date();

    cloudinary.uploader.upload(path,
        { public_id: nombre + fecha },
        async (error, result) => {
            const resultado = await prisma.usuario.update({
                where: { id: idInt },
                data: {
                    nombre, apePat, apeMat, sexo, correo, usuario, pwd, idRol: idRolInt, imagen: result.url
                }
            })

            if (resultado == null)
                return res.status(404).json({ mensaje: 'No encontrado' })
            res.json(resultado);
        })
});




//Pasar de ser un empleador a un trabajador
app.post('/conversion/:idUss', async (req, res) => {
    const { edad, experiencia, idUsuario, nombre, apePat, apeMat } = req.body
    const { idUss } = req.params
    const trabajos = 5
    const idRol = 3;
    const disponible = true;
    if (Number(idUss) !== Number(idUsuario)) {
        return res.status(400).json({ mensaje: 'No coinciden los id proporcionados' })
    }

    const usuario = await prisma.usuario.update({
        where: { id: Number(idUss) },
        data: { idRol, nombre, apePat, apeMat }
    })
    const trabajador = await prisma.trabajador.create({
        data: {
            edad, experiencia, trabajos, disponible, membresia: new Date(), idUsuario: Number(idUss)
        }
    })

    res.json(trabajador)
})

//Obtener todos los trabajadores
app.get('/trabajadores', async (req, res) => {
    const trabajadores = await prisma.trabajador.findMany({
        include: { usuario: { include: { rol: true, oficio: { include: { oficio: true } } } } }
    })
    var count = 0;
    trabajadores.forEach(trabajador => {
        // const now = new Date(trabajador.membresia);
        // const fechaSinZona = now.toISOString.replace('T', ' ').split('.');
        // const membresia = fechaSinZona[0]
        // trabajadores[count].membresia = membresia
        trabajadores[count].usuario.pwd = "*****"
        count++;
    });
    res.json(trabajadores)
})

//Obtener todos los trabajadores disponibles o no disponibles depende lo que recibe
app.get('/trabajadores/disponibilidad/:disp', async (req, res) => {
    const { disp } = req.params
    var disponibilidad = new Boolean()
    if (String(disp) == "true") {
        disponibilidad = true
    } else if (String(disp) == "false") {
        disponibilidad = false
    }
    const trabajadores = await prisma.trabajador.findMany({
        where: { disponible: disponibilidad },
        include: { usuario: { include: { rol: true, oficio: { include: { oficio: true } } } } }
    })
    var count = 0;
    trabajadores.forEach(trabajador => {
        trabajadores[count].usuario.pwd = "*****"
        count++;
    });
    res.json(trabajadores)
})

//Obtener todos los trabajadores por oficio
app.get('/trabajadores/oficio/:idOf', async (req, res) => {
    const { idOf } = req.params
    const trabajadores = await prisma.oficioTrabajado.findMany({
        where: { idOficio: Number(idOf) }
    })
    var array = [];
    var contador = 0;
    for (const trabajador of trabajadores) {
        array[contador] = await prisma.trabajador.findFirst({
            where: { idUsuario: Number(trabajador.idTrabajador) },
            include: { usuario: { include: { rol: true, oficio: { include: { oficio: true } } } } }
        })
        contador++
    };

    res.json(array)
})
//Obtener lista de oficios
app.get('/oficios', async (req, res) => {
    const oficios = await prisma.oficio.findMany()
    res.json(oficios)
})

//Asignar varios oficios
app.post('/oficios', async (req, res) => {
    const body = req.body
    var resultados = new Array();
    for (let index = 0; index < body.length; index++) {
        const element = body[index];

        const resultado = await prisma.oficioTrabajado.create({
            data: {
                idOficio: element.idOficio, idTrabajador: element.idTrabajador
            }
        })
        resultados[index] = resultado
    }

    res.json(resultados)
})


//Eliminar una asignación de oficio
app.delete('/oficio/:idOA', async (req, res) => {
    idOficioAsig = req.params.idOA
    const { id } = req.body
    if (Number(idOficioAsig) !== Number(id)) {
        return res.status(400).json({ mensaje: 'No coinciden los id proporcionados' })
    }
    const resultado = prisma.oficioTrabajado.delete({
        where: { id: Number(idOficioAsig) }
    })
    res.json(resultado)
})

//Obtener lista de estados
app.get('/estados', async (req, res) => {
    const estados = await prisma.estado.findMany()
    res.json(estados)
})

//Agregar una dirección
app.post('/direccion', async (req, res) => {
    const { latitud, longitud, municipio, colonia, calle, cp, numeroExt, descripcion, idTrabajo } = req.body
    const resultado = await prisma.direccion.create({
        data: {
            latitud, longitud, municipio, colonia, calle, cp, numeroExt, descripcion, idTrabajo
        }
    })
    res.json(resultado);
})

//Obtener los trabajos de un trabajador por profesión
app.get('/trabajos/t', async (req, res) => {
    const { idTrab, idOfic } = req.query;
    const trabajos = await prisma.historialTrabajos.findMany({
        where: {
            idTrabajador: Number(idTrab),
            idOficio: Number(idOfic)
        },
        include: {
            trabajador: { include: { usuario: { include: { rol: true, oficio: { include: { oficio: true } } } } } },
            direcciones: true,
            usuario: { include: { rol: true, oficio: { include: { oficio: true } } } },
            // evidencias: true

        }
    });

    // Convertir latitud y longitud a números
    trabajos.forEach(trabajo => {
        trabajo.direcciones.forEach(direccion => {
            direccion.latitud = parseFloat(direccion.latitud);
            direccion.longitud = parseFloat(direccion.longitud);
        });
    });

    res.json(trabajos);
});


//Obtener los trabajos de un empleador
app.get('/trabajos/e', async (req, res) => {
    const { idEmp } = req.query
    const trabajos = await prisma.historialTrabajos.findMany({
        where: {
            idUsuario: Number(idEmp),
        },
        include: {
            trabajador: { include: { usuario: { include: { rol: true, oficio: { include: { oficio: true } } } } } },
            direcciones: true,
            usuario: { include: { rol: true, oficio: { include: { oficio: true } } } }
        }
    }
    )
    trabajos.forEach(trabajo => {
        trabajo.direcciones.forEach(direccion => {
            direccion.latitud = parseFloat(direccion.latitud);
            direccion.longitud = parseFloat(direccion.longitud);
        });
    });
    res.json(trabajos)
})


//Crear un nuevo trabajo
app.post('/trabajos', async (req, res) => {
    const { descripcion, costoTotal, idUsuario, idTrabajador, idOficio } = req.body
    const resultado = await prisma.historialTrabajos.create({
        data: {
            descripcion, costoTotal, idUsuario, idTrabajador, idOficio, idEstado: 1
        }
    })
    res.json(resultado);
})

//Actualizar un trabajo existente
app.put('/trabajos/:id', async (req, res) => {
    const idTrabajo = req.params.id
    const { id, descripcion, costoTotal, idUsuario, idTrabajador, idOficio, idEstado } = req.body
    if (Number(idTrabajo) !== Number(id)) {
        return res.status(400).json({ mensaje: 'No coinciden los id proporcionados' })
    }
    const resultado = await prisma.historialTrabajos.update({
        where: {
            id: Number(id)
        },
        data: {
            descripcion, costoTotal, idUsuario, idTrabajador, idOficio, idEstado
        }
    })
    res.json(resultado);
})



//Obtener la calificación de un trabajador por oficio
app.get('/calificacion', async (req, res) => {
    const { idTrab, idOfic } = req.query;
    var calificacion = null;
    const trabajos = await prisma.historialTrabajos.findMany({
        where: {
            idTrabajador: Number(idTrab),
            idOficio: Number(idOfic)
        },
        include: {
            comentarios: true
        }
    });
    let cont = 0;
    let cont1 = 0;

    if (trabajos.length === 0) {
        // Devolver calificación 0 si no hay trabajos registrados
        return res.status(200).json({ calificacion: 0 });
    }

    trabajos.forEach(trabajo => {
        trabajo.comentarios.forEach(comentario => {
            cont += comentario.calificacion;
            cont1++;
        });
    });

    if (cont1 === 0) {
        return res.status(404).json({ mensaje: "No existen calificaciones para este oficio" });
    }

    calificacion = cont / cont1;
    calificacionRedondeada = parseFloat(calificacion.toFixed(1));

    res.json({ calificacion: calificacionRedondeada }); // Devolver la calificación en ambos casos
});


//Obtener la calificación de un trabajador por trabajo
app.get('/calificacionT', async (req, res) => {
    const { id } = req.query
    var calificacion = null
    const trabajo = await prisma.historialTrabajos.findFirst({
        where: {
            id: Number(id)
        },
        include: {
            comentarios: true
        }
    }
    )
    let cont = 0
    let cont1 = 0
    if (trabajo == null) {
        return res.status(200).json({ calificacion: 0 })
    }
    trabajo.comentarios.forEach(comentario => {
        cont = cont + comentario.calificacion
        cont1 += 1
    })
    if (cont1 == 0) {
        return res.status(404).json({ mensaje: "No existen calificaciones para este oficio" })
    }
    calificacion = cont / cont1
    res.json(calificacion)
})

//Agregar un nuevo comentario
app.post('/comentario', async (req, res) => {
    const { mensaje, calificacion, idTrabajo } = req.body
    const resultado = await prisma.comentarios.create({
        data: {
            mensaje, calificacion, idTrabajo
        }
    })
    res.json(resultado);
})

//Consultar comentarios por trabajo
app.get('/comentarios/:idT', async (req, res) => {
    const { idT } = req.params
    const comentarios = await prisma.comentarios.findMany({
        where: { idTrabajo: Number(idT) }
    })
    res.json(comentarios)
})

//Consultar los comentarios por oficio
app.get('/comentarios/:idT/:idO', async (req, res) => {
    const { idT, idO } = req.params
    const trabajos = await prisma.historialTrabajos.findMany({
        where: {
            idTrabajador: Number(idT),
            idOficio: Number(idO)
        },
        include: {
            comentarios: { include: { imagen: true } },
            usuario: { include: { rol: true, oficio: { include: { oficio: true } } } }
        }
    })
    if (trabajos == null) {
        return res.status(404).json({ mensaje: "No se encontró ningun comentario" })
    }
    // const comentarios = trabajos.map(trabajo => {trabajo.comentarios, trabajo.usuario});
    res.json(trabajos);
})

//Obtiene la cantidad de calificaciónes por 1,2,4, y 5 estrellas
app.get('/comentariosContador/:idT/:idO', async (req, res) => {
    const { idT, idO } = req.params;

    const trabajos = await prisma.historialTrabajos.findMany({
        where: {
            idTrabajador: Number(idT),
            idOficio: Number(idO)
        },
        include: {
            comentarios: { include: { imagen: true } }
        }
    });

    if (!trabajos || trabajos.length === 0) {
        return res.json({ mensaje: "No se encontró ningún comentario", calificacionesContador: { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0 } });
    }

    const comentarios = [];
    const calificacionesContador = {
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0
    };

    for (const trabajo of trabajos) {
        for (const comentario of trabajo.comentarios) {
            comentarios.push(comentario);
            const calificacion = comentario.calificacion;
            if (calificacionesContador[calificacion] !== undefined) {
                calificacionesContador[calificacion] += 1;
            }
        }
    }

    // Calcula el total de calificaciones
    const totalCalificaciones = Object.values(calificacionesContador).reduce((total, count) => total + count, 0);

    // Calcula la relación de cada calificación
    const calificacionesRelativas = {};
    for (const [calificacion, count] of Object.entries(calificacionesContador)) {
        calificacionesRelativas[calificacion] = totalCalificaciones !== 0 ? count / totalCalificaciones : 0;
    }

    res.json({
        comentarios,
        calificacionesContador,
        calificacionesRelativas
    });
});

//Actualiar un comentario existente
app.put('/comentario/:id', async (req, res) => {
    const idQuery = req.params.id
    const { id, mensaje, calificacion, idTrabajo } = req.body
    if (Number(idQuery) !== Number(id)) {
        return res.status(400).json({ mensaje: 'No coinciden los id proporcionados' })
    }
    const resultado = await prisma.comentarios.update({
        where: { id: Number(id) },
        data: {
            mensaje, calificacion, idTrabajo
        }
    })
    res.json(resultado);
})


//Agregar evidencias de un trabajo
app.post('/evidencias', upload.single('foto'), async (req, res) => {
    // Convertir idTrabajo a entero
    const idTrabajo = parseInt(req.body.idTrabajo, 10);

    if (isNaN(idTrabajo)) {
        return res.status(400).json({ error: 'idTrabajo debe ser un número' });
    }

    let path = req.file.destination + '/' + req.file.filename;
    let fecha = new Date().toISOString();

    try {
        cloudinary.uploader.upload(path, { public_id: `${fecha}_${idTrabajo}` }, async (error, result) => {
            if (error) {
                return res.status(500).json({ error: 'Error al subir la imagen a Cloudinary' });
            }

            const resultado = await prisma.evidenciaTrabajos.create({
                data: { idImagen: result.url, idTrabajo: idTrabajo }
            });

            res.json(resultado);
        });
    } catch (error) {
        res.status(500).json({ error: 'Error al procesar la solicitud' });
    }
});

//Agregar evidencias de un trabajo
app.post('/imagenComent', upload.single('foto'), async (req, res) => {
    const { idComentario } = req.body;
    let path = req.file.destination + '/' + req.file.filename;
    let url = "";
    let fecha = new Date();
    cloudinary.uploader.upload(path,
        { public_id: fecha + idComentario },
        async (error, result) => {
            const resultado = await prisma.ImagenComentarios.create({
                data: { idImagen: result.url, idComentario: parseInt(idComentario, 10) }
            })
            res.json(resultado)
        })
})


//Obtener las evidencias de un trabajador
app.get('/evidencias/t/:idTrab', async (req, res) => {
    const { idTrab } = req.params
    const trabajos = await prisma.historialTrabajos.findMany({
        where: {
            idTrabajador: Number(idTrab)
        },
        include: {
            evidencias: true
        }
    })
    let evidencias = []
    let contador = 0
    trabajos.forEach(trabajo => {
        let ev = trabajo.evidencias
        ev.forEach(evidencia => {
            evidencias[contador] = evidencia
            contador++
        });
    });
    res.json(evidencias)
})
app.listen(3000)

console.log("Servidor activo")