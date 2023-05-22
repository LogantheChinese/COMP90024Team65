package com.asialink.affection;

import com.asialink.affection.config.CouchDBInfo;
import org.ektorp.CouchDbConnector;
import org.ektorp.CouchDbInstance;
import org.ektorp.http.HttpClient;
import org.ektorp.http.StdHttpClient;
import org.ektorp.impl.StdCouchDbConnector;
import org.ektorp.impl.StdCouchDbInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.web.client.RestTemplate;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.oas.annotations.EnableOpenApi;
import springfox.documentation.service.*;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spi.service.contexts.SecurityContext;
import springfox.documentation.spring.web.plugins.Docket;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@SpringBootApplication(scanBasePackages = {"com.asialink.affection"})
@EnableOpenApi
//@EnableTransactionManagement
public class CCCApplication {

    public static void main(String[] args) {
        ConfigurableApplicationContext run = SpringApplication.run(CCCApplication.class, args);

    }

    @Autowired
    public HttpMessageConverter fastJsonHttpMessageConverters;

    @Bean
    public RestTemplate restTemplate() {
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.getMessageConverters().add(fastJsonHttpMessageConverters);
        return restTemplate;
    }

    @Autowired
    public CouchDBInfo couchDBInfo;

//    todo：暂时检测
    @Bean(name = "CouchDbConnectorSudo")
    public CouchDbConnector couchDbConnectorSudo() throws Exception {
        HttpClient httpClient = new StdHttpClient.Builder().url(couchDBInfo.getTweet_host() + ":"+ couchDBInfo.getTweet_port())
                .username(couchDBInfo.getTweet_username()).connectionTimeout(10000).socketTimeout(1000000)
                .password(couchDBInfo.getTweet_password()).build();
        CouchDbInstance couchDbInstance = new StdCouchDbInstance(httpClient);
        CouchDbConnector couchDbConnector = new StdCouchDbConnector(couchDBInfo.getSudoDB(), couchDbInstance);
        couchDbConnector.createDatabaseIfNotExists();
        return couchDbConnector;
    }

    @Bean(name = "couchDbConnectorTweet")
    public CouchDbConnector couchDbConnectorTweet() throws Exception {
        HttpClient httpClient = new StdHttpClient.Builder().url(couchDBInfo.getTweet_host() + ":"+ couchDBInfo.getTweet_port())
                .username(couchDBInfo.getTweet_username()).connectionTimeout(10000).socketTimeout(1000000)
                .password(couchDBInfo.getTweet_password()).build();
        CouchDbInstance couchDbInstance = new StdCouchDbInstance(httpClient);
        CouchDbConnector couchDbConnector = new StdCouchDbConnector(couchDBInfo.getTweetDB(), couchDbInstance);
        couchDbConnector.createDatabaseIfNotExists();
        return couchDbConnector;
    }

    @Bean(name = "couchDbConnectorMastodon")
    public CouchDbConnector couchDbConnectorMastodon() throws Exception {
        HttpClient httpClient = new StdHttpClient.Builder().url(couchDBInfo.getMastodon_host() + ":"+ couchDBInfo.getMastodon_port())
                .username(couchDBInfo.getMastodon_username()).connectionTimeout(10000).socketTimeout(1000000)
                .password(couchDBInfo.getMastodon_password()).build();
        CouchDbInstance couchDbInstance = new StdCouchDbInstance(httpClient);
        CouchDbConnector couchDbConnector = new StdCouchDbConnector(couchDBInfo.getMastodonDB(), couchDbInstance);
        couchDbConnector.createDatabaseIfNotExists();
        return couchDbConnector;
    }


    @Bean
    public Docket api() {
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
//                .securityContexts(Arrays.asList(securityContext()))
//                .securitySchemes(Arrays.asList(apiKey()))
                .select()
                .apis(RequestHandlerSelectors.any())
                .paths(PathSelectors.any())
                .build();
    }
//    private ApiKey apiKey() {
//        return new ApiKey("JWT", "token", "header");
//    }
//    private SecurityContext securityContext() {
//        return SecurityContext.builder().securityReferences(defaultAuth()).build();
//    }
//
//    private List<SecurityReference> defaultAuth() {
//        AuthorizationScope authorizationScope = new AuthorizationScope("global", "accessEverything");
//        AuthorizationScope[] authorizationScopes = new AuthorizationScope[1];
//        authorizationScopes[0] = authorizationScope;
//        return Arrays.asList(new SecurityReference("JWT", authorizationScopes));
//    }

    private ApiInfo apiInfo() {
        return new ApiInfo(
                "Asialink back-end API",
                "Asialink back-end API.",
                "1.0",
                "Terms of service",
                new Contact("Yuchen Li", "www.google.com", "yuchen10@student.unimelb.edu.au"),
                "License of API",
                "API license URL",
                Collections.emptyList());
    }


}
