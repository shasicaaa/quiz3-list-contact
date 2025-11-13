import 'package:flutter/material.dart';
import 'pages/call_screen_page.dart';

// Blue-Gray Theme
const Color blueGrayPrimary = Color(0xFF4A6FA5);
const Color blueGrayAccent = Color(0xFF6B8CC1);
const Color blueGrayLight = Color(0xFFE8EEF7);
const Color blueGrayCard = Color(0xFFF5F7FC);

const Color darkBlueGrayPrimary = Color(0xFF2C3E50);
const Color darkBlueGraySurface = Color(0xFF34495E);
const Color darkBlueGrayBackground = Color(0xFF1A252F);

// Global notifier to control the app theme mode (Light / Dark / System)
final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(
  ThemeMode.system,
);

void main() {
  runApp(const ContactApp());
}

class ContactApp extends StatelessWidget {
  const ContactApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, themeMode, child) {
        return MaterialApp(
          title: 'Daftar Kontak',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(
                  seedColor: blueGrayPrimary,
                  brightness: Brightness.light,
                ).copyWith(
                  primary: blueGrayPrimary,
                  secondary: blueGrayAccent,
                  surface: blueGrayCard,
                ),
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              backgroundColor: blueGrayPrimary,
              foregroundColor: Colors.white,
              elevation: 5,
              shadowColor: blueGrayPrimary,
            ),
            cardTheme: CardThemeData(
              color: blueGrayCard,
              elevation: 8,
              shadowColor: blueGrayPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: blueGrayPrimary, width: 2),
              ),
            ),
            iconTheme: const IconThemeData(color: blueGrayPrimary),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.black87, fontFamily: 'Arial'),
              headlineSmall: TextStyle(
                color: blueGrayPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          darkTheme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(
                  seedColor: darkBlueGrayPrimary,
                  brightness: Brightness.dark,
                ).copyWith(
                  primary: darkBlueGrayPrimary,
                  secondary: blueGrayAccent,
                  surface: darkBlueGraySurface,
                ),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF2C3E50),
              foregroundColor: Colors.white,
              elevation: 5,
              shadowColor: Colors.black,
            ),
            cardTheme: CardThemeData(
              color: darkBlueGraySurface,
              elevation: 8,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: blueGrayAccent, width: 2),
              ),
            ),
            iconTheme: const IconThemeData(color: blueGrayAccent),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.white70),
              headlineSmall: TextStyle(
                color: blueGrayAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          themeMode: themeMode, // controlled by notifier
          home: const ContactListPage(),
        );
      },
    );
  }
}

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> contacts = [
      {
        'name': 'Jessie',
        'phone': '0812-1111-2222',
        'status': 'Online',
        'color': Colors.green,
        'photo': 'assets/jessie.jpg',
      },
      {
        'name': 'Woody',
        'phone': '0812-3333-4444',
        'status': 'Away',
        'color': Colors.orange,
        'photo': 'assets/woody.jpg',
      },
      {
        'name': 'Buzz L',
        'phone': '0812-5555-6666',
        'status': 'Offline',
        'color': Colors.grey,
        'photo': 'assets/buzz.jpg',
      },
      {
        'name': 'Rex',
        'phone': '0812-7777-8888',
        'status': 'Online',
        'color': Colors.green,
        'photo': 'assets/rex.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daftar Kontak",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: blueGrayPrimary,
        actions: [
          PopupMenuButton<ThemeMode>(
            tooltip: 'Pilih Tema',
            onSelected: (mode) => themeModeNotifier.value = mode,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: ThemeMode.light,
                child: Text('Terang'),
              ),
              const PopupMenuItem(value: ThemeMode.dark, child: Text('Gelap')),
              const PopupMenuItem(
                value: ThemeMode.system,
                child: Text('Sistem'),
              ),
            ],
            icon: const Icon(Icons.color_lens),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 4,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(contact['photo'] as String),
                backgroundColor: blueGrayAccent,
                child: contact['photo'] == null
                    ? Text(
                        (contact['name'] as String)[0],
                        style: const TextStyle(
                          color: blueGrayPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              title: Text(
                contact['name'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 10,
                    color: contact['color'] as Color,
                  ),
                  const SizedBox(width: 5),
                  Text(contact['status'] as String),
                  const SizedBox(width: 10),
                  Text(contact['phone'] as String),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.call),
                color: blueGrayPrimary,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CallScreenPage(contact: contact),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
