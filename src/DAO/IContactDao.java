package DAO;

import java.sql.SQLException;
import java.util.List;
import java.util.Set;

import model.Contact;
import model.Group;

public interface IContactDao {

	public boolean insertDB(Object object) throws Exception;

	public boolean insertDBObjects(List<Object> objects) throws Exception;

	public List<Object[]> executerRequete(String requete) throws SQLException;

	public Contact getContact(long contact_ID);

	public Contact getContactHQL(long contactId);

	public List<Contact> getAllContacts();

	public Set<Group> getAllGroups();

	public Group getGroup(long groupId);

	public Set<Contact> getContactsByGroupId(long groupId);

	public Set<Contact> searchContacts(String search);

	public boolean saveUpdate(Contact contact);

	public boolean deleteContact(long contact_ID);

	public boolean deleteGroup(long group_ID);

}