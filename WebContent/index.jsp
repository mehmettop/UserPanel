<%@ taglib tagdir='/WEB-INF/tags' prefix='sc'%>
<!DOCTYPE html>
<html>
	<head>
		<link href="${pageContext.request.contextPath}/resources/css/userpanel_style.css" rel="stylesheet">
		<script type="text/javascript" src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
   		 <script>
   		 
   		 function addUser(){
   			document.getElementById("rightPanel").style.visibility = "visible";
   			document.getElementById("confirmBtn").onclick = function() { saveUser(true); }
   			$("#usertable tr.selected").removeClass('selected');
   			clearForm();
   			reloadCaptcha();
   		}
   		 
   		 function clearForm(){
   			 document.getElementById("usernameInput").value="";
    		 document.getElementById("lastnameInput").value="";
    		 document.getElementById("phonenumberInput").value="";
   		 }
   		 
   		 function reloadCaptcha(){
   			document.getElementById("recaptcha_reload").click();
   			 document.getElementById("recaptcha_image").style.border = "none";
   		 }
   		 
   		 function editUser(){
			reloadCaptcha();
   			document.getElementById("recaptcha_reload").click();
   			document.getElementById("rightPanel").style.visibility = "visible"
   			document.getElementById("confirmBtn").onclick = function() { saveUser(false); }
   			var id = $("#usertable tr.selected td:first").html();
   			var username = $("#usertable tr.selected td:eq(1)").html();
   			var lastname = $("#usertable tr.selected td:eq(2)").html();
   			var phonenumber = $("#usertable tr.selected td:last").html();
   			document.getElementById("usernameInput").setAttribute("value", username);
   			document.getElementById("lastnameInput").setAttribute("value", lastname);
   			document.getElementById("phonenumberInput").setAttribute("value", phonenumber);
   		}
   		 
   		function saveUser(isNewUser){
   			
   			var params='';
   			var username = document.getElementById("usernameInput").value;
   			var lastname = document.getElementById("lastnameInput").value;
   			var phonenumber = document.getElementById("phonenumberInput").value;
   			var recaptcha_challenge_field = document.getElementById("recaptcha_challenge_field").value;
   			var recaptcha_response_field = document.getElementById("recaptcha_response_field").value;
   			//--
   			if(isNewUser){
   				params = 'id=-1&username='+username+'&lastname='+lastname+'&phonenumber='+phonenumber+'&recaptcha_challenge_field='+recaptcha_challenge_field+'&recaptcha_response_field='+recaptcha_response_field;
   			}else{
   				var id = $("#usertable tr.selected td:first").html();
   				params = 'id='+id+'&username='+username+'&lastname='+lastname+'&phonenumber='+phonenumber+'&recaptcha_challenge_field='+recaptcha_challenge_field+'&recaptcha_response_field='+recaptcha_response_field;
   			}
   			var http = new XMLHttpRequest();
   			var url = "http://localhost:8080/UserPanel/save.html";
   			
   			http.open("POST", url, true);

   			http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
   			http.setRequestHeader("Content-length", params.length);
   			http.setRequestHeader("Connection", "close");

   			http.onreadystatechange = function() {//Call a function when the state changes.
   			    if(http.readyState == 4 && http.status == 200) {
   			       if (http.responseText != "success") {
   			    		document.getElementById("resultTxt").innerHTML = http.responseText;
   			       }else {
   			    	   
   			    	   if(!isNewUser){
   	   			    	$("#usertable tr.selected").removeClass('selected');
   	   			       }
   	   			       showCustomer();
   	   			       checkTableElements();
   	   			 	   document.getElementById("loadingText").innerHTML="User Data Applied !";
   			       }
   			    }
   			}
   			http.send(params);
   			document.getElementById("loadingText").innerHTML="User Data Is Applying...";
   		}
   		 
   		 
   		function deleteUser(){
   			var r = confirm("User will be deleted !");
   			if (r == false) {
   				$("#usertable tr.selected").removeClass('selected');
   				showCustomer();
			    checkTableElements();
   				return;
   			} 
   			var id = $("#usertable tr.selected td:first").html();
   			var  formData = 'id:"'+id+'"';
   			var http = new XMLHttpRequest();
   			var url = "http://localhost:8080/UserPanel/delete.html";
   			var params = 'id='+id;
   			http.open("POST", url, true);

   			http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
   			http.setRequestHeader("Content-length", params.length);
   			http.setRequestHeader("Connection", "close");

   			http.onreadystatechange = function() {//Call a function when the state changes.
   			    if(http.readyState == 4 && http.status == 200) {
   			       $("#usertable tr.selected").removeClass('selected');
   			       showCustomer();
   			       checkTableElements();
   			    document.getElementById("loadingText").innerHTML="Deleted !";
   			    }
   			}
   			http.send(params);
   			document.getElementById("loadingText").innerHTML="User Data Is Deleting...";
   		}
   		 
   		function clickTable(rowElement)
		{
   			$(rowElement).addClass('selected').siblings().removeClass('selected');
			var value=$(rowElement).find('td:first').html();
			checkTableElements();
		}
   		 
    		$( document ).ready(function() {
    			showCustomer();
    			checkTableElements();
    		});
    		
    		function checkTableElements(){
    			if($("#usertable tr.selected td:first").html() == undefined){
    				document.getElementById("editBtn").disabled = true;
        			document.getElementById("deleteBtn").disabled = true;
    			}else{
    				document.getElementById("editBtn").disabled = false;
        			document.getElementById("deleteBtn").disabled = false;
        			document.getElementById("rightPanel").style.visibility = "hidden";
    			}
    		}
    		
    		function showCustomer()
    		{
    		var xmlhttp;    
    		if (window.XMLHttpRequest)
    		  {// code for IE7+, Firefox, Chrome, Opera, Safari
    		  xmlhttp=new XMLHttpRequest();
    		  }
    		xmlhttp.onreadystatechange=function()
    		  {
    		  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    		    {
    		    	var arr = JSON.parse(xmlhttp.responseText);
    		    	var out ='<table id="usertable"><tr><th id="id">#ID</th><th id="username">Username</th><th id="lastname">Lastname</th><th id="phonenumber">Phone Number</th></tr>';
    		    	for(var i=0;i<arr.length;i++){
    		    		var tmp = '<tr onclick="clickTable(this)"><td headers="id">'+arr[i].id+'</td><td headers="username">'+arr[i].username+'</td><td headers="lastname">'+arr[i].lastname+'</td><td headers="phonenumber">'+arr[i].phonenumber+'</td></tr>'
    		    		out = out + tmp;
    		    	}
    		    	out += "</table>";
    		    	document.getElementById("userInfoTable").innerHTML=out;
    		    	document.getElementById("rightPanel").style.visibility = "hidden"
    		    	document.getElementById("loadingText").innerHTML="Loading Complete";
    		    }
    		  }
    		xmlhttp.open("GET","http://localhost:8080/UserPanel/update.html",true);
    		xmlhttp.send();
	    	document.getElementById("loadingText").innerHTML="User Data Is Loading...";
    		}
    	</script>
	</head>
	<body>
		<div id="mainScreen">
			<div id="loadingText"></div>
			<div id="middlePanel">
				<div id="buttonPanel">
					<button class="Btn" id="addBtn" type="button" onclick="addUser()">Add</button>
					<button class="Btn" id="editBtn" type="button" onclick="editUser()">Edit</button>
					<button class="Btn" id="deleteBtn" type="button" onclick="deleteUser()">Delete</button>
				</div>
				<div id="userInfoTable"></div>
			</div>
			<div id="rightPanel">
				<div id="resultTxt">Please fill whole form !</div>
				<form id="inputArea">
					<div class="inputLine"><div class="lbl">FirstName   :</div><input type="text" name="firstname" id="usernameInput"  value=""></div>
					<div class="inputLine"><div class="lbl">LastName 	 :</div><input type="text" name="lastname" id="lastnameInput"	value=""></div>
					<div class="inputLine"><div class="lbl">PhoneNumber :</div><input type="text" name="lastname" id="phonenumberInput"value=""></div>
				</form>
				<sc:captcha/>
				<button  id="confirmBtn" type="button">Save User</button>
			</div>
		</div>
	</body>
</html>