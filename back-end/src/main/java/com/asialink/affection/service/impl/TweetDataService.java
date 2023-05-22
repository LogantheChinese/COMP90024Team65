package com.asialink.affection.service.impl;

import com.asialink.affection.domain.ResponseResult;

public interface TweetDataService {
    ResponseResult getAllTweetData();

    ResponseResult getAllTweetNegativeData();
}
