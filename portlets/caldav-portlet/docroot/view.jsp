<!--
/**
 * Copyright (c) 2013 SMC Treviso Srl. All rights reserved.
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
-->

<%@ include file="/init.jsp" %>

<%
String portalURL = PortalUtil.getPortalURL(request);
List<Calendar> calendars = CalendarUtil.getAllCalendars(permissionChecker);

String userCalDAVURL = portalURL + CalDAVUtil.getPrincipalURL(themeDisplay.getUserId());
%>

<div class="well">
	<h2>
		<liferay-ui:message key="caldav-url-for-collection" />
		<liferay-ui:icon-help message="caldav-url-for-collection-help" />
	</h2>
	<aui:fieldset>
		<p class="calendar-url-entry">
			<span class="entry-title"><%= user.getFullName() %></span>
			<span class="entry-url"><%= userCalDAVURL %></span>
		</p>
	</aui:fieldset>
</div>

<div class="well">
	<h2>
		<liferay-ui:message key="caldav-url-without-collection" />
		<liferay-ui:icon-help message="caldav-url-without-collection-help" />
	</h2>
	<aui:fieldset>

		<%
		String calDAVURL;
		StringBuilder calendarTitleSb;
		CalendarResource calendarResource;
		for (Calendar calendar : calendars) {
			calDAVURL = portalURL + CalDAVUtil.getCalendarURL(calendar);

			calendarResource = calendar.getCalendarResource();

			calendarTitleSb = new StringBuilder();
			calendarTitleSb.append(calendarResource.getName(locale));
			calendarTitleSb.append(StringPool.SPACE);
			calendarTitleSb.append(StringPool.MINUS);
			calendarTitleSb.append(StringPool.SPACE);
			calendarTitleSb.append(calendar.getName(locale));

			if (!CalendarPermission.contains(permissionChecker, calendar, "MANAGE_BOOKINGS")) {
				calendarTitleSb.append(StringPool.SPACE);
				calendarTitleSb.append(StringPool.OPEN_PARENTHESIS);
				calendarTitleSb.append(LanguageUtil.get(locale, "read-only"));
				calendarTitleSb.append(StringPool.CLOSE_PARENTHESIS);
			}
			%>

			<p class="calendar-url-entry">
				<span class="entry-title"><%= calendarTitleSb.toString() %></span>
				<span class="entry-url"><%= calDAVURL %></span>
			</p>

			<%
		}
		%>

	</aui:fieldset>
</div>