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
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetPermainan,
            tooltip: 'Mulai Ulang',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Skor
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Anda',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$_skorUser',
                      style: TextStyle(fontSize: 40, color: Colors.blue),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Komputer',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$_skorKomputer',
                      style: TextStyle(fontSize: 40, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            // Pilihan
            Text(
              'Pilihan Anda: $_pilihanUser',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Pilihan Komputer: $_pilihanKomputer',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            // Hasil
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: Text(
                _hasil,
                key: ValueKey(_hasil),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: _getHasilColor(),
                ),
              ),
            ),
            SizedBox(height: 30),
            // Tombol Pilihan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildChoiceButton('Gunting', Icons.cut, _pilihGunting),
                _buildChoiceButton('Batu', Icons.landscape, _pilihBatu),
                _buildChoiceButton('Kertas', Icons.article, _pilihKertas),
              ],
            ),
            SizedBox(height: 20),
            if (_berhenti)
              ElevatedButton(
                onPressed: _resetPermainan,
                child: Text(
                  'Mulai Ulang',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceButton(String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: _berhenti ? null : onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 40),
          SizedBox(height: 10),
          Text(label, style: TextStyle(fontSize: 16)),
        ],
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
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