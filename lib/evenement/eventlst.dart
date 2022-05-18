import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api/server_config.dart';

class listEvent extends StatelessWidget {

  fetchEvent() async {
    http.Response url;
    url = await http.get((
        Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/event/"))
        ,headers: {"Content-Type": "application/json","Accept": "application/json"});
    return json.decode(url.body)['results'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Evenements',
          style: TextStyle(fontSize: 25.0, color: Color(0xfff62323)),
        ),
        elevation: 0.0,
        backgroundColor: const Color(0xff191826),
      ),
      body: FutureBuilder(
          future: fetchEvent(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.toString(),)
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Container(
                        height: 250,
                        alignment: Alignment.centerLeft,
                        child: Card(
                          child: Image.network(snapshot.data[index]['image']),
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                snapshot.data[index]["event_name"],
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data[index]["date"],
                                style: const TextStyle(color: Color(0xff868597)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 100,
                                child: Text(
                                  snapshot.data[index]["descriptionevent"],
                                  style: const TextStyle(color: Color(0xff868597)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
