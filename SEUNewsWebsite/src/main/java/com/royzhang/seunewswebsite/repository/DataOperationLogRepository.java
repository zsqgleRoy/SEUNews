package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.DataOperationLog;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface DataOperationLogRepository extends JpaRepository<DataOperationLog, Integer> {

    List<DataOperationLog> findByUserId(Integer userId);
}
