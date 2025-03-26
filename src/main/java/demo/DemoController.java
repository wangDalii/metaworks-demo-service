/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2020-2020. All rights reserved.
 *
 */

package demo;

import com.huawei.ucmarket.security.permission.annotation.RoleTags;
import com.huawei.ucmarket.security.permission.tool.CommonHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * Cloud url config controller
 *
 * @since 1.0
 */

@RestController
@RequestMapping("/demo")
public class DemoController {

    private static final Logger LOGGER = LoggerFactory.getLogger(DemoController.class);

    /**
     * @return
     */
    @RoleTags(tags = {IPermissionTagConstant.ADMIN_TAG})
    @RequestMapping(method = RequestMethod.GET, path = "/test", produces = "application/json;charset=UTF-8")
    public DemoVO demo() {
        DemoVO result = new DemoVO();
        result.setCode("200");
        result.setMessage("demo");
        LOGGER.info("test");
        CommonHelper.getCurrentTenantId();
        return result;
    }

    @RoleTags(tags = {IPermissionTagConstant.ADMIN_TAG, IPermissionTagConstant.USER_TAG})
    @RequestMapping(method = RequestMethod.GET, path = "/test2", produces = "application/json;charset=UTF-8")
    public DemoVO demo2() {
        DemoVO result = new DemoVO();
        result.setCode("200");
        result.setMessage("demo");
        return result;
    }
}
