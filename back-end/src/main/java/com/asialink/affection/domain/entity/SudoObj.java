package com.asialink.affection.domain.entity;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@Accessors
@AllArgsConstructor
@NoArgsConstructor
public class SudoObj {
    public String _id;
    public String _rev;
    public String city;
    public Double unemployment;
    public String year;
    public String month;
}
