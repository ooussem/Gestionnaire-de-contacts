<%@page import="service.ContactServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean"%>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html"%>
<%@ page import="DAO.ContactDAO"%>
<%@ page import="service.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*"%>
<%@taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet"
	href="http://www.w3schools.com/lib/w3-theme-black.css">
<title><bean:message key="modifier.supprimer" /></title>
<style>
input {
	padding: 10px;
}
</style>
</head>
<body>
	<ul class="nav nav-pills">
		<li role="presentation" class="active"><a href="Main.jsp"><bean:message
					key="main.page.accueil" /></a></li>
		<li role="presentation"><a href="ViewContactForm.do"><bean:message
					key="main.contacts" /></a></li>
		<li role="presentation"><a href="MainGroupContact.jsp"><bean:message
					key="main.groupes.contacts" /></a></li>
	</ul>
	<br />
	<br />
	<br />
	<div class="w3-container w3-teal">
		<h2>
			<center>
				<bean:message key="main.modifier.supprimer.contact" />
			</center>
		</h2>
	</div>
	<table class="w3-table w3-bordered w3-red w3-card-4 w3-hover-classes">
		<tr class="w3-dark-grey">
			<td><bean:message key="nom" /></td>
			<td><bean:message key="prenom" /></td>
			<td><bean:message key="mail" /></td>
			<%-- 	<td><bean:message key="tel" /></td> --%>
			<td><bean:message key="action" /></td>
		</tr>
		<logic:iterate id="contact" name="listEditContacts">
			<tr>
				<td><bean:write name="contact" property="prenom" /></td>
				<td><bean:write name="contact" property="nom" /></td>
				<td><bean:write name="contact" property="mail" /></td>
				<td><bean:write name="contact" property="mail" /></td>
				<td><a
					href="EditContact.jsp?id=<bean:write name="contact" property="contact_ID" />">
						<bean:message key="modifier" /> >
				</a></td>
			</tr>
		</logic:iterate>
	</table>
</body>
</html>