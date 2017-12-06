package model;

public class PhoneNumber {
	private long phone_ID;
	private String phoneNumber;
	private Contact contact;

	public PhoneNumber() {
	}

	public PhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	
	
	
	public PhoneNumber(long phone_ID, String phoneNumber) {
		this.phone_ID = phone_ID;
		this.phoneNumber = phoneNumber;
	}

	public PhoneNumber(long phone_ID, String phoneNumber, Contact contact) {
		this.phone_ID = phone_ID;
		this.phoneNumber = phoneNumber;
		this.contact = contact;
	}
	
	

	public long getPhone_ID() {
		return phone_ID;
	}

	public void setPhone_ID(long phone_ID) {
		this.phone_ID = phone_ID;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public Contact getContact() {
		return contact;
	}

	public void setContact(Contact contact) {
		this.contact = contact;
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PhoneNumber other = (PhoneNumber) obj;
		if (phone_ID != other.phone_ID)
			return false;
		return true;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (phone_ID ^ (phone_ID >>> 32));
		return result;
	}

	@Override
	public String toString() {
		return "PhoneNumber {id=" + this.phone_ID + ", phoneNumber=" + phoneNumber + ", contact=" + contact.getContact_ID() + "}";
	}

	
	
	
	

}
