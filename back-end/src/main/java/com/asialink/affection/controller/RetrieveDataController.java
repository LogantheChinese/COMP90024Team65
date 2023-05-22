package com.asialink.affection.controller;

import com.asialink.affection.annotation.SystemLog;
import com.asialink.affection.domain.ResponseResult;
import com.asialink.affection.service.impl.MastodonDataService;
import com.asialink.affection.service.impl.SudoDataService;
import com.asialink.affection.service.impl.TweetDataService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping()
@Api(value = "Retrieve Data API", tags = {"Retrieve Data API"})
public class RetrieveDataController {


    @Autowired
    TweetDataService tweetDataService;

    @Autowired
    SudoDataService sudoDataService;

    @Autowired
    MastodonDataService mastodonDataService;

    //update
    @ApiOperation("getAllMastodonData.")
    @GetMapping("/getAllMastodonData")
    @SystemLog(businessName = "get All Mastodon Data")
    public ResponseResult getAllMastodonData(){
        return mastodonDataService.getAllMastodonData();
    }

    @ApiOperation("getAllMastodonNegativeData.")
    @GetMapping("/getAllMastodonNegativeData")
    @SystemLog(businessName = "get All Mastodon negative Data")
    public ResponseResult getAllMastodonNegativeData(){
        return mastodonDataService.getAllMastodonNegativeData();
    }

    //update
    @ApiOperation("getAllTweetData.")
    @GetMapping("/getAllTweetData")
    @SystemLog(businessName = "get All Tweet Data")
    public ResponseResult getAllTweetData(){
        return tweetDataService.getAllTweetData();
    }

    @ApiOperation("getAllTweetNegativeData.")
    @GetMapping("/getAllTweetNegativeData")
    @SystemLog(businessName = "get All Tweet negative Data")
    public ResponseResult getAllTweetNegativeData(){
        return tweetDataService.getAllTweetNegativeData();
    }

    @ApiOperation("getAllSudoData.")
    @GetMapping("/getAllSudoData")
    @SystemLog(businessName = "get All Sudo Data")
    public ResponseResult getAllSudoData(){
        return sudoDataService.getAllSudoData();
    }

}
