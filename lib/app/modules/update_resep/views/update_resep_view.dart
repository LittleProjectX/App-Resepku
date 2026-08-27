import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:seleraku/app/core/constants/recipe_category.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/utils/loading_page.dart';
import 'package:seleraku/app/core/utils/unknow_page.dart';
import 'package:seleraku/app/core/widgets/buttons/button_back.dart';
import 'package:seleraku/app/core/widgets/buttons/large_button.dart';
import 'package:seleraku/app/core/widgets/buttons/secondary_large_button.dart';
import 'package:seleraku/app/core/widgets/textfields/main_field.dart';
import 'package:seleraku/app/core/widgets/textfields/multi_field.dart';
import 'package:seleraku/app/core/widgets/texts/build_label.dart';
import 'package:seleraku/app/modules/addResep/views/widgets/button_add_resep.dart';

import '../controllers/update_resep_controller.dart';

class UpdateResepView extends GetView<UpdateResepController> {
  const UpdateResepView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.pageLoading.value) {
        return Scaffold(body: loadingPage());
      }

      if (controller.resepData.value == null) {
        return Scaffold(body: UnknowPage());
      }

      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Align(
                    alignment: AlignmentGeometry.topLeft,
                    child: ButtonCircle(
                      onTap: () => Get.back(),
                      icon: Icons.arrow_back,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Center(
                    child: Text('Tambah Resep', style: AppTextStyle.heading2),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 32,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildLabel('Gambar'),
                            IconButton(
                              onPressed: () => controller.isNewImage.value
                                  ? controller.longestImage = ''
                                  : controller.selectedFile.value = null,
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () => controller.pickImage(),
                          child: Obx(
                            () => Container(
                              width: double.infinity,
                              height: 180,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(24),
                                border: BoxBorder.all(
                                  color: AppColors.border,
                                  width: 2,
                                ),
                              ),
                              child: controller.isNewImage.value == false
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(24),
                                      child: Image.network(
                                        controller.longestImage,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.medium,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Image.asset(
                                                'assets/images/no_image.jpg',
                                                fit: BoxFit.cover,
                                                filterQuality:
                                                    FilterQuality.low,
                                              );
                                            },
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value:
                                                  loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(24),
                                      child: Image.file(
                                        controller.selectedFile.value!,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.medium,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        buildLabel('Judul'),
                        BuildMainField(
                          hintText: 'Judul Resep',
                          controller: controller.title,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Judul tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        buildLabel('Kategori'),
                        DropdownButtonFormField<String>(
                          items: category.map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category, style: AppTextStyle.body2),
                            );
                          }).toList(),
                          initialValue: controller.category.value,
                          onChanged: (value) {
                            controller.category.value = value.toString();
                          },
                        ),
                        const SizedBox(height: 16),
                        buildLabel('Porsi'),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (controller.intPortion.value > 1) {
                                  controller.intPortion.value--;
                                }
                              },
                              child: Text('-', style: AppTextStyle.body6),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              height: 50,
                              padding: EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Center(
                                child: Obx(
                                  () => Text(
                                    controller.intPortion.toString(),
                                    style: AppTextStyle.body2,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () => controller.intPortion++,
                              child: Text('+', style: AppTextStyle.body6),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        buildLabel('Deskripsi'),
                        BuildMultiField(
                          hintText: 'Keterangan Resep',
                          minLines: 3,
                          controller: controller.description,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Masukkan deskripsi resep";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        buildLabel('Bahan Utama'),
                        Row(
                          children: [
                            Expanded(
                              child: BuildMainField(
                                hintText: 'Bahan Utama',
                                controller: controller.mainIngredient,
                                validator: (value) {
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 90,
                              child: BuildMainField(
                                hintText: 'Jmlh',
                                controller: controller.mainIngredientAmount,
                                validator: (value) {
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => controller.clearMainIngredient(),
                              child: Text('Batal', style: AppTextStyle.button3),
                            ),
                            const SizedBox(width: 12),
                            buildButtonAddResep(() {
                              if (controller.isMainIng.value) {
                                controller.updateMainIngredient(
                                  controller.mainIndex,
                                  controller.mainIngredient.text,
                                  controller.mainIngredientAmount.text,
                                  controller.mainTime,
                                );
                                controller.isMainIng.value = false;
                              } else {
                                controller.addMainIngredient(
                                  controller.mainIngredient.text,
                                  controller.mainIngredientAmount.text,
                                );
                              }
                            }),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Obx(
                          () => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            width: double.infinity,
                            height: 200,
                            child: controller.listMainIngredient.isEmpty
                                ? Text(
                                    'Belum ada data',
                                    style: AppTextStyle.body2,
                                  )
                                : ListView.builder(
                                    itemCount:
                                        controller.listMainIngredient.length,
                                    itemBuilder: (context, index) {
                                      final dataMainIngredient =
                                          controller.listMainIngredient[index];

                                      return InkWell(
                                        onTap: () {
                                          controller.mainIngredient.text =
                                              dataMainIngredient.ingredient;
                                          controller.mainIngredientAmount.text =
                                              dataMainIngredient.amount;
                                          controller.mainTime =
                                              dataMainIngredient.createdAt;
                                          controller.isMainIng.value = true;
                                          controller.mainIndex = index;
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${index + 1}. ${dataMainIngredient.ingredient}  ${dataMainIngredient.amount}',
                                                style: AppTextStyle.body2,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                controller
                                                    .deleteListMainIngredient(
                                                      index,
                                                    );
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),

                        const SizedBox(height: 16),
                        buildLabel('Bahan Tambahan'),
                        Row(
                          children: [
                            Expanded(
                              child: BuildMainField(
                                hintText: 'Bahan Tambahan',
                                controller: controller.additive,
                                validator: (value) {
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 90,
                              child: BuildMainField(
                                hintText: 'Jmlh',
                                controller: controller.additiveAmount,
                                validator: (value) {
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => controller.clearAdditive(),
                              child: Text('Batal', style: AppTextStyle.button3),
                            ),
                            const SizedBox(width: 12),
                            buildButtonAddResep(() {
                              if (controller.isAddittive.value) {
                                controller.updateAdditive(
                                  controller.additiveIndex,
                                  controller.additive.text,
                                  controller.additiveAmount.text,
                                  controller.additiveTime,
                                );
                                controller.isAddittive.value = false;
                              } else {
                                controller.addAdditive(
                                  controller.additive.text,
                                  controller.additiveAmount.text,
                                );
                              }
                            }),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Obx(
                          () => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            width: double.infinity,
                            height: 200,
                            child: controller.listAdditiveIngredient.isEmpty
                                ? Text(
                                    'Belum ada data',
                                    style: AppTextStyle.body2,
                                  )
                                : ListView.builder(
                                    itemCount: controller
                                        .listAdditiveIngredient
                                        .length,
                                    itemBuilder: (context, index) {
                                      final dataAdditive = controller
                                          .listAdditiveIngredient[index];

                                      return InkWell(
                                        onTap: () {
                                          controller.additive.text =
                                              dataAdditive.ingredient;
                                          controller.additiveAmount.text =
                                              dataAdditive.amount;
                                          controller.additiveTime =
                                              dataAdditive.createdAt;
                                          controller.isAddittive.value = true;
                                          controller.additiveIndex = index;
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${index + 1}. ${dataAdditive.ingredient}  ${dataAdditive.amount}',
                                                style: AppTextStyle.body2,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                controller
                                                    .deleteListMainIngredient(
                                                      index,
                                                    );
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        buildLabel('Tutorial'),
                        BuildMainField(
                          hintText: 'Tutorial Memasak',
                          controller: controller.tutorial,
                          validator: (value) {
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => controller.clearTutorial(),
                              child: Text('Batal', style: AppTextStyle.button3),
                            ),
                            const SizedBox(width: 12),
                            buildButtonAddResep(() {
                              if (controller.isTutorial.value) {
                                controller.updateTutorial(
                                  controller.tutorialIndex,
                                  controller.tutorial.text,
                                  controller.tutorialTime,
                                );
                                controller.isTutorial.value = false;
                              } else {
                                controller.addTutorial(
                                  controller.tutorial.text,
                                );
                              }
                            }),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Obx(
                          () => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            width: double.infinity,
                            height: 200,
                            child: controller.listTutorial.isEmpty
                                ? Text(
                                    'Belum ada data',
                                    style: AppTextStyle.body2,
                                  )
                                : ListView.builder(
                                    itemCount: controller.listTutorial.length,
                                    itemBuilder: (context, index) {
                                      final dataTutorial =
                                          controller.listTutorial[index];

                                      return InkWell(
                                        onTap: () {
                                          controller.tutorial.text =
                                              dataTutorial.tutorial;
                                          controller.tutorialTime =
                                              dataTutorial.createdAt;
                                          controller.isTutorial.value = true;
                                          controller.tutorialIndex = index;
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${index + 1}. ${dataTutorial.tutorial}',
                                                style: AppTextStyle.body2,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                controller.removeTutorial(
                                                  index,
                                                );
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),

                        const SizedBox(height: 24),
                        buildLargeButton(
                          label: 'Simpan',
                          isLoading: controller.isLoading.value,
                          onTap: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.updateReseptoFirebase(
                                controller.resepData.value!.uId,
                                controller.resepData.value!.rId,
                                controller.title.text,
                                controller.description.text,
                                controller.category.value,
                                controller.intPortion.value.toString(),
                                controller.listMainIngredient,
                                controller.listAdditiveIngredient,
                                controller.listTutorial,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        SecondaryLargeButton(
                          label: 'Batal',
                          onTap: () => controller.clearField(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
