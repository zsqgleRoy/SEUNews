package com.royzhang.seunewswebsite.entity;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "data_operation_logs")
public class DataOperationLog {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer log_id;

    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "table_name")
    private String tableName;

    @Enumerated(EnumType.STRING)
    private OperationType operationType;

    @Column(name = "operation_time")
    private Date operationTime;

    @Lob
    private String operationDetail;

    // 构造函数、Getter 和 Setter 方法
    public DataOperationLog() {}

    public Integer getLog_id() {
        return log_id;
    }

    public void setLog_id(Integer log_id) {
        this.log_id = log_id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public OperationType getOperationType() {
        return operationType;
    }

    public void setOperationType(OperationType operationType) {
        this.operationType = operationType;
    }

    public Date getOperationTime() {
        return operationTime;
    }

    public void setOperationTime(Date operationTime) {
        this.operationTime = operationTime;
    }

    public String getOperationDetail() {
        return operationDetail;
    }

    public void setOperationDetail(String operationDetail) {
        this.operationDetail = operationDetail;
    }

    public enum OperationType {
        INSERT, UPDATE, DELETE
    }
}
