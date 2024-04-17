import 'package:flutter/material.dart';

void imagePickerModal(BuildContext context,
    {VoidCallback? onCameraTap, VoidCallback? onGalleryTap}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.indigo[200],
          padding: const EdgeInsets.all(20),
          height: 220,
          child: Column(
            children: [
              GestureDetector(
                onTap: onCameraTap,
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(color: Colors.indigo),
                    child: const Text("카메라", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: onGalleryTap,
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(color: Colors.indigo),
                    child: const Text("갤러리", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}