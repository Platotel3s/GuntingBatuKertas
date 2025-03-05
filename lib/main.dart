import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gunting Batu Kertas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String _pilihanUser = '';
  String _pilihanKomputer = '';
  String _hasil = '';
  int _skorUser = 0;
  int _skorKomputer = 0;
  bool _berhenti = false;

  void _pilihGunting() {
    if (!_berhenti) {
      setState(() {
        _pilihanUser = 'Gunting';
        _pilihanKomputer = _generatePilihanKomputer();
        _hasil = _determineHasil();
        _updateSkor();
      });
    }
  }

  void _pilihBatu() {
    if (!_berhenti) {
      setState(() {
        _pilihanUser = 'Batu';
        _pilihanKomputer = _generatePilihanKomputer();
        _hasil = _determineHasil();
        _updateSkor();
      });
    }
  }

  void _pilihKertas() {
    if (!_berhenti) {
      setState(() {
        _pilihanUser = 'Kertas';
        _pilihanKomputer = _generatePilihanKomputer();
        _hasil = _determineHasil();
        _updateSkor();
      });
    }
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

  void _updateSkor() {
    if (_hasil == 'Anda menang!') {
      _skorUser++;
    } else if (_hasil == 'Komputer menang!') {
      _skorKomputer++;
    }

    // Cek apakah permainan berhenti (misalnya, jika skor mencapai 5)
    if (_skorUser == 5 || _skorKomputer == 5) {
      _berhenti = true;
    }
  }

  void _resetPermainan() {
    setState(() {
      _pilihanUser = '';
      _pilihanKomputer = '';
      _hasil = '';
      _skorUser = 0;
      _skorKomputer = 0;
      _berhenti = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gunting Batu Kertas'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetPermainan,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Skor Anda: $_skorUser',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Skor Komputer: $_skorKomputer',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Pilihan Anda: $_pilihanUser',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Pilihan Komputer: $_pilihanKomputer',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Hasil: $_hasil',
              style: TextStyle(fontSize: 24, color: _getHasilColor()),
            ),
            SizedBox(height: 20),
            if (_berhenti)
              Text(
                'Permainan Berakhir!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _berhenti ? null : _pilihGunting,
                  child: Text('Gunting'),
                ),
                ElevatedButton(
                  onPressed: _berhenti ? null : _pilihBatu,
                  child: Text('Batu'),
                ),
                ElevatedButton(
                  onPressed: _berhenti ? null : _pilihKertas,
                  child: Text('Kertas'),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (_berhenti)
              ElevatedButton(
                onPressed: _resetPermainan,
                child: Text('Mulai Ulang'),
              ),
          ],
        ),
      ),
    );
  }

  Color _getHasilColor() {
    if (_hasil == 'Anda menang!') {
      return Colors.green;
    } else if (_hasil == 'Komputer menang!') {
      return Colors.red;
    } else {
      return Colors.orange;
    }
  }
}