$i=1  
$task_num = 0
$process ="*plots*"
$max_num = 15
$token = "dingtalk token"
$chia_exe_path="C:\daemon\chia.exe" 
$nvme_path="D:\chia\plotcache"
$root_path="C:\hdd\"
clear

$task_num =  (Get-CimInstance Win32_Process   | Where {$_.CommandLine -like $process }  | Measure-Object -Line   | Select-Object Lines).lines

Write-Host  $task_num

$host1="75"

$max_drive=1.7
$drive_idx=0
$max_drive=1.7
$drive="plots" + $drive_idx

do  
{ 
 

$free=  Get-Volume |Where-Object {$_.FileSystemLabel -eq $drive} | Foreach-Object { ($_.SizeRemaining /1TB) } 
# Get-WMIObject Win32_LogicalDisk |Where-Object {$_.Caption -eq $drive} | Foreach-Object { ($_.FreeSpace /1TB) }


     if(  $free -lt $max_drive)
     {
     Write-Host  "切换新硬盘"

     $drive_idx = $drive_idx +1
     $drive="plots" +$x
     
     $path =$root_path + $drive
         $msg = '{"msgtype": "text","text": {"content": "wh:'+$host1+'  chia new  '+ $drive + ' '+ $(Get-Date)+' "}}'

        Write-Host   $msg
        $param = @{
            Uri         = "https://oapi.dingtalk.com/robot/send?access_token=" + $token
            Method      = "Post"
            Body        = $msg #[System.Text.Encoding]::UTF8.GetBytes($msg)
            ContentType = "application/json"
        }
        Invoke-RestMethod @param
     }
Write-Host  $drive
Write-Host  $free


$task_num =  (Get-CimInstance Win32_Process   | Where {$_.CommandLine -like $process }  | Measure-Object -Line   | Select-Object Lines).lines

Write-Host  $task_num

if($task_num -lt $max_num -and $task_num -gt 0)
{
$arg = "plots create -k32 -n1 -t" + $nvme_path +"\$i -2" + $nvme_path + "\$i -d" + $path + "\plots -b4390 -u128 -r4 -a1991559293"
Write-Host $arg

Start-Process   -FilePath $chia_exe_path   -ArgumentList  $arg
echo "新任务$i"


$i = $i + 1
if($i -eq 21)
{
 $i=1
}
Write-Host "$(Get-Date),   任务数： $task_num"

} 
Start-Sleep -s 1800

$task_num = 0

}while(1) 
