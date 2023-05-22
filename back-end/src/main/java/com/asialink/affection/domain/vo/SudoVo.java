package com.asialink.affection.domain.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@Accessors
@NoArgsConstructor
@AllArgsConstructor
public class SudoVo {
    public String city;
    public Double unemployment;
    public String year;
    public String month;
}
