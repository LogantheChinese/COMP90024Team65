package com.asialink.affection.domain.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import javax.print.Doc;

@Data
@Accessors
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties({"id", "revision"})
public class sudoDocument {
    public String id;
    public String key;
    public CValue value;
    public SudoObj sudoObj;
}
