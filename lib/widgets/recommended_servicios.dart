import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ofimex/models/trabajador_list_data.dart';


class RecommendedServicos extends StatelessWidget {
  bool? isWeb;
  RecommendedServicos({Key? key, this.isWeb = false}) : super(key: key);
  List<TrabjadorListData> listTrabajador = TrabjadorListData.listTrabajador;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 235,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 220,
              child: Card(
                elevation: 0.4,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {

                    if(isWeb! == true){

                    Navigator.pushNamed(context,"/datailTrabajadorWeb",arguments: listTrabajador[index]); 
                    }else{
                    Navigator.pushNamed(context,"/datailTrabajadorMobile",arguments: listTrabajador[index]); 
                    }
                    
                    
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            listTrabajador[index].imagePath,
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                            height: 150,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                             Text(
                              listTrabajador[index].titleTxt,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.star,
                              color: Colors.yellow.shade700,
                              size: 14,
                            ),
                             Text(
                              "${listTrabajador[index].rating}",
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Ionicons.location,
                              color: Theme.of(context).primaryColor,
                              size: 16,
                            ),
                            const SizedBox(width: 5),
                             Text(
                              listTrabajador[index].subTxt,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.only(right: 10),
              ),
          itemCount: listTrabajador.length),
    );
  }
}
