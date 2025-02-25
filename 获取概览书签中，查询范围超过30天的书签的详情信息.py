#!/usr/bin/env python3
###################################################################
# Author: YanKuan                                            ######
# Description:  用于获取概览书签中，查询范围超过30天的书签的详情信息  ######
# Version: 0.0.1                                             ######
# Update: 2023-08-06                                         ######
###################################################################
 
import json
from datetime import datetime
try:
    from dateutil import rrule
except ImportError:
    # 导入包，有些环境对应的包不存在，会抛出此错误，无法执行该脚本
    print('import rrule error，not exec this script, exit!!!')
    exit(1)
try:
    from hyperion_guidance.mysql_connector import MysqlConnector
except ImportError:
    # 导入包，有些环境对应的包不存在，会抛出此错误，无法执行该脚本
    print('import MysqlConnector error，not exec this script, exit!!!')
    exit(1)
 
# 指定时间范围，即 30 天
time_interval = 600
 
 
def find_dash_book_30_info():
    sql: str = """
    select p.name as project_name,
        p.cname as project_cname,
        d.id as dashboard_id,
        d.name as dashboard_name,
        b.id as bookmark_id,
        b.name as bookmark_name,
        b.type as bookmark_type,
        b.data as bookmark_data,
        u.username as user_name
    from dashboard_item d_i, project p, dashboard d, bookmark b, user u
    where d_i.bookmark_id=b.id
        and d_i.dashboard_id=d.id
        and d.project_id=p.id
        and d.user_id=u.id
    order by project_name, dashboard_id;
    """
 
    results: list = MysqlConnector().query(sql)
 
    # 记录符合要求的概览书签
    bookmark_list: list = []
 
    for record in results:
        # record is dict
 
        # 获取书签的详细数信息
        data: dict = json.loads(record['bookmark_data'])
 
        # 如果包含开始日期
        if 'from_date' in data:
            # 开始日期/结束日期 str
            from_date_str = data['from_date'].split(' ', 1)[0]
            to_date_str = data['to_date'].split(' ', 1)[0]
 
            # 开始日期/结束日期 date
            from_date = datetime.strptime(from_date_str, '%Y-%m-%d')
            to_date = datetime.strptime(to_date_str, '%Y-%m-%d')
 
            # 查询的时间范围
            days = rrule.rrule(freq=rrule.DAILY, dtstart=from_date, until=to_date)
            if days.count() > time_interval:
                record['day'] = days.count()
                del record['bookmark_data']
                bookmark_list.append(record)
 
    print('项目名', '\t',
          '项目显示名', '\t',
          '概览ID', '\t',
          '概览名称', '\t',
          '书签ID', '\t',
          '书签名称', '\t',
          '书签类型', '\t',
          '查询范围', '\t',
          '概览创建人'
          )
 
    # 遍历打印
    for i in range(len(bookmark_list)):
        print(bookmark_list[i]['project_name'], '\t',
              bookmark_list[i]['project_cname'], '\t',
              bookmark_list[i]['dashboard_id'], '\t',
              bookmark_list[i]['dashboard_name'], '\t',
              bookmark_list[i]['bookmark_id'], '\t',
              bookmark_list[i]['bookmark_name'], '\t',
              bookmark_list[i]['bookmark_type'], '\t',
              bookmark_list[i]['day'], '\t',
              bookmark_list[i]['user_name']
              )
 
 
if __name__ == '__main__':
    find_dash_book_30_info()