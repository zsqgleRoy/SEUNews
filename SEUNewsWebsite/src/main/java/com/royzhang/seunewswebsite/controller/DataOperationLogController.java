package com.royzhang.seunewswebsite.controller;

import com.royzhang.seunewswebsite.dto.user.DataOperationLogDTO;
import com.royzhang.seunewswebsite.service.DataOperationLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/data-operation-logs")
public class DataOperationLogController {

    @Autowired
    private DataOperationLogService dataOperationLogService;

    @GetMapping
    public ResponseEntity<List<DataOperationLogDTO>> getAllLogs() {
        List<DataOperationLogDTO> logs = dataOperationLogService.getAllLogs();
        return new ResponseEntity<>(logs, HttpStatus.OK);
    }

    @GetMapping("/{logId}")
    public ResponseEntity<DataOperationLogDTO> getLogById(@PathVariable Integer logId) {
        DataOperationLogDTO log = dataOperationLogService.getLogById(logId);
        if (log != null) {
            return new ResponseEntity<>(log, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @PostMapping
    public ResponseEntity<DataOperationLogDTO> createLog(@RequestBody DataOperationLogDTO logDTO) {
        DataOperationLogDTO createdLog = dataOperationLogService.createLog(logDTO);
        return new ResponseEntity<>(createdLog, HttpStatus.CREATED);
    }

    @DeleteMapping("/{logId}")
    public ResponseEntity<Void> deleteLog(@PathVariable Integer logId) {
        dataOperationLogService.deleteLog(logId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<DataOperationLogDTO>> getLogsByUserId(@PathVariable Integer userId) {
        List<DataOperationLogDTO> logs = dataOperationLogService.getLogsByUserId(userId);
        return new ResponseEntity<>(logs, HttpStatus.OK);
    }
}
