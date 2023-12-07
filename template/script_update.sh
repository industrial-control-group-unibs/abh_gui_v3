
cd ~
cd ABHORIZON_PC_VISION
git pull origin main


cd ~/projects/abh_gui_v3
git pull origin main
cd build
make

cd ..
lupdate qml.qrc -ts abh_ar.ts
lupdate qml.qrc -ts abh_de.ts
lupdate qml.qrc -ts abh_en.ts
lupdate qml.qrc -ts abh_fr.ts
lupdate qml.qrc -ts abh_it.ts
cd coordinator
