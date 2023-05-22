package com.asialink.affection.enumpkg;

public enum AppHttpCodeEnum {
    // 成功
    SUCCESS(200,"Successful operation"),
    // 登录
    NEED_LOGIN(401,"Login required"),
    NO_OPERATOR_AUTH(403,"Unauthorized operation"),
    SYSTEM_ERROR(500,"An error occurred"),
    USERNAME_EXIST(501,"Username already exists"),
    PHONENUMBER_EXIST(502,"Phone number already exists"),
    EMAIL_EXIST(503, "Email already exists"),
    REQUIRE_USERNAME(504, "Username is required"),
    LOGIN_ERROR(505,"wrong user name or password"),
    CONTENT_NOT_NULL(506, "Comment content cannot be empty"),
    FILE_TYPE_ERROR(507, "Incorrect file type, please upload png file"),
    USERNAME_NOT_NULL(508, "Username can not be empty"),
    NICKNAME_NOT_NULL(509, "username can not be blank"),
    PASSWORD_NOT_NULL(510, "password can not be blank"),
    EMAIL_NOT_NULL(511, "Email can not be empty"),
    NICKNAME_EXIST(512, "Nickname already exists");

    int code;
    String msg;

    AppHttpCodeEnum(int code, String errorMessage){
        this.code = code;
        this.msg = errorMessage;
    }

    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}

