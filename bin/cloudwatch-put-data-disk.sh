#!/bin/bash
### 「/」ボリュームのディスク使用率をCloudWatchのカスタムメトリクスに登録する

instanceid=`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id`
namespace="LocalDisk"
metricname="/"
unit="Percent"

value=`df -kh ${metricname} | grep -v Filesystem | awk '{print $5}' | sed -e s/%//g`

/usr/bin/aws cloudwatch put-metric-data ¥
 --region ap-northeast-1 ¥
 --namespace "${namespace}" ¥
 --dimensions "InstanceID=${instanceid}" ¥
 --metric-name "${metricname}" ¥
 --unit "${unit}" ¥
 --value ${value}
