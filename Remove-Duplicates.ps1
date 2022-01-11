Function Remove-Duplicates($path1,$path2,$ext1,$ext2){
    #$path1="D:\Mike\Desktop\AYC"
    #$path2="D:\Mike\Desktop\AYC\testing"
    $list1=Get-ChildItem -Path $path1 -Filter "*$ext1"
    $list2=Get-ChildItem -Path $path2 -Filter "*$ext2"
    $list1_array=@()
    foreach($file1 in $list1){
        $list1_array+=$file1.Name
    }
    foreach($file2 in $list2){
        $file2_name=$file2.Name
        if($list1_array -contains $file2_name.replace($ext2,$ext1)){
            $file1_name=$file2_name.replace($ext2,$ext1)
            Write-Output "$path1\$file1_name"
        }
    }
    $deletion=Read-Host -Prompt "Does above result looks good to be deleted?(y/n)"
    if($deletion.ToLower() -like "y" -or $deletion.ToLower() -like "yes"){
        foreach($file2 in $list2){
            $file2_name=$file2.Name
            if($list1_array -contains $file2_name.replace($ext2,$ext1)){
                $file1_name=$file2_name.replace($ext2,$ext1)
                Remove-Item -Path "$path1\$file1_name" -Force
            }
        }
    }
}

if($env:OS -like "Windows_NT"){#some python syntax over here :P
    #`r`n is for new line
    Write-Output "This script was made with intention of deleting duplicate files from 2 different directories`r`npath1 - is the directory that needs to have duplicates removed`r`npath2 - is the directory that will keep the duplicates"
    $path1=Read-Host -Prompt "Path1"
    $path1=$path1.Trim()
    if($path1.EndsWith("\")){
        $path1=$path1.Substring(0,$path1.Length-1)
    }
    $path2=Read-Host -Prompt "Path2"
    $path2=$path2.Trim()
    if($path2.EndsWith("\")){
        $path2=$path2.Substring(0,$path2.Length-1)
    }
    $extension_choice=Read-Host -Prompt "Do you need to match duplicates with different extensions?(y/n)"
    if($extension_choice.ToLower() -like "y" -or $extension_choice.ToLower() -like "yes"){
        $ext1=Read-Host -Prompt "Extenson for Path1"
        $ext1=$ext1.Trim()
        if(!$ext1.Contains(".")){
            $ext1="."+$ext1
        }
        $ext2=Read-Host -Prompt "Extenson for Path2"
        $ext2=$ext2.Trim()
        if(!$ext2.Contains(".")){
            $ext2="."+$ext2
        }
        Remove-Duplicates -path1 $path1 -path2 $path2 -ext1 $ext1 -ext2 $ext2
    }else{
        Remove-Duplicates -path1 $path1 -path2 $path2
    }
    Write-Output "Script finished."
}