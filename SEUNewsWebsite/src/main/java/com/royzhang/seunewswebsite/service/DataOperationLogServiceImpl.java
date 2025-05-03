package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.user.DataOperationLogDTO;
import com.royzhang.seunewswebsite.entity.DataOperationLog;
import com.royzhang.seunewswebsite.repository.DataOperationLogRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class DataOperationLogServiceImpl implements DataOperationLogService {

    @Autowired
    private DataOperationLogRepository dataOperationLogRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Override
    public List<DataOperationLogDTO> getAllLogs() {
        List<DataOperationLog> logs = dataOperationLogRepository.findAll();
        return logs.stream()
                .map(log -> modelMapper.map(log, DataOperationLogDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public DataOperationLogDTO getLogById(Integer logId) {
        Optional<DataOperationLog> logOptional = dataOperationLogRepository.findById(logId);
        return logOptional.map(log -> modelMapper.map(log, DataOperationLogDTO.class)).orElse(null);
    }

    @Override
    public DataOperationLogDTO createLog(DataOperationLogDTO logDTO) {
        DataOperationLog log = modelMapper.map(logDTO, DataOperationLog.class);
        DataOperationLog savedLog = dataOperationLogRepository.save(log);
        return modelMapper.map(savedLog, DataOperationLogDTO.class);
    }

    @Override
    public void deleteLog(Integer logId) {
        dataOperationLogRepository.deleteById(logId);
    }

    @Override
    public List<DataOperationLogDTO> getLogsByUserId(Integer userId) {
        List<DataOperationLog> logs = dataOperationLogRepository.findByUserId(userId);
        return logs.stream()
                .map(log -> modelMapper.map(log, DataOperationLogDTO.class))
                .collect(Collectors.toList());
    }
}
