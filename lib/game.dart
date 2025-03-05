import 'package:flutter/material.dart';
import 'dart:math';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String _pilihanUser = '';
  String _pilihanKomputer = '';
  String _hasil = '';

  void _pilihGunting() {
    setState(() {
      _pilihanUser = 'Gunting';
      _pilihanKomputer = _generatePilihanKomputer();
      _hasil = _determineHasil();
    });
  }

  void _pilihBatu() {
    setState(() {
      _pilihanUser = 'Batu';
      _pilihanKomputer = _generatePilihanKomputer();
      _hasil = _determineHasil();
    });
  }

  void _pilihKertas() {
    setState(() {
      _pilihanUser = 'Kertas';
      _pilihanKomputer = _generatePilihanKomputer();
      _hasil = _determineHasil();
    });
  }

  String _generatePilihanKomputer() {
    List<String> pilihan = ['Gunting', 'Batu', 'Kertas'];
    return pilihan[Random().nextInt(pilihan.length)];
  }

  String _determineHasil() {
    if (_pilihanUser == _pilihanKomputer) {
      return 'Seri!';
    } else if (_pilihanUser == 'Gunting' && _pilihanKomputer == 'Kertas') {
      return 'Anda menang!';
    } else if (_pilihanUser == 'Batu' && _pilihanKomputer == 'Gunting') {
      return 'Anda menang!';
    } else if (_pilihanUser == 'Kertas' && _pilihanKomputer == 'Batu') {
      return 'Anda menang!';
    } else {
      return 'Komputer menang!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gunting Batu Kertas')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pilihan Anda: $_pilihanUser', style: TextStyle(fontSize: 24)),
            Text(
              'Pilihan Komputer: $_pilihanKomputer',
              style: TextStyle(fontSize: 24),
            ),
            Text('Hasil: $_hasil', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _pilihGunting,
                  child: Text('Gunting'),
                ),
                ElevatedButton(onPressed: _pilihBatu, child: Text('Batu')),
                ElevatedButton(onPressed: _pilihKertas, child: Text('Kertas')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}