package com.asialink.affection.service.impl;

import com.alibaba.fastjson.JSON;
import com.asialink.affection.domain.ResponseResult;
import com.asialink.affection.domain.entity.TweetData;
import org.ektorp.CouchDbConnector;
import org.ektorp.ViewQuery;
import org.ektorp.ViewResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class TweetDataServiceImpl implements TweetDataService {

    @Qualifier("couchDbConnectorTweet")
    @Autowired
    CouchDbConnector couchDbConnectorTweet;

    @Override
    public ResponseResult getAllTweetData() {
        ViewQuery query = new ViewQuery()
                .designDocId("_design/tweet")
                .viewName("all_count").group(true);
        ViewResult rows = couchDbConnectorTweet.queryView(query);
        List<TweetData> tweetDataList = rows.getRows().stream().map((x) ->
                JSON.parseObject(x.toString(), TweetData.class)
        ).collect(Collectors.toList());
        return ResponseResult.okResult(tweetDataList);
    }

    @Override
    public ResponseResult getAllTweetNegativeData() {
        ViewQuery query = new ViewQuery()
                .designDocId("_design/tweet")
                .viewName("negative_count").group(true);
        ViewResult rows = couchDbConnectorTweet.queryView(query);
        List<TweetData> tweetDataList = rows.getRows().stream().map((x) ->
                JSON.parseObject(x.toString(), TweetData.class)
        ).collect(Collectors.toList());
        return ResponseResult.okResult(tweetDataList);
    }
}
