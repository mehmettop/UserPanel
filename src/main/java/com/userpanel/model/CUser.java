package main.java.com.userpanel.model;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "userpanel")
public class CUser {
	@Id
	private String id;

	String username;
	String lastname;
	String phonenumber;

	public String getPhoneNumber() {
		return phonenumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phonenumber = phoneNumber;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getLastname() {
		return lastname;
	}

	public void setPassword(String lastname) {
		this.lastname = lastname;
	}

	public CUser(String username, String lastname, String phonenumber) {
		super();
		this.username = username;
		this.lastname = lastname;
		this.phonenumber = phonenumber;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", lastname=" + lastname + ", phonenumber=" + phonenumber + "]";
	}
}

