import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import "package:google_fonts/google_fonts.dart";
void main(){
  runApp(MaterialApp(home:IntroCard()),);
}
// Make sure you've imported:  import 'package:google_fonts/google_fonts.dart';

class IntroCard extends StatefulWidget {
  const IntroCard({super.key});

  @override
  State<IntroCard> createState() => _IntroCardState();
}

class _IntroCardState extends State<IntroCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: double.infinity,              // take full width
      child: Card(
        color: Colors.deepPurple,
        shape: RoundedRectangleBorder(     // rounded corners for a softer look
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),

            // 1. Hero / logo image – replace with a real URL or an AssetImage
            Image.network(
              'https://openweathermap.org/img/wn/10d@4x.png',
              height: 140,
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.image_not_supported, size: 80, color: Colors.white70),
            ),

            const SizedBox(height: 16),

            // 2. Balloon‑style headline
            Text(
              'Weather Forecasts',
              style: GoogleFonts.bubblegumSans(
                fontSize: 28,
                color: Colors.yellow,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),


            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,   // text & splash color
                side: const BorderSide(color: Colors.black12),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Home()),
                );
              },
              child: const Text('Get Started', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
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
          weather="🌡️ $temp°C\n☁️$condition\n💧 Humidity $humidity%'";
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
        title:Text("Weather App",style:GoogleFonts.bubblegumSans(fontSize: 20,color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: const [Icon(Icons.cloud_outlined,color:Colors.white)],

      ),
      body:Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF7F7FD5), Color(0xFF86A8E7), Color(0xFF91EAE4)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(50),
          child:Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border:OutlineInputBorder(
                    borderSide: BorderSide(

                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Enter a City Name",
                  prefixIcon: Icon(Icons.location_city_outlined),
                ),
              ),
              SizedBox(height:20),
              ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  ),
                  onPressed: (){
                    search();
                  }, child: Text("Search")),
              SizedBox(height:20),
              if (weather.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [BoxShadow(blurRadius: 12, color: Colors.black26)],
                  ),
                  child: Text(
                    weather,
                    style: GoogleFonts.poppins(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
