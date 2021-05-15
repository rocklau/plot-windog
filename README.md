# plot-windog
chia automation script tool on Windows
 
 奇亚自动化脚本工具 Windows
 
 
 
##  批量初始化磁盘

  driver.ps1
  
  因为我们如果插很多硬盘，盘符是不够用的（A-Z）
  
  所以这里，要把硬盘挂在到目录上
  
  当然也有好处，就是更容易管理。
  
##  自动P盘脚步
  task.ps1
  
  * 检查任务数不够就启动新任务
  * 检查硬盘空间不足就切换到新硬盘
  * 每次切换硬盘会给钉钉发条消息
  
  
   
## 备注
先设置``` Set-ExecutionPolicy Unrestricted```

这个脚本我已经用来管理了10台服务器，100块硬盘。

与别的脚本工具，这个非常简单。

如果不太会编程的。

简单学一下，就容易自己改成自己想要的。
