$isoFolder = "C:\Users\joero\Desktop\packer\answer-iso\"
if (test-path $isoFolder){
  remove-item $isoFolder -Force -Recurse
}

New-Item $isoFolder -ItemType Directory

Copy-Item C:\Users\joero\Desktop\packer\answer_files\2012r2\Autounattend.xml $isoFolder\

& .\mkisofs.exe -r -iso-level 4 -UDF -o C:\Users\joero\Desktop\packer\answer-iso\iso\answer.iso $isoFolder
