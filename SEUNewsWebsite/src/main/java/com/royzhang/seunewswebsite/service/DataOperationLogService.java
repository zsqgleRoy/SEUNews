package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.user.DataOperationLogDTO;

import java.util.List;

public interface DataOperationLogService {
    // 获取所有数据操作日志
    List<DataOperationLogDTO> getAllLogs();

    // 根据日志 ID 获取数据操作日志
    DataOperationLogDTO getLogById(Integer logId);

    // 创建数据操作日志
    DataOperationLogDTO createLog(DataOperationLogDTO logDTO);

    // 删除数据操作日志
    void deleteLog(Integer logId);

    // 根据用户 ID 获取数据操作日志列表
    List<DataOperationLogDTO> getLogsByUserId(Integer userId);
}
