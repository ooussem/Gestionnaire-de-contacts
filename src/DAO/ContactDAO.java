package DAO;


import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import org.hibernate.FetchMode;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import model.Contact;
import model.Group;
import model.PhoneNumber;
import util.HibernateUtil;


public class ContactDAO {
	public ContactDAO() {
	}

	// ****************************** Create ********************************
	/**
	 * Insert an object in database
	 * 
	 * @param object
	 * @return a boolean if instructions have finished without errors
	 * @throws HibernateException
	 */
	public boolean insertDB(Object object) throws Exception {
		boolean result = false;
		if (object == null)
			return result;
		else {
			try {
				Session session = HibernateUtil.getSessionFactory().openSession();
				session.beginTransaction();
				session.save(object);
				session.getTransaction().commit();
				session.close();
				result = true;
			} catch (HibernateException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	/**
	 * Insert objects in database
	 * 
	 * @param object
	 * @return a boolean if instructions have finished without errors
	 * @throws HibernateException
	 */
	public boolean insertDBObjects(List<Object> objects) throws Exception {
		boolean result = false;
		if (objects == null)
			return result;
		else {
			try {
				Session session = HibernateUtil.getSessionFactory().openSession();
				session.beginTransaction();
				
				for(Object o : objects){
					session.save(o);
				}
				
				session.getTransaction().commit();
				session.close();
				result = true;
			} catch (HibernateException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	

	@SuppressWarnings("unchecked")
	public List<Object[]> executerRequete(String requete) throws SQLException {
		Session session = HibernateUtil.getSessionFactory().openSession();
		session.beginTransaction();

		List<Object[]> result = session.createQuery(requete).list();
		session.getTransaction().commit();
		session.close();
		return result;
	}

	// ****************************** Read ********************************
	/**
	 *  
	 * @param contact_ID
	 * @return an object Contact
	 */
	public Contact getContact(long contact_ID) {
		Contact contact = null;
		try {
			Session session = HibernateUtil.getSessionFactory().openSession();
			contact = new Contact((Contact) session.createCriteria(Contact.class).add(Restrictions.like("contact_ID", contact_ID)).uniqueResult());
			//session.flush();
			session.evict(contact);
			session.clear();
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return contact;
	}
	
	public Contact getContact2(long contact_ID) {
		Contact contact = null;
		try {
			Session session = HibernateUtil.getSessionFactory().openSession();
			contact = new Contact((Contact) session.get(Contact.class, contact_ID));
			session.evict(contact);
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return contact;
	}
	
	
	
	
	public Set<Contact> getAllContactsLazy() {
		Set<Contact> contacts = new HashSet<Contact>();
		try {
			Session session = HibernateUtil.getSessionFactory().openSession();

			// Build query
			StringBuilder sb = new StringBuilder();
			sb.append("from Contact");

			// Execute query
			Query query = session.createQuery(sb.toString());

			@SuppressWarnings("unchecked")
			List<Contact> list = (List<Contact>) query.list();
			for (Contact contact : list) {
				Contact c = new Contact(contact.getNom(), contact.getPrenom(), contact.getMail());
				c.setContact_ID(contact.getContact_ID());
				contacts.add(c);
			}	

			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return contacts;
	}
	
	
	
	/**
	 * 
	 * @return
	 */
	@SuppressWarnings({ "unchecked" })
	public Set<Contact> getAllContacts() {
		List<Contact> contacts = new LinkedList<Contact>();
		try {
			Session session = HibernateUtil.getSessionFactory().openSession();
			//List<Contact> listContacts = session.createQuery("from Contact").list();
			List<Contact> listContacts = session.createCriteria(Contact.class).setFetchMode("groups", FetchMode.SELECT).list();
			for(Contact contact : listContacts) {
				Contact c = new Contact(contact);
				c.setContact_ID(contact.getContact_ID());
				contacts.add(c);
			}
			

			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return new HashSet<Contact>(contacts);
	}
	

	/**
	 * Get a set of all groups
	 * 
	 * @return an hashset of all groups
	 */
	@SuppressWarnings("unchecked")
	public Set<Group> getAllGroups() {
		List<Group> listGroups = null;
		try {
			Session session = HibernateUtil.getSessionFactory().openSession();
			listGroups = session.createCriteria(Group.class).list();
			session.close();
		} catch (HibernateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new HashSet<Group>(listGroups);
	}
	
	
	
	/**
	 * Get a group by an id
	 * @param groupId : long
	 * @return an object Group
	 */
	public Group getGroup(long groupId) {
		Group group = null;
		try {
			Session session = HibernateUtil.getSessionFactory().openSession();
			group = (Group) session.createCriteria(Group.class).add(Restrictions.like("group_ID", groupId)).uniqueResult();
			session.close();
			return group;
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		
		return group;
	}
	
	
	
	public Set<Contact> getContactsByGroupId(long groupId) {
		Set<Contact> contacts = null;
		try {
			Session session = HibernateUtil.getSessionFactory().openSession();

			// Build query
			StringBuilder sb = new StringBuilder();
			sb.append("select c from Contact as c join c.groups as g where g.group_ID = :groupId");

			// Execute query
			Query query = session.createQuery(sb.toString());
			query.setParameter("groupId", groupId);
			@SuppressWarnings("unchecked")
			List<Contact> list = (List<Contact>) query.list();
			contacts = new HashSet<>(list);
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return contacts;
	}

	/**
	 * Seach a Contact by : firstname, lastname, country, group name
	 * 
	 * @param keywords
	 * @return contacts : a set of Contact
	 */
	public Set<Contact> searchContacts(String search) {
		Set<Contact> contacts = null;
		try {
			String[] words = search.split(" ");
			List<String> setKeyWords = new ArrayList<String>(Arrays.asList(words));
			Session session = HibernateUtil.getSessionFactory().openSession();

			// Build query
			StringBuilder sb = new StringBuilder();
			sb.append("select c from Contact as c join c.groups as g where c.nom in (:keyWords) or c.prenom in (:keyWords) or c.adress.country in (:keyWords)");
			sb.append(" or g.groupName in (:keyWords)");

			// Execute query
			Query query = session.createQuery(sb.toString());
			query.setParameterList("keyWords", setKeyWords);
			@SuppressWarnings("unchecked")
			List<Contact> list = (List<Contact>) query.list();
			contacts = new HashSet<>(list);
			session.close();
		} catch (HibernateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return contacts;
	}

	// ****************************** Update ********************************

	/**
	 * Save and update a contact
	 * @param contact
	 * @return
	 */
	public boolean update(Contact contact) {
		boolean result = false;
		try {
			Session session = HibernateUtil.getSessionFactory().openSession();
			session.beginTransaction();
			session.update(contact);
			for (PhoneNumber pn : contact.getPhones()) {
				session.update(pn);
			}
			
			session.getTransaction().commit();
			session.close();
			
			result = true;
		} catch (HibernateException e) {
			e.printStackTrace();
			e.getMessage();
		}
		return result;
	}
	
	/**
	 * Save and update a group
	 * 
	 * @param contact
	 * @return
	 */
	public boolean update(Group group) {
		boolean result = false;
		try {
			Session session = HibernateUtil.getSessionFactory().openSession();
			session.beginTransaction();
			session.update(group);
			session.getTransaction().commit();
			session.close();
			
			result = true;
		} catch (HibernateException e) {
			e.printStackTrace();
			e.getMessage();
		}
		return result;
	}
	
	


	
	
	// ****************************** Delete ********************************
	
	public boolean deleteContact(long contactId) {
		boolean result = false;
		try {
			Session session = HibernateUtil.getSessionFactory().openSession();
			session.beginTransaction();
			Contact contact = (Contact)session.get(Contact.class, contactId);
			contact.setGroups(null);
			session.delete(contact);
			session.getTransaction().commit();
			result = true;
			session.close();
		} catch (HibernateException e) {
			e.getMessage();
			e.printStackTrace();
			result = false;
		} catch(Exception e) {
			e.getMessage();
			result = false;
		}
		
		System.out.println("Result = " + result);
		return result;
	}
	
	/**
	 * Method to delete a group
	 * @param group_ID
	 * @return true if the group was deleted ; otherwise false
	 */
	public boolean deleteGroup(long group_ID) {
		boolean result = false;
		try {
			Session session = HibernateUtil.getSessionFactory().openSession();
			session.beginTransaction();
			Group group = (Group) session.get(Group.class, group_ID);
			for (Contact contact : group.getContacts()) {
				contact.getGroups().remove(group);
				session.update(contact);
			}
			session.delete(group);
			session.getTransaction().commit();
			session.close();
			result = true;
		} catch (HibernateException e) {
			e.getMessage();
			e.printStackTrace();
			result = false;
		} catch(Exception e) {
			e.getMessage();
			result = false;
		}
		
		System.out.println("Result = " + result);
		return result;
	}



}