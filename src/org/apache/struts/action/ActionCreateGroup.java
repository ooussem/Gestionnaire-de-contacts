package org.apache.struts.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import service.IContactService;

public class ActionCreateGroup extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		CreateGroupForm ncf = (CreateGroupForm) form;
		if (ncf.getNom().length() > 3) {
			ApplicationContext context = new ClassPathXmlApplicationContext(new String[] { "applicationContext.xml" });
			IContactService IContactService = (service.IContactService) context.getBean("service");
			IContactService.insertDB(ncf.getNom());
			
			return mapping.findForward("ok");
		} else {
			return mapping.findForward("no");
		}
	}

}