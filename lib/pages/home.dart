import 'dart:convert';
import 'package:apiproduct/model/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Future <ProductModel> fetchdata()async{
      final response=await http.get(Uri.parse("https://webhook.site/9c3de317-ef20-4e42-8489-c38c05779912"));
      var data=jsonDecode(response.body.toString());
      // print(data.toString());
      if(response.statusCode==200){
        return ProductModel.fromJson(data);
      }
      else{
        return ProductModel.fromJson(data);
      }

    }
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ProductModel>(
                future: fetchdata(),
                builder: (context,snapshot){
                  if(snapshot.hasData)
                    {
                      return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context,index){
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: snapshot.data!.data![index].products!.length,
                            itemBuilder: (context,subindex){
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(snapshot.data!.data![index].name.toString()),
                                    subtitle: Text(snapshot.data!.data![index].shopemail.toString()),
                                    leading:CircleAvatar(backgroundImage: NetworkImage(snapshot.data!.data![index].image.toString()),) ,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height*0.33,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      physics:BouncingScrollPhysics(),
                                      shrinkWrap: false,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.data![index].products![subindex].images!.length,
                                      itemBuilder: (context,imgindex){
                                        return
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                            child: Image.network(snapshot.data!.data![index].products![subindex].images![imgindex].url.toString()),
                                        ),
                                          );
                                      },
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                      );
                    }
                  else{
                    return Text("data is not there");
                  }
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
