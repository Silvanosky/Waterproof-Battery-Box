# **🔋 Universal Waterproof Battery Box (100% TPU)**

This project provides a fully parametric OpenSCAD model to generate and 3D print waterproof protection boxes for your batteries (18650, 21700, AA, AAA, etc.).  
**The unique feature of this design is that it is specifically designed to be printed in TPU (flexible filament).** Because the material itself acts as a seal, the box integrates a "double radial seal" system (ridges and grooves) directly into its geometry, eliminating the need to buy and add external O-rings.

## **🌟 Features**

* 💧 **100% TPU Printable**: No external O-ring required. Waterproofing is achieved by the compression of the TPU itself.  
* 🛡️ **Integrated Double Radial Seal**: Two compression rings on the flange guarantee an impenetrable barrier to water.  
* 📏 **Universal and Parametric**: Easily select your battery size in OpenSCAD (18650, 20700, 21700, 26650, AA, AAA) or enter your own custom dimensions.  
* 🪶 **Optimized Weight and Time**: The walls are exactly 1.6mm thick. With a standard 0.4mm nozzle, this perfectly matches 4 perimeters, the ideal ratio to ensure waterproofing without wasting material.  
* 🤲 **Textured Grip**: The body and cap feature a "diamond" (knurled) texture for easy opening/closing, even with wet hands or gloves.

## **🛠️ Prerequisites**

To open, modify, and compile this model, you need:

1. **OpenSCAD** (version 2021.01 or newer recommended).  
2. **The BOSL2 library** installed in your OpenSCAD environment.  
   * *BOSL2 Installation*: Download the library from the official [BOSL2 GitHub](https://github.com/BelfrySCAD/BOSL2) and place the BOSL2 folder in your OpenSCAD libraries folder (Documents/OpenSCAD/libraries/ on Windows/Mac, or \~/.local/share/OpenSCAD/libraries/ on Linux).

## **🚀 Usage (OpenSCAD Customizer)**

1. Open the Waterproof\_Battery\_Box.scad file in OpenSCAD.  
2. Show the **Customizer** window (Menu Window \> Uncheck Hide Customizer).  
3. **Select your battery**: Use the dropdown menu to choose a standard format.  
4. **Display Mode (part)**:  
   * cut: Shows a simulated cross-section view to check the seal fit. *(Recommended for visualizing the design).*  
   * both: Shows both the box and the cap oriented correctly for 3D printing.  
   * box: Shows only the box body to generate the STL.  
   * cap: Shows only the cap to generate the STL.  
5. Press **F6** to render, then click on **"Export as STL"**.

## **🖨️ Printing Recommendations (CRITICAL)**

The design isn't everything. If the print layers aren't perfectly fused, water will leak in. Follow these settings in your Slicer (Cura, PrusaSlicer, OrcaSlicer, etc.):

| Parameter | Recommended Value | Explanation |
| :---- | :---- | :---- |
| **Material** | TPU (95A hardness or softer) | Essential for seal flexibility. |
| **Perimeters (Walls)** | 4 minimum | Waterproofing is achieved by wall thickness (1.6mm). |
| **Seam (Z-Seam)** | Aligned | *Never use "Random"*, as this creates micro-holes. |
| **Temperature** | High range (e.g., 230-235°C) | Guarantees absolute inter-layer fusion. |
| **Flow Rate** | 102% to 105% | Plugs micro-holes and forces layer adhesion. |
| **Supports** | None | The model is designed to print without supports (45° angles). |

## **💡 Usage Tips**

* **First Screwing**: The first assembly might be a bit stiff. Screw and unscrew the cap 3 or 4 times quickly. The friction will heat and soften the TPU, allowing it to "find its place" in the grooves.  
* **Lubrication**: If screwing remains too difficult (TPU on TPU has high friction), apply a micro-drop of **silicone grease** to the threads. This will ease movement without damaging the plastic.
