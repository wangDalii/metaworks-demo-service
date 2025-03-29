/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2012-2019. All rights reserved.
 *
 */

package com.huawei.metaworks.demo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.event.EventListener;

import java.util.TimeZone;

/**
 * The Class IamApplication.
 *
 * @since 2018-08-01
 */
@SpringBootApplication
@ComponentScan(basePackages = {
    "com.huawei.ucmarket.security", "com.huawei.metaworks.demo"
})
public class DemoApplication {
    private static final Logger LOGGER = LoggerFactory.getLogger(DemoApplication.class);

    /**
     * The main method.
     *
     * @param args the arguments
     */
    public static void main(String[] args) {
        final TimeZone zone = TimeZone.getTimeZone("GMT+0");
        TimeZone.setDefault(zone);
        SpringApplication application = new SpringApplication(DemoApplication.class);
        application.run(args);
    }

    @EventListener(ApplicationReadyEvent.class)
    public void test() {
        //  推送采用权限先标签 使用事件监听方式,用于判断
        LOGGER.info("App started");
    }
}