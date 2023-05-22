package com.asialink.affection.domain.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import javax.swing.*;
import java.util.List;

@Data
@Accessors
@NoArgsConstructor
@AllArgsConstructor
public class TweetJson {
    public List<TweetData> rows;
}
