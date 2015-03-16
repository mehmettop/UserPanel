package main.java.com.userpanel.config;

import org.springframework.context.annotation.Bean;
import org.springframework.data.mongodb.config.AbstractMongoConfiguration;

import com.mongodb.Mongo;
import com.mongodb.MongoClient;

public class CMongoDBConfig extends AbstractMongoConfiguration{
	@Override
	public String getDatabaseName() {
		return "userapp";
	}

	@Override
	@Bean
	public Mongo mongo() throws Exception {
		return new MongoClient("127.0.0.1");
	}
}
