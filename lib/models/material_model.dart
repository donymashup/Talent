class MaterialsModel {
  List<Materials>? materials;
  String? type;

  MaterialsModel({this.materials, this.type});

  MaterialsModel.fromJson(Map<String, dynamic> json) {
    if (json['materials'] != null) {
      materials = <Materials>[];
      json['materials'].forEach((v) {
        materials!.add(new Materials.fromJson(v));
      });
    }
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.materials != null) {
      data['materials'] = this.materials!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    return data;
  }
}

class Materials {
  String? batchMaterialsId;
  String? packageid;
  String? batchid;
  String? batchMaterialsStatus;
  String? materialListId;
  String? materialListName;
  String? materialListLink;
  String? materialListDescription;

  Materials(
      {this.batchMaterialsId,
      this.packageid,
      this.batchid,
      this.batchMaterialsStatus,
      this.materialListId,
      this.materialListName,
      this.materialListLink,
      this.materialListDescription});

  Materials.fromJson(Map<String, dynamic> json) {
    batchMaterialsId = json['batch_materials_id'];
    packageid = json['packageid'];
    batchid = json['batchid'];
    batchMaterialsStatus = json['batch_materials_status'];
    materialListId = json['material_list_id'];
    materialListName = json['material_list_name'];
    materialListLink = json['material_list_link'];
    materialListDescription = json['material_list_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batch_materials_id'] = this.batchMaterialsId;
    data['packageid'] = this.packageid;
    data['batchid'] = this.batchid;
    data['batch_materials_status'] = this.batchMaterialsStatus;
    data['material_list_id'] = this.materialListId;
    data['material_list_name'] = this.materialListName;
    data['material_list_link'] = this.materialListLink;
    data['material_list_description'] = this.materialListDescription;
    return data;
  }
}
