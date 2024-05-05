// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:ofimex/models/service.dart';
import 'package:provider/provider.dart';

class HomeServicesPage extends StatefulWidget {
  const HomeServicesPage({super.key});

  @override
  State<HomeServicesPage> createState() => _HomeServicesPageState();
}

class _HomeServicesPageState extends State<HomeServicesPage> {
  List<Service> services = [
    Service(
        'Baches', 'https://cdn-icons-png.flaticon.com/512/3410/3410124.png'),
    Service('Faros', 'https://cdn-icons-png.flaticon.com/512/2983/2983631.png'),
    Service('Poste', 'https://cdn-icons-png.flaticon.com/512/2824/2824713.png'),
    Service('Luz', 'https://cdn-icons-png.flaticon.com/512/4178/4178539.png'),
    Service('Arboles',
        'https://cdn0.iconfinder.com/data/icons/trees-5/100/23-1024.png'),
    Service(
        'Basura', 'https://cdn-icons-png.flaticon.com/512/4380/4380445.png'),
    Service('Bad Parking',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Singapore_Road_Signs_-_Restrictive_Sign_-_No_Parking.svg/1200px-Singapore_Road_Signs_-_Restrictive_Sign_-_No_Parking.svg.png'),
    Service('Alcantarilla',
        'https://firebasestorage.googleapis.com/v0/b/iq6b-2024-arc.appspot.com/o/reportesImg%2Fa139a657d87c9a6ee6d5dd8613b0205c.png?alt=media&token=81087034-0a56-4d88-8013-b07f7c7bf8d4'),
    Service('Agua', 'https://cdn-icons-png.flaticon.com/512/1503/1503681.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Inicio',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              // await FirebaseAuth.instance.signOut();
              // if(FirebaseAuth.instance.currentUser == null){
              //   Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
              // }
            },
            icon: Icon(
              Icons.logout,
              color: Colors.grey.shade700,
              size: 30,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categorias',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 350,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: services.length,
                    itemBuilder: (BuildContext context, int index) {
                      return serviceContainer(services[index].imageURL,
                          services[index].name, index);
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/agregarReporte");
                  },
                  child: Container(
                    height: 50,
                    width: 220,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(25.0)),
                    child: const Center(
                      child: Text(
                        "Realizar reporte",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Todos los reportes',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  serviceContainer(String image, String name, int index) {
    return GestureDetector(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.only(right: 20),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border.all(
              color: Colors.blue.withOpacity(0),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(image, height: 45),
              const SizedBox(
                height: 15,
              ),
              Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
