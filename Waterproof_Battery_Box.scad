include <BOSL2/std.scad>
include <BOSL2/threading.scad>

/* [Sélection de la Batterie] */
// Type de batterie
battery_type = "AA"; // ["18650", "20700", "21700", "26650", "AA", "AAA", "Custom"]

// Diamètre personnalisé (utilisé si "Custom" est sélectionné)
custom_dia = 21.5; 
// Longueur personnalisée (utilisée si "Custom" est sélectionné)
custom_len = 71.0;

/* [Paramètres d'Étanchéité TPU] */
wall_thick = 1.6;  // OPTIMISÉ: 1.6mm = 4 murs parfaits pour étanchéité (plus léger)
base_thick = 1.6;  // OPTIMISÉ: Épaisseur des fonds (gain de poids)
thread_len = 12;   
thread_pitch = 4;  
manual_clearance = 0.8; 

/* [Paramètres d'Affichage] */
part = "cut"; // [box, cap, both, cut]

// --- CALCULS ---
// Détermination des dimensions selon le profil choisi
batt_dia = 
    (battery_type == "18650") ? 18.5 :
    (battery_type == "20700") ? 20.5 :
    (battery_type == "21700") ? 21.5 :
    (battery_type == "26650") ? 26.5 :
    (battery_type == "AA")    ? 14.5 :
    (battery_type == "AAA")   ? 10.5 :
    custom_dia;

batt_len = 
    (battery_type == "18650") ? 65.5 :
    (battery_type == "20700") ? 70.5 :
    (battery_type == "21700") ? 71.0 :
    (battery_type == "26650") ? 65.5 :
    (battery_type == "AA")    ? 50.5 :
    (battery_type == "AAA")   ? 44.5 :
    custom_len;

inner_dia = batt_dia + 1.0;
outer_dia = inner_dia + (2 * wall_thick); 
total_height = batt_len + base_thick + 1; // Ajusté pour le nouveau fond

// Hauteur du bouchon (Calculée ici pour gérer l'inversion d'impression)
cap_h = thread_len + 15; 

// Le filetage est plus large que le tube
base_thread_dia = outer_dia + 2.5; 

// --- PARAMÈTRES DU JOINT RADIAL (SUR LE COTÉ) ---
// La collerette doit être plus large que le filetage pour que le joint passe autour
flange_dia = base_thread_dia + 3.0; // Diamètre de la surface d'étanchéité
flange_height = 8.0; // Hauteur de la zone d'étanchéité verticale

// Positions exactes des joints (depuis le bas de la collerette)
seal_h1 = 3.0; 
seal_h2 = 6.0;

// Diamètre du fond des rainures
seal_groove_depth = 0.6; 

$fn = 64; 

module body() {
    male_thread_d = base_thread_dia - (manual_clearance / 2);
    thread_z_start = total_height - thread_len;
    flange_z_start = thread_z_start - flange_height;

    difference() {
        union() {
            // 1. Tube principal (sous la collerette)
            cyl(d=outer_dia, h=flange_z_start, anchor=BOTTOM, texture="diamonds");
            
            // 2. La Collerette VERTICALE (Flange)
            translate([0, 0, flange_z_start]) 
            cyl(d1=outer_dia, d2=flange_dia, h=2, anchor=BOTTOM); // Transition douce
            
            translate([0, 0, flange_z_start + 2]) 
            cyl(d=flange_dia, h=flange_height-2, anchor=BOTTOM); // Surface verticale pour le joint

            // 3. Le filetage MÂLE (au dessus)
            translate([0, 0, thread_z_start]) 
            threaded_rod(
                d=male_thread_d, 
                l=thread_len, 
                pitch=thread_pitch, 
                orient=TOP, 
                anchor=BOTTOM
            );
        }
        
        // Vide intérieur (décalé de base_thick pour créer le fond)
        up(base_thick) cyl(d=inner_dia, h=total_height+10, anchor=BOTTOM);
        
        // --- RAINURES RADIALES (Sur le coté) ---
        translate([0, 0, flange_z_start + seal_h1]) 
            torus_groove(d=flange_dia, depth=seal_groove_depth);
            
        translate([0, 0, flange_z_start + seal_h2]) 
            torus_groove(d=flange_dia, depth=seal_groove_depth);
    }
}

module cap() {
    female_thread_d = base_thread_dia + (manual_clearance / 2);
    skirt_id = flange_dia + manual_clearance; // Jeu pour glisser sur la collerette
    
    // OPTIMISATION POIDS: On sépare le diamètre de la jupe et le diamètre du haut
    cap_skirt_d = skirt_id + (2 * wall_thick); // Plus large en bas
    cap_upper_d = female_thread_d + (2 * wall_thick); // Affiné en haut
    
    skirt_height = flange_height; 

    difference() {
        // Corps du bouchon (Profile externe allégé)
        union() {
            // Jupe (Bas)
            cyl(d=cap_skirt_d, h=skirt_height, anchor=BOTTOM, texture="diamonds");
            // Transition conique pour l'impression sans support
            translate([0,0, skirt_height])
            cyl(d1=cap_skirt_d, d2=cap_upper_d, h=3, anchor=BOTTOM);
            // Poignée (Haut affiné)
            translate([0,0, skirt_height + 3])
            cyl(d=cap_upper_d, h=cap_h - skirt_height - 3, anchor=BOTTOM, texture="diamonds");
        }
        
        // Intérieur fileté (Haut)
        translate([0,0, skirt_height]) 
        threaded_rod(
            d=female_thread_d, 
            l=cap_h - skirt_height - base_thick, // Arrête le trou à base_thick du sommet
            pitch=thread_pitch, 
            internal=true, 
            orient=TOP, 
            anchor=BOTTOM
        );

        // Intérieur Jupe Lisse (Bas)
        cyl(d=skirt_id, h=skirt_height + 0.1, anchor=BOTTOM);
    }
    
    // --- DENTS RADIALES (À l'intérieur de la jupe) ---
    union() {
        translate([0, 0, seal_h1]) 
            torus_ridge(d=skirt_id, depth=seal_groove_depth + 0.2); 
            
        translate([0, 0, seal_h2]) 
            torus_ridge(d=skirt_id, depth=seal_groove_depth + 0.2);
    }
}

// --- MODULES UTILITAIRES POUR JOINTS RADIAUX ---

module torus_groove(d, depth) {
    difference() {
        cyl(d=d + 1, h=1.5, anchor=CENTER); 
        cyl(d=d - (depth*2), h=3, anchor=CENTER, chamfer=0.8); 
    }
}

module torus_ridge(d, depth) {
    rotate_extrude($fn=64)
    translate([d/2, 0, 0]) 
    polygon([
        [0.1, 1],       
        [-depth, 0],    
        [0.1, -1]       
    ]);
}

// Logique d'affichage
if (part == "box") {
    body();
} else if (part == "cap") {
    // Inversé pour impression (Ouverture vers le HAUT)
    translate([0,0,cap_h]) rotate([180,0,0]) cap();
} else if (part == "both") {
    left(outer_dia/2 + 5) body();
    // Inversé pour impression (Ouverture vers le HAUT)
    right(outer_dia/2 + 5) translate([0,0,cap_h]) rotate([180,0,0]) cap();
} else if (part == "cut") {
    difference() {
        union() {
            body();
            color("red")
            // Simulation position fermée : Le bouchon reste orienté vers le BAS ici
            translate([0,0, total_height - thread_len - flange_height]) 
            zrot(180) 
            cap();
        }
        #cuboid([30, 50, 100], anchor=LEFT+BOTTOM);
    }
}