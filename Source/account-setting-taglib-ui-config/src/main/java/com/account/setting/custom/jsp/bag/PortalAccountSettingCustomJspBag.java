package com.account.setting.custom.jsp.bag;

import com.liferay.portal.custom.jsp.bag.BaseCustomJspBag;
import com.liferay.portal.deploy.hot.CustomJspBag;

import org.osgi.service.component.annotations.Component;

@Component(
		immediate = true,
		property = {
			"context.id=PortalAccountSettingCustomJspBag",
			"context.name=Portal Accout Setting Custom Jsp Bag",
			"service.ranking:Integer=20"
		}
	)
public class PortalAccountSettingCustomJspBag extends BaseCustomJspBag implements CustomJspBag {

	
}
