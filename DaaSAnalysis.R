# import data  library-导入包
# library(readr)
zxw_populationfloat_deal <- read_csv("F:/DataFile/DaaS数据平台数据/zxw_populationfloat_deal.csv")
View(zxw_populationfloat_deal)
# 列
print(ncol(zxw_populationfloat_deal))
# 行
print(nrow(zxw_populationfloat_deal))
# 是否本地用户人口汇总
library(dplyr)
DataAnalysis_GroupByILC <- select(zxw_populationfloat_deal, o_tz_id, d_tz_id, is_localcity, user_cnt)
DataAnalysis_GroupByILC <- arrange(DataAnalysis_GroupByILC, o_tz_id, d_tz_id)
DataAnalysis_GroupByILC <- data.frame(DataAnalysis_GroupByILC)
# 总人口汇总
DataAnalysis_CntSum <- select(zxw_populationfloat_deal, o_tz_id, d_tz_id, user_cnt)
DataAnalysis_CntSum <- arrange(DataAnalysis_CntSum, o_tz_id, d_tz_id)
DataAnalysis_CntSum <- data.frame(DataAnalysis_CntSum)

# 是否本地分组项
DAG <- group_by(DataAnalysis_GroupByILC, o_tz_id, d_tz_id, is_localcity)
# 是否本地用户人口流动汇总统计
IslocalCity_Sum <- summarise(DAG, IsLocalCity_Cnt = sum(user_cnt))

# 流动人口分组项
DAC <- group_by(DataAnalysis_CntSum, o_tz_id, d_tz_id)
# 人口流动汇总统计
PopulationFloat_Sum <- summarise(DAC, Sum_Cnt = sum(user_cnt))
# 求PopulationFloat_Sum表每个社区的流动总人口
PFS_Community <- select(PopulationFloat_Sum, o_tz_id, Sum_Cnt)
PFS <- group_by(PFS_Community, o_tz_id)
PFS_Community <- summarise(PFS, Community_Cnt_Sum = sum(Sum_Cnt))

# 连接表 连接-是否本地用户表和社区流动总人口表
DataAnalysis_Calculate_First <- merge(IslocalCity_Sum, PopulationFloat_Sum, by = c("o_tz_id", "d_tz_id"), all = T )
DataAnalysis_Calculate_Second <- merge(DataAnalysis_Calculate_First, PFS_Community, by = "o_tz_id", all = T )
DataAnalysis_Calculate_Second <- arrange(DataAnalysis_Calculate, o_tz_id, d_tz_id)
DataAnalysis_Calculate_Third <- select(DataAnalysis_Calculate_Second, o_tz_id, d_tz_id, is_localcity, IsLocalCity_Cnt, Sum_Cnt, Community_Cnt_Sum)
# 计算百分比
DataAnalysis_Calculate_Third$IsLocalCity_Percentage <- round(DataAnalysis_Calculate_Third$IsLocalCity_Cnt / DataAnalysis_Calculate_Third$Sum_Cnt, 5)
DataAnalysis_Calculate_Third$Sum_Percentage <- round(DataAnalysis_Calculate_Third$Sum_Cnt / DataAnalysis_Calculate_Third$Community_Cnt_Sum, 5)
