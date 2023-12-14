
cd ~
cd ABHORIZON_PC_VISION
git pull origin main


cd ~/projects/abh_gui_v3
git pull origin main
cd build
make

cd ~
cp Scrivania/abh/abh-data/traduzioni/*.ts .
lupdate -extensions qml -ts abh_ar.ts
lupdate -extensions qml -ts abh_de.ts
lupdate -extensions qml -ts abh_en.ts
lupdate -extensions qml -ts abh_fr.ts
lupdate -extensions qml -ts abh_it.ts

cd coordinator
