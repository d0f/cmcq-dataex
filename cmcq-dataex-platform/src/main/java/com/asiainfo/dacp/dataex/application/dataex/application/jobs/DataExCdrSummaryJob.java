package com.asiainfo.dacp.dataex.application.dataex.application.jobs;

import com.asiainfo.dacp.jdbc.JdbcTemplate;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Calendar;

@Component
public class DataExCdrSummaryJob {
    private static Logger LOG = LoggerFactory.getLogger(DataExCdrSummaryJob.class);

    SimpleDateFormat tableFix = new SimpleDateFormat("yyyyMMdd");
    SimpleDateFormat queryCond = new SimpleDateFormat("yyyyMMddHHmm");

    /**
     * 定时总表统计
     * 2015/11/24
     * @Scheduled 每5分钟
     */
    @Scheduled(cron="40 */5 * * * ?")
    public void dacpExCdrSummaryJob(){
    	
    	Calendar nowTime = Calendar.getInstance();
    	
    	String tableFixStr = tableFix.format(nowTime.getTime());
    	String nowTimeStr = queryCond.format(nowTime.getTime())+"59";
    	nowTime.add(Calendar.MINUTE, -5);
    	String fiveMiAgoTimeStr = queryCond.format(nowTime.getTime())+"00";

        String UPDATE_LOG_TABLE_SQL =
                "INSERT INTO dacp_dataex_cdr_summary(user_id,app_key,api_id,summary,start_dt,end_dt,max_resp_time,min_resp_time,avg_resp_time)"
                + " SELECT user_id,app_key,api_id,"
                + "COUNT(*) summary,STR_TO_DATE("+fiveMiAgoTimeStr+",'%Y%m%d%H%i%s') start_dt,"
                + "STR_TO_DATE("+nowTimeStr+",'%Y%m%d%H%i%s') end_dt,"
                + "MAX(resp_time) max_resp_time,"
                + "MIN(resp_time) min_resp_time,"
                + "ROUND(AVG(resp_time)) avg_resp_time "
                + "FROM dacp_dataex_cdr_"+tableFixStr+" "
                + "WHERE "
                + "create_dt BETWEEN STR_TO_DATE("+fiveMiAgoTimeStr+",'%Y%m%d%H%i%s') AND STR_TO_DATE("+nowTimeStr+" - 0,'%Y%m%d%H%i%s') "
                + "AND api_id !='' AND app_key != 'testAppkey' "
                + "GROUP BY user_id,app_key,api_id";

        LOG.info("开始定时总表统计:add:{}...",UPDATE_LOG_TABLE_SQL);
        new JdbcTemplate().batchUpdate(UPDATE_LOG_TABLE_SQL);
        LOG.info("定时总表统计结束...");

    }

}
