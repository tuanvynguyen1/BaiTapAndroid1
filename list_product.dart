import 'package:flutter/material.dart';
import 'package:product/product.dart';

class ListProduct extends StatelessWidget {
  const ListProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListViewProduct(),
    );
  }
}

class ListViewProduct extends StatefulWidget {
  const ListViewProduct({Key? key}) : super(key: key);

  @override
  _ListViewProductState createState() => _ListViewProductState();
}

class _ListViewProductState extends State<ListViewProduct> {
  late Future<List<product>> dsproduct;
  var fKey = GlobalKey<FormState>();
  var num = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dsproduct = product.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sản phẩm'),
      ),
      body: FutureBuilder(
        future: dsproduct,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (BuildContext context, int index) {
                product p = data[index];
                return Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: ListTile(
                      leading: Image.network(
                        p.image,
                        width: 40,
                      ),
                      title: Text(p.title),
                      trailing: ElevatedButton(
                        onPressed: () {
                          var dialog = AlertDialog(
                            title:
                              Text("Nhập số lượng"),
                            content: TextField(
                              onChanged: (value) {},
                              controller: num,
                              decoration: InputDecoration(
                                  hintText: "Nhập số lượng "),
                            ),
                            actions: [
                              FlatButton(
                                onPressed: () {},
                                child: Text("Không mua"),
                              ),
                              FlatButton(
                                  onPressed: () {}, child: Text("Quất luôn"))
                            ],
                          );
                          showDialog(
                              context: context,
                              builder: (context) {
                                return dialog;
                              });
                        },
                        child: Text("Mua"),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
