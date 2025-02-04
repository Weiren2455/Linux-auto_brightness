
#!/bin/bash
# 自動調節亮度腳本
# 請確認你的光感應器數值路徑是否正確
SENSOR_PATH="/sys/bus/iio/devices/iio:device0/in_illuminance_input"

# 無限循環，每隔 5 秒讀取一次感應數據並調整亮度
while true; do
    if [ -f "$SENSOR_PATH" ]; then
        lux=$(cat "$SENSOR_PATH")
        # 根據 lux 值設定目標亮度（百分比）
        if [ "$lux" -lt 20 ]; then
            target=10
        elif [ "$lux" -lt 100 ]; then
            target=20
        elif [ "$lux" -gt 501 ]; then
            target=100
        fi

        # 使用 brightnessctl 調整亮度
        brightnessctl set ${target}%
        echo "環境光：${lux} lux，設定亮度：${target}%"
    else
        echo "找不到感應器數據檔案：$SENSOR_PATH"
    fi

    sleep 5
done
