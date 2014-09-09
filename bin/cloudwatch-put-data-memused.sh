#!/bin/bash
### メモリ使用率をCloudWatchのカスタムメトリクスに登録する

instanceid=`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id`
namespace="Memory"
metricname="UseMemoryPercent"
unit="Percent"

#メモリ使用率計算
memtotal=`free -m | grep 'Mem' | tr -s ' ' | cut -d ' ' -f 2`
memfree=`free -m | grep 'buffers/cache' | tr -s ' ' | cut -d ' ' -f 4`
let "value=100-memfree*100/memtotal"

/usr/bin/aws cloudwatch put-metric-data ¥
 --region ap-northeast-1 ¥
 --namespace "${namespace}" ¥
 --dimensions "InstanceID=${instanceid}" ¥
 --metric-name "${metricname}" ¥
 --unit "${unit}" ¥
 --value ${value}