#!/bin/bash
# 设置备份文件存放目录
backup_dir="/home/backup/"
# 获取当前时间并格式化为 yyyy_MM_dd_HH_mm_ss_SSS 格式
timestamp=$(date +"%Y_%m_%d_%H_%M_%S_%3N")
# 设置数据库用户名、密码和数据库名
db_user="root"
db_pass="02120212"
db_name="auth_admin"
# 设置备份文件名
backup_file="${backup_dir}backup_${db_name}_${timestamp}.sql"
# 执行备份命令
docker exec -i slave_3304 bash -c "mysqldump -u ${db_user} -p${db_pass} ${db_name} > ${backup_file}"
# 输出备份文件路径
echo "Backup completed: ${backup_file}"