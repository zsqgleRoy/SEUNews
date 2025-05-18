package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.ChatRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ChatRecordRepository extends JpaRepository<ChatRecord, Long> {
    List<ChatRecord> findBySessionIdOrderByTimestampAsc(String sessionId);
    List<ChatRecord> findByUserId(int sessionId);
}