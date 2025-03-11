import 'package:alpha/features/subscribed_courses/screen/pdfview_screen.dart';
import 'package:alpha/models/material_model.dart';
import 'package:flutter/material.dart';

class MaterialsSectionWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Future<MaterialsModel?> fetchFunction;

  const MaterialsSectionWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.fetchFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(),
            FutureBuilder<MaterialsModel?>(
              future: fetchFunction,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData ||
                    snapshot.data!.materials!.isEmpty) {
                  return const Text("No Data Available",
                      style: TextStyle(color: Colors.grey));
                }

                return _buildMaterialList(snapshot.data!.materials!);
              },
            ),
            const SizedBox(height: 12), // Space after section
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      children: [
        Icon(icon, color: Colors.red),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildMaterialList(List<Materials> materials) {
    return ListView.builder(
      shrinkWrap: true, // so that it takes minimal space
      physics:
          const NeverScrollableScrollPhysics(), // disable scrolling inside Column
      itemCount: materials.length,
      itemBuilder: (context, index) {
        final material = materials[index];
        return GestureDetector(
          onTap: () {
            // Open the PDF viewer screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PDFViewerPage(
                  pdfId: material.materialListId ?? "",
                  pdfPath: material.materialListLink ?? "",
                  materialName: material.materialListName ?? "",
                ),
              ),
            );
          },
          child: Padding(
            padding:
                const EdgeInsets.only(right: 2, top: 4, bottom: 4, left: 2),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            material.materialListName ?? "Material",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            material.materialListDescription ??
                                "No description available",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
