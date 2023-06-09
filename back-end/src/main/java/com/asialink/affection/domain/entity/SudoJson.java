package com.asialink.affection.domain.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.util.ArrayList;
import java.util.List;

@Data
@Accessors
@AllArgsConstructor
@NoArgsConstructor
public class SudoJson {
    public String total_rows;
    public int offset;
    public ArrayList<sudoDocument> rows;
}
