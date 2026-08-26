import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "🍳 cookpad",
            style: TextStyle(
              color: Color.fromARGB(255, 207, 142, 44),
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: const [
            Icon(Icons.person, color: Colors.grey),
            SizedBox(width: 10),
            Icon(Icons.notifications_none, color: Colors.grey),
          ],
        ),

        body: Column(
          children: [
            // Search
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Ketik bahan-bahan...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // Banner
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 120,
              width: double.infinity,
              color: Colors.orange[50],
              alignment: Alignment.center,
              child: const Text(
                "ANEKA GORENGAN",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Judul
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pencarian Populer",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Diperbarui 04.30 karena waktunya KOPAG",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Grid
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(10),
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6EoVEfuiC0popmi5kR5T9Daci2eHROQcRvFjdUMkl-eHRnB7y0Nf9U8Q&s=10",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6EoVEfuiC0popmi5kR5T9Daci2eHROQcRvFjdUMkl-eHRnB7y0Nf9U8Q&s=10",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),

                      Positioned(
                        bottom: 10,
                        left: 8,
                        right: 0,
                        child: Text(
                          'Soto',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
