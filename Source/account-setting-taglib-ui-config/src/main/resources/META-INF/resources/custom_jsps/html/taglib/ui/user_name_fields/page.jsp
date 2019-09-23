<%--
/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="/html/taglib/ui/user_name_fields/init.jsp" %>


<aui:script sandbox="<%= true %>" use="liferay-portlet-url">
	var formData = {};

	var select = $('#<portlet:namespace />languageId');

	var userDetailsURL = Liferay.PortletURL.createURL('<%= HtmlUtil.escapeJS(themeDisplay.getURLCurrent()) %>');

	var userNameFields = $('#<portlet:namespace />userNameFields');

	select.on(
		'change',
		function(event) {
			_.forEach(
				$('#<portlet:namespace />fm').formToArray(),
				function(item, index) {
					var oldField = userNameFields.find('#' + item.name);

					if (oldField.length) {
						var data = {};

						data.value = item.value;

						var maxLength = oldField.attr('maxLength');

						if (maxLength) {
							data.maxLength = maxLength;
						}

						formData[item.name] = data;
					}
				}
			);

			userDetailsURL.setParameter('languageId', select.val());

			$.ajax(
				userDetailsURL.toString(),
				{
					beforeSend: function() {
						userNameFields.before('<div class="loading-animation" id="<portlet:namespace />loadingUserNameFields"></div>');

						userNameFields.hide();
					},
					complete: function() {
						$('#<portlet:namespace />loadingUserNameFields').remove();

						userNameFields.show();

						_.forEach(
							formData,
							function(item, index) {
								var newField = userNameFields.find('#' + index);

								if (newField) {
									newField.val(item.value);

									if (item.maxLength) {
										newField.attr('maxLength', item.maxLength);
									}
								}
							}
						);
					},
					success: function(responseData) {
						var responseUserNameFields = $(responseData).find('#<portlet:namespace />userNameFields').html();

						userNameFields.html(responseUserNameFields);
					},
					timeout: 5000
				}
			);
		}
	);
</aui:script>

<%
FullNameDefinition fullNameDefinition = FullNameDefinitionFactory.getInstance(userLocale);
User current_user = (User)request.getAttribute(WebKeys.USER);
Boolean permissionAdmin = false;
if(selUser!=null) {
List<Role> userRoles = RoleLocalServiceUtil.getUserRoles(selUser.getUserId());		
for(Role r : userRoles){        	 
    if("Administrator".equalsIgnoreCase(r.getName())){
   	 permissionAdmin = true;
   }        	
}    
}

List<Role> c_userRoles = RoleLocalServiceUtil.getUserRoles(current_user.getUserId());		
if(current_user!=null) {
for(Role r : c_userRoles){        	 
    if("Administrator".equalsIgnoreCase(r.getName())){
   	 permissionAdmin = true;
   }        	
}  
}
%>

<liferay-ui:error exception="<%= ContactNameException.MustHaveFirstName.class %>" message="please-enter-a-valid-first-name" />
<liferay-ui:error exception="<%= ContactNameException.MustHaveLastName.class %>" message="please-enter-a-valid-last-name" />

<div id="<portlet:namespace />userNameFields">
	<%
	for (FullNameField fullNameField : fullNameDefinition.getFullNameFields()) {
		String fieldName = CamelCaseUtil.toCamelCase(fullNameField.getName());
		if(!fieldName.equals("middleName")) {
	%>
		<c:choose>
			<c:when test="<%= fullNameField.isFreeText() %>">			
				<aui:input bean="<%= bean %>" disabled="<%= !permissionAdmin || !UsersAdminUtil.hasUpdateFieldPermission(permissionChecker, user, selUser, fieldName) %>" model="<%= User.class %>" name="<%= fieldName %>">
					<c:if test="<%= fullNameField.isRequired() %>">
						<aui:validator name="required" />
					</c:if>
				</aui:input>
			</c:when>			
		</c:choose>

	<%
	}
	}
	%>

</div>