package demo;

import com.huawei.ucmarket.security.permission.annotation.IPlatFormRole;
import com.huawei.ucmarket.security.permission.annotation.TagItem;

/**
 * 功能描述
 *
 * @since 2021-12-17
 */
public interface IPermissionTagConstant {
    @TagItem(tagName = "管理员标签", tagNameEN = "adminTag", microService = "分组组名1", microServiceEN = "groupname1")
    String ADMIN_TAG = "adminTag";

    @TagItem(tagName = "用户标签", tagNameEN = "userTag", platformRoles = {
        IPlatFormRole.USER_ROLE_ID
    })
    String USER_TAG = "userTag";
}
