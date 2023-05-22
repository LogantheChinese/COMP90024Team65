package com.asialink.affection.service.impl;

import com.asialink.affection.domain.ResponseResult;

public interface MastodonDataService {

    ResponseResult getAllMastodonData();

    ResponseResult getAllMastodonNegativeData();
}
