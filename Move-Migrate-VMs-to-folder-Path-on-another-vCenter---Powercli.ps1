function Move-VMtoFolderPath {  
 <#  
 .SYNOPSIS  
 Move VM to folder path  
 .DESCRIPTION  
 The function retrives complete folder Path from vcenter (Inventory >> Vms and Templates)  
 .NOTES   
 Author: Kunal Udapi  
 http://kunaludapi.blogspot.com  
 .PARAMETER N/a  
 No Parameters Required  
 .EXAMPLE  
  PS> Get-Content -Path c:\temp\VmFolderPathList.txt | Move-VMtoFolderPath  
 #>  
  #####################################    
  ## http://kunaludapi.blogspot.com    
  ## Version: 1    
  ##    
  ## Tested this script on    
  ## 1) Powershell v4    
  ## 2) VMware vSphere PowerCLI 6.0 Release 1 build 2548067    
  ## 3) Vsphere 5.5    
  #####################################    
   Foreach ($FolderPath in $Input) {  
     $list = $FolderPath -split "\\"  
     $VMName = $list[-1]  
     $count = $list.count - 2  
     0..$count | ForEach-Object {  
          $number = $_  
       if ($_ -eq 0 -and $count -gt 2) {  
               $Datacenter = Get-Datacenter $list[0]  
          } #if ($_ -eq 0)  
       elseif ($_ -eq 0 -and $count -eq 0) {  
               $Datacenter = Get-Datacenter $list[$_]  
               #VM already in Datacenter no need to move  
         Continue  
       } #elseif ($_ -eq 0 -and $count -eq 0)  
       elseif ($_ -eq 0 -and $count -eq 1) {  
         $Datacenter = Get-Datacenter $list[$_]  
       } #elseif ($_ -eq 0 -and $count -eq 1)  
       elseif ($_ -eq 0 -and $count -eq 2) {  
         $Datacenter = Get-Datacenter $list[$_]  
       } #elseif ($_ -eq 0 -and $count -eq 2)  
          elseif ($_ -eq 1) {  
               $Folder = $Datacenter | Get-folder $list[$_]  
          } #elseif ($_ -eq 1)  
          else {  
         $Folder = $Folder | Get-Folder $list[$_]  
          } #else  
     } #0..$count | foreach  
     Move-VM -VM $VMName -Destination $Folder  
   } #Foreach ($FolderPath in $VMFolderPathList)  
 }#function Set-FolderPath  