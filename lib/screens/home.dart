import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagegenerator/controllers/image_generator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImageController _imageController = Get.put(ImageController());
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Image to generate",
                      contentPadding: EdgeInsets.all(20)),
                ),
              ),
              const SizedBox(width: 20),
              Obx(
                () => _imageController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          await _imageController.getImage(
                              imageText: _textEditingController.text.trim());
                        },
                        child: const Text("Create"),
                      ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
          Obx(
            () => _imageController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    height: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: _imageController.data.value.isNotEmpty
                                ? NetworkImage(_imageController.data.value)
                                : const NetworkImage('https://oaidalleapiprodscus.blob.core.windows.net/private/org-c9qD6NIHZm0Qxrc5IrE4l71g/user-Sv4qxAepSJtaYZOUXZpN46rh/img-zLx65HSW1BfUq4Y0QNwP8B9m.png?st=2022-12-16T19%3A00%3A19Z&se=2022-12-16T21%3A00%3A19Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2022-12-16T19%3A35%3A07Z&ske=2022-12-17T19%3A35%3A07Z&sks=b&skv=2021-08-06&sig=douVsnxykkC9D5OGROvByQXVoXAG33oIL11VOrfEqA4%3D'))),
                  ),
          ),
        ],
      ),
    );
  }
}
