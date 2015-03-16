package main.java.com.userpanel.controller;

import java.util.ArrayList;
import java.util.List;
import main.java.com.userpanel.config.CMongoDBConfig;
import main.java.com.userpanel.model.CUser;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class _CUserPanelController {

	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public @ResponseBody String getTime() {

		ApplicationContext ctx = new AnnotationConfigApplicationContext(CMongoDBConfig.class);
		MongoOperations mongoOperation = (MongoOperations) ctx.getBean("mongoTemplate");
		List<CUser> listUser = mongoOperation.findAll(CUser.class);
		List<String> returnList = new ArrayList<String>();
		for (CUser User : listUser) {
			String id = "\"id\":" + "\"" + User.getId() + "\",";
			String userName = "\"username\":" + "\"" + User.getUsername() + "\",";
			String lastname = "\"lastname\":" + "\"" + User.getLastname() + "\",";
			String phonenumber = "\"phonenumber\":" + "\"" + User.getPhoneNumber() + "\"";
			String tmp = "{" + id + userName + lastname + phonenumber + "}";
			returnList.add(tmp);
		}
		return returnList.toString();
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public @ResponseBody String someMethod(@RequestParam("id") String valueOne) {

		System.out.println("ID : >" + valueOne);
		ApplicationContext ctx = new AnnotationConfigApplicationContext(CMongoDBConfig.class);
		MongoOperations mongoOperation = (MongoOperations) ctx.getBean("mongoTemplate");
		Query searchUserQuery = new Query(Criteria.where("id").is(valueOne));
		mongoOperation.remove(searchUserQuery, CUser.class);
		return "User Deleted";
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public @ResponseBody String editMethod(@RequestParam("id") String id, @RequestParam("username") String username, @RequestParam("lastname") String lastname,
			@RequestParam("phonenumber") String phonenumber) {

		ApplicationContext ctx = new AnnotationConfigApplicationContext(CMongoDBConfig.class);
		MongoOperations mongoOperation = (MongoOperations) ctx.getBean("mongoTemplate");
		// --
		System.out.println("ID : " + id);
		System.out.println("USERNAME : " + username);
		System.out.println("LASTNAME : " + lastname);
		System.out.println("PHONENUMBER : " + phonenumber);
		// --
		if (id.equals("-1")) {
			// --NEW USER
			CUser user = new CUser(username, lastname, phonenumber);
			mongoOperation.save(user);
		} else {
			// --EDITED USER
			Query searchUserQuery = new Query(Criteria.where("id").is(id));
			mongoOperation.updateFirst(searchUserQuery, Update.update("username", username), CUser.class);
			mongoOperation.updateFirst(searchUserQuery, Update.update("lastname", lastname), CUser.class);
			mongoOperation.updateFirst(searchUserQuery, Update.update("phonenumber", phonenumber), CUser.class);
		}
		return "User Saved";
	}
}
