#!/bin/bash
### メモリ空きサイズをCloudWatchのカスタムメトリクスに登録する

instanceid=`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id`
namespace="Memory"
metricname="FreeMemoryMByte"
unit="Megabytes"

#メモリ使用率計算
value=`free -m | grep 'buffers/cache' | tr -s ' ' | cut -d ' ' -f 4`

/usr/bin/aws cloudwatch put-metric-data ¥
 --region ap-northeast-1 ¥
 --namespace "${namespace}" ¥
 --dimensions "InstanceID=${instanceid}" ¥
 --metric-name "${metricname}" ¥
 --unit "${unit}" ¥
 --value ${value}