package com.asialink.affection.config;

import lombok.AllArgsConstructor;
import lombok.Data;

import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.EnvironmentAware;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;


@Component
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CouchDBInfo implements EnvironmentAware {

    @Value(value = "${couchdb.tweet.host}")
    private String tweet_host;

    @Value(value = "${couchdb.mastodon.mastodonDB}")
    private String mastodonDB;

    @Value(value = "${couchdb.mastodon.host}")
    private String mastodon_host;

    @Value(value = "${couchdb.tweet.port}")
    private String tweet_port;

    @Value(value = "${couchdb.mastodon.port}")
    private String mastodon_port;

    @Value(value = "${couchdb.tweet.tweetDB}")
    private String tweetDB;

    @Value(value = "${couchdb.tweet.sudoDB}")
    private String sudoDB;

    @Value(value = "${couchdb.tweet.username}")
    private String tweet_username;

    @Value(value = "${couchdb.tweet.password}")
    private String tweet_password;

    @Value(value = "${couchdb.mastodon.username}")
    private String mastodon_username;

    @Value(value = "${couchdb.mastodon.password}")
    private String mastodon_password;


    @Override
    public void setEnvironment(Environment environment) {

    }

}
