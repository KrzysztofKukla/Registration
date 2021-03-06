<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<spring:message var="title" code="title.registration" />
<spring:message var="login" code="account.form.label.login" />
<spring:message var="password" code="account.form.label.password" />
<spring:message var="confirmPassword" code="account.form.label.confirm_password" />
<spring:message var="register" code="account.form.label.register" />
<spring:message var="requiredField" code="account.form.required" />
<spring:message var="samePasswords" code="account.form.same_passwords" />
<spring:message var="minLength" code="account.form.min_length" />
<spring:message var="uniqueLogin" code="account.form.unique_login" />
<spring:message var="alphanumericOnly" code="account.form.alphanumeric_only" />
<spring:message var="digitUppercaseLowercase" code="account.form.digit_uppercase_lowercase" />
<spring:message var="registerSuccess" code="registration.success" />
<spring:url var="checkUser" value="/checkUser" />
<spring:url var="saveUser" value="/saveUser" />
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="<c:url value="/resources/css/main.css" />" rel="stylesheet" type="text/css" />
	<script src="<c:url value="resources/js/jquery-2.1.4.min.js" />" ></script>
	<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>
	<title>${title}</title>
</head>
<body>
<form:form id="registrationForm" action="." modelAttribute="account" >
<table>
	<tr>
		<td><form:errors path="*"></form:errors></td>
	</tr>
	<tr>
		<td>${login}</td>
		<td><form:input id="login" name="login" path="login" /></td>
	</tr>
	<tr>
		<td>${password}</td>
		<td><form:password id="password" name="password" path="password" /></td>
	</tr>	
	<tr>
		<td>${confirmPassword}</td>
		<td><form:password id="confirmPassword" name="confirmPassword" path="confirmPassword" /></td>
	</tr>	
	<tr>
		<td colspan="2"><input type="submit" value="${register}"/></td>
	</tr>
</table>
</form:form>

</body>
</html>

<script type="text/javascript">
var login = $("#login");
var freeLogin = true;
$(document).ready(function(){
	var registrationForm=$("#registrationForm");
	registrationForm.validate({
		rules:{
			login:{
				required: true,
				minlength: 6,
				alphanumeric: true,
				freeLogin: true,
			},
			password:{
				required: true,
				minlength: 8,
				digitUppercaseLowercase : true,
			},
			confirmPassword:{
				required: true,
				equalTo : "#password",
			}
		},
		messages:{
			login:{
				required: '${requiredField}',
				minlength: '${minLength}',
			},
			password:{
				required: '${requiredField}',
				minlength: '${minLength}',
			},
			confirmPassword:{
				required: '${requiredField}',
				equalTo : '${samePasswords}',
			}
		},
		errorPlacement: function(error, element){
			error.insertAfter(element);
		},
		submitHandler: function(form){
			form.submit();
			alert('${registerSuccess}');
		}
	});
});
jQuery.validator.addMethod("alphanumeric", function(value, element) {
    return this.optional(element) || /^[a-zA-Z0-9]+$/.test(value)
	},
	'${alphanumericOnly}'
); 
jQuery.validator.addMethod("freeLogin", function(value, element){
		$.ajax({
			type: 'GET',
			url: '${checkUser}/'+login.val(),
			contentType: "application/json",
			success: function(data){
				freeLogin = data;
			},
			dataType: 'json',
		});
		return freeLogin;
	},
	'${uniqueLogin}'
);
jQuery.validator.addMethod("digitUppercaseLowercase", function(value, element) {
    return this.optional(element) || /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$/.test(value)
	},
	'${digitUppercaseLowercase}'
); 
</script>
