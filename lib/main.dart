import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MinhaLista(),
    );
  }
}

class Formulario extends StatefulWidget {
  @override
  FormularioState createState() => FormularioState();
}

class FormularioState extends State<Formulario> {
  final itemController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextFormField(
                controller: itemController,
                onSaved: (item) {
                  itemController.text = item!;
                },
                validator: (item) {
                  if (item!.isEmpty) {
                    return 'Esse campo é obrigatório!';
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.of(context).pop(itemController.text);
                  }
                },
                child: Text('Salvar'),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class Tasks {
  String itens;
  Tasks(this.itens);
}

class MinhaLista extends StatefulWidget {
  @override
  _MinhaListaState createState() => _MinhaListaState();
}

class _MinhaListaState extends State<MinhaLista> {
  final List<Tasks> itens = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: itens.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${index + 1} - ${itens[index].itens}',
                    style: TextStyle(fontSize: 25)),
                Divider(
                  height: 50,
                  thickness: 1.5,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => Formulario(),
            ),
          )
              .then((value) {
            setState(() {
              itens.add(Tasks(value));
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
