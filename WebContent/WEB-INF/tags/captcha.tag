<%@ tag import="net.tanesha.recaptcha.ReCaptcha" %>
<%@ tag import="net.tanesha.recaptcha.ReCaptchaFactory" %>

<script type="text/javascript">var RecaptchaOptions = {theme : 'clean'};</script> 
<%
	ReCaptcha reCaptcha = ReCaptchaFactory.newReCaptcha("6LdWmwMTAAAAABQB7XKfFj2eHOtTkdI9_YqqTVOK", "6LdWmwMTAAAAAFmTrAtUkAc359ZJlm9mqDvawUZt", false);
	out.print(reCaptcha.createRecaptchaHtml(null, null));
%>