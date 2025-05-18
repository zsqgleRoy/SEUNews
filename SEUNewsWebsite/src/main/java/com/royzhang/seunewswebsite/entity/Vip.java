package com.royzhang.seunewswebsite.entity;

import com.fasterxml.jackson.annotation.JsonValue;
import com.royzhang.seunewswebsite.entity.converter.VipDurationConverter;
import lombok.Data;
import jakarta.persistence.*;
import lombok.Getter;

import java.math.BigDecimal;

@Entity
@Table(name = "vip")
@Data
public class Vip {

    public enum VipType {
        VIP1, VIP2, VIP3, VIP4, VIP5, VIP6, VIP7, VIP8, VIP9, VIP10,
        SVIP1, SVIP2, SVIP3, SVIP4, SVIP5, SVIP6, SVIP7, SVIP8, SVIP9, SVIP10, SVIP_PLUS
    }

    @Getter
    public enum VipDuration {
        MONTH1("1个月"),
        MONTH3("3个月"),
        MONTH6("6个月"),
        YEAR1("12个月"),
        YEAR2("24个月"),
        YEAR4("48个月");

        @JsonValue
        private final String displayName;

        VipDuration(String displayName) {
            this.displayName = displayName;
        }
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Enumerated(EnumType.STRING)
    @Column(name = "type", nullable = false, columnDefinition = "ENUM('VIP1','VIP2','VIP3','VIP4','VIP5','VIP6','VIP7','VIP8','VIP9','VIP10','SVIP1','SVIP2','SVIP3','SVIP4','SVIP5','SVIP6','SVIP7','SVIP8','SVIP9','SVIP10','SVIP+')")
    private VipType type = VipType.VIP1;

    @Convert(converter = VipDurationConverter.class)
    @Column(name = "durations", nullable = false)
    private VipDuration durations = VipDuration.MONTH1;

    @Column(name = "durations_value")
    private Integer durationsValue;

    @Column(name = "discount", precision = 3, scale = 2)
    private BigDecimal discount;

    @Column(name = "price", precision = 6, scale = 2)
    private BigDecimal price;
}