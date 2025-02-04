# 教學
## 必要
你需要下載brightnessctl套件
```
sudo apt install brightnessctl
```
確認是否安裝iio套件
```
sudo apt install iio-sensor-proxy
```
測試感測器
```
monitor-sensor
```
## 檔案設定
```
下載auto_brightness.sh
cd <檔案所在目錄>
chmod +x auto_brightness.sh
```
## 開機自啟動
> 開啟「啟動應用程式」或「Startup Applications」
+號 > 自訂指令 > 取名並選擇auto_brightness.sh > 確認並開啟
## 取得root權限以確保可以正常更改亮度
創建群駔
```
sudo groupadd backlight
```
將您電腦使用者加入群駔
```
sudo usermod -a -G backlight your_username
```
創建udev規則
打開「檔案」目錄輸入
```
/etc/udev/rules.d
```
右鍵取得root權限 創建空白文件，取名為
```
99-backlight.rules
```
添加以下內容
```
SUBSYSTEM=="backlight", ACTION=="add", KERNEL=="<背光裝置名稱>", \
    RUN+="/bin/chgrp backlight /sys/class/backlight/%k/brightness", \
    RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"
```
重新載入udev規則
```
sudo udevadm control --reload
sudo udevadm trigger
```
查看背光裝置
```
ls /sys/class/backlight/
```
記住，最好寫下來
```
ls -l /sys/class/backlight/<背光裝置名稱>/
```
給予權限
```
sudo chmod o+w /sys/class/backlight/<背光裝置名稱>/brightness
```
檢查權限
```
ls -l /sys/class/backlight/<背光裝置名稱>/brightness
```
你應該會看到root 表示成功
## 結束，你可以高枕無憂使用了，以上代碼經過我測試並簡化 如果您需要更改腳本偵測的亮度，請打開sh檔修改 看不懂可以丟給ChatGPT讓它幫你解釋並修改。
