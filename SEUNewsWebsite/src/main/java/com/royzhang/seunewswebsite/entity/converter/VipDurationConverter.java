package com.royzhang.seunewswebsite.entity.converter;

import com.royzhang.seunewswebsite.entity.Vip.VipDuration;
import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;
import java.util.Arrays;

@Converter(autoApply = true)
public class VipDurationConverter implements AttributeConverter<VipDuration, String> {

    @Override
    public String convertToDatabaseColumn(VipDuration duration) {
        if (duration == null) return null;
        return duration.getDisplayName(); // 存入数据库时使用显示名称
    }

    @Override
    public VipDuration convertToEntityAttribute(String dbData) {
        if (dbData == null) return null;
        return Arrays.stream(VipDuration.values())
                .filter(d -> d.getDisplayName().equals(dbData))
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException("无效的时长类型: " + dbData));
    }
}