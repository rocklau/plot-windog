$root_path="C:\hdd\"
mkdir $root_path

for($x=20; $x -lt 22; $x=$x+1)   
{   
 echo $x
 $name="plots" +$x
 $path =$root_path + $name
 echo $path

 mkdir $path
 New-Partition -DiskNumber $x -UseMaximumSize  | Format-Volume -FileSystem NTFS -NewFileSystemLabel $name
 Get-Partition -DiskNumber $x | Select -Last 1 | Add-PartitionAccessPath -AccessPath $path 
 mkdir $path\$name
}
