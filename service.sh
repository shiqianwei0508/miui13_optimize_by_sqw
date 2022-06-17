#!/system/bin/sh
MODDIR=${0%/*}

##########################
# 开机时自动禁用 SELinux
echo 0 > /sys/fs/selinux/enforce
##########################
# 关闭收集 I/O 读写状态 (SCSI)
echo 0 > /sys/block/sda/queue/iostats
echo 0 > /sys/block/sde/queue/iostats
##########################
# 禁用 调度自动分组 (可能会与 Yc调度冲突)
echo 0 > /proc/sys/kernel/sched_autogroup_enabled
##########################
# 禁用 Android Binder 调试收集开关
echo 0 > /sys/module/binder/parameters/debug_mask
echo 0 > /sys/module/binder_alloc/parameters/debug_mask
##########################
# 禁用 内核堆(heap) 随机化
echo 0 > /proc/sys/kernel/randomize_va_space
##########################
# 将 页面簇 调整为 1(0)
echo 0 > /proc/sys/vm/page-cluster
##########################
# 将 虚拟内存 更新间隔更改为 20(秒)
echo 20 > /proc/sys/vm/stat_interval
##########################
# 禁用 F2FS IO统计 Android 12+
echo 0 > /dev/sys/fs/by-name/userdata/iostat_enable
##########################
# 禁用 调度数据统计 Android 11+
echo 0 > /proc/sys/kernel/sched_schedstats
##########################
# 启用 禁止压缩不可压缩的进程
echo 0 > /proc/sys/vm/compact_unevictable_allowed
##########################
# 调整 内存碎片阈值上限
echo 800 > /proc/sys/vm/extfrag_threshold
##########################
# 停止/废除小米调试服务跟日志
stop cnss_diag
stop vendor.ipacm-diag
stop tcpdump
stop statsd
##########################
# 删除已创建的 wlan_logs
rm -rf /data/vendor/wlan_logs
##########################
# 启用 SELinux
echo 1 > /sys/fs/selinux/enforce
