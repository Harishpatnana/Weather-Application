import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:convert";
void main(){
  runApp(MaterialApp(home:Home()),);
}
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controller= TextEditingController();
  String weather='';
  void search()async{
    String city=_controller.text.trim();
    if(city.isEmpty){
      showError("City not found");
      return;
    }
    String apiKey="d902a81159f301e0a022d334c9e5e007";
    String url="https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";
    try{
      final  response=await http.get(Uri.parse(url));
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final temp=data['main']['temp'];
        final condition=data['weather'][0]['description'];
        final humidity=data['main']['humidity'];
        setState(() {
          weather="Temperature: $temp Celsius\n Condition: $condition\n Humidity: $humidity";
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Weather Report"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network('https://openweathermap.org/img/wn/${data['weather'][0]['icon']}@2x.png'),
                Text("$weather"),

              ],
            ),
            actions: [

              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
        );
      }
      else{
        showError("City not found");
      }
    }
    catch(e){
      showError("No data Found");
    }

  }
  void showError(String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Weather App"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body:Padding(
        padding: EdgeInsets.all(50),
        child:Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border:OutlineInputBorder(),
                labelText: "Enter a City Name",
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height:20),
            ElevatedButton(onPressed: (){
              search();
            }, child: Text("Search")),
            SizedBox(height:10),


          ],
        ),
      ),
    );
  }
}
