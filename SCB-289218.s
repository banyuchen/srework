mothershipadmin role_config_group config set -m impala -r impala_daemon --role_config_group role_config_group_impala_daemon_1715334138620 --namespace impalad_flags -k 'mem_limit' -v 21474836480 --yes
mothershipadmin role_config_group config set -m impala -r impala_daemon --role_config_group role_config_group_impala_daemon_1715334138620 --namespace impalad_flags -k 'default_pool_mem_limit' -v 64424509440 --yes


mothershipadmin role_config_group config set -m impala -r impala_state_store --role_config_group role_config_group_impala_state_store_1715334135769 --namespace impalad_flags -k 'java_tool_options' -v '\-XX:+UseG1GC -Xmx14G' --yes
mothershipadmin role_config_group config set -m impala -r impala_catalog_service --role_config_group role_config_group_impala_catalog_service_1715334133820 --namespace impalad_flags -k 'java_tool_options' -v '\-XX:+UseG1GC -Xmx14G' --yes
mothershipadmin role_config_group config set -m impala -r impala_daemon --role_config_group role_config_group_impala_daemon_1715334138620 --namespace impalad_flags -k 'java_tool_options' -v '\-XX:+UseG1GC -Xmx14G' --yes


[PROD Orz sa_cluster@sensorsdata1 tools]$ mothershipadmin config  search -m impala  -k mem_limit  --output_command
2025-05-10 13:39:22,856 INFO 
+-----------------------------------------------+----------------------------------------+---------------+--------------------------------+-------------+
|                     配置组                    |                生效节点                |   namespace   |             配置名             |    当前值   |
+-----------------------------------------------+----------------------------------------+---------------+--------------------------------+-------------+
| role_config_group_impala_daemon_1715334138620 | sensorsdata1,sensorsdata2,sensorsdata3 | impalad_flags |           mem_limit            | 10737418240 |
| role_config_group_impala_daemon_1715334138620 | sensorsdata1,sensorsdata2,sensorsdata3 | impalad_flags |     default_pool_mem_limit     | 32212254720 |
|                module 默认配置                | sensorsdata1,sensorsdata2,sensorsdata3 | impalad_flags | auto_compute_cluster_mem_limit |    False    |
|                module 默认配置                | sensorsdata1,sensorsdata2,sensorsdata3 | impalad_flags |    cluster_mem_limit_factor    |     1.0     |
+-----------------------------------------------+----------------------------------------+---------------+--------------------------------+-------------+
output_command: 
mothershipadmin role_config_group config set -m impala -r impala_daemon --role_config_group role_config_group_impala_daemon_1715334138620 --namespace impalad_flags -k 'mem_limit' -v 10737418240 --yes
mothershipadmin role_config_group config set -m impala -r impala_daemon --role_config_group role_config_group_impala_daemon_1715334138620 --namespace impalad_flags -k 'default_pool_mem_limit' -v 32212254720 --yes
mothershipadmin module config set -m impala --namespace impalad_flags -k 'auto_compute_cluster_mem_limit' -v False
mothershipadmin module config set -m impala --namespace impalad_flags -k 'cluster_mem_limit_factor' -v 1.0
[PROD Orz sa_cluster@sensorsdata1 tools]$ mothershipadmin config  search -m impala  -k java_tool_options  --output_command
2025-05-10 13:39:30,448 INFO 
+--------------------------------------------------------+----------------------------------------+-------------------+-------------------+-------------------------------+
|                         配置组                         |                生效节点                |     namespace     |       配置名      |             当前值            |
+--------------------------------------------------------+----------------------------------------+-------------------+-------------------+-------------------------------+
|                    module 默认配置                     | sensorsdata1,sensorsdata2,sensorsdata3 |   catalogd_flags  | java_tool_options | -Xms4294967296 -Xmx4294967296 |
|   role_config_group_impala_state_store_1715334135769   |              sensorsdata1              |   impalad_flags   | java_tool_options |      \-XX:+UseG1GC -Xmx7G     |
| role_config_group_impala_catalog_service_1715334133820 |              sensorsdata3              |   impalad_flags   | java_tool_options |      \-XX:+UseG1GC -Xmx7G     |
|     role_config_group_impala_daemon_1715334138620      | sensorsdata1,sensorsdata2,sensorsdata3 |   impalad_flags   | java_tool_options |      \-XX:+UseG1GC -Xmx7G     |
|                    module 默认配置                     | sensorsdata1,sensorsdata2,sensorsdata3 | statestored_flags | java_tool_options |                               |
+--------------------------------------------------------+----------------------------------------+-------------------+-------------------+-------------------------------+
output_command: 
mothershipadmin module config set -m impala --namespace catalogd_flags -k 'java_tool_options' -v -Xms4294967296 -Xmx4294967296
mothershipadmin role_config_group config set -m impala -r impala_state_store --role_config_group role_config_group_impala_state_store_1715334135769 --namespace impalad_flags -k 'java_tool_options' -v \-XX:+UseG1GC -Xmx7G --yes
mothershipadmin role_config_group config set -m impala -r impala_catalog_service --role_config_group role_config_group_impala_catalog_service_1715334133820 --namespace impalad_flags -k 'java_tool_options' -v \-XX:+UseG1GC -Xmx7G --yes
mothershipadmin role_config_group config set -m impala -r impala_daemon --role_config_group role_config_group_impala_daemon_1715334138620 --namespace impalad_flags -k 'java_tool_options' -v \-XX:+UseG1GC -Xmx7G --yes
mothershipadmin module config set -m impala --namespace statestored_flags -k 'java_tool_options' -v 