import shutil
import os

# Define the source and destination path
subfolders = [f.path for f in os.scandir(
    "F:\Development\cosmodex\\assets\\aliens") if f.is_dir()]
for subfolder in subfolders:
    source = subfolder
    destination = "F:\Development\cosmodex\\assets\\aliens"

    # code to move the files from sub-folder to main folder.
    files = os.listdir(source)
    for file in files:
        file_name = os.path.join(source, file)
        shutil.move(os.path.join(source, file),
                    os.path.join(destination, file))
    print("Files Moved")
