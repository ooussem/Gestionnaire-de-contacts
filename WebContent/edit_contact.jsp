<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="java.sql.*"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page import="model.*"%>
<%@ page import="service.*"%>
<%@ page import="DAO.*"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.context.support.ClassPathXmlApplicationContext"%>

<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean" %>
<%@ taglib prefix="nested" uri="http://struts.apache.org/tags-nested" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>

<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<%
/* 		Contact contact = request.getAttribute("contact");
		System.out.println("contact" + contact.toString()); */
		String pContactId = request.getParameter("contactId");
		ApplicationContext context = new ClassPathXmlApplicationContext(new String[] { "applicationContext.xml" });
		IContactDao dao = (DAO.IContactDao) context.getBean("dao");
		long contactId = Long.parseLong(pContactId);
		Contact contact = dao.getContact(contactId);
		List<Group> allGroups = new LinkedList<Group>(dao.getAllGroups());
		List<PhoneNumber> phones = new LinkedList<>(contact.getPhones());
		if(!phones.isEmpty())request.setAttribute("phone1", phones.get(0));
		if(phones.size()>1) request.setAttribute("phone2", phones.get(1));
		request.setAttribute("contactId", contactId);
		request.setAttribute("nom", contact.getNom());
		request.setAttribute("prenom", contact.getPrenom());
		request.setAttribute("mail", contact.getMail());
		request.setAttribute("versionContact", contact.getVersion());
		request.setAttribute("adressId", contact.getAdress().getAdress_ID());
		request.setAttribute("country", contact.getAdress().getCountry());
		request.setAttribute("city", contact.getAdress().getCity());
		request.setAttribute("street", contact.getAdress().getStreet());
		request.setAttribute("zip", contact.getAdress().getZip());
		request.setAttribute("groups", contact.getGroups());
		request.setAttribute("phones", contact.getPhones());
		request.setAttribute("allGroups", allGroups);
		
		//request.getSession().setAttribute("contact", contact);
%>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Edit Contact</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="bower_components/font-awesome/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="bower_components/Ionicons/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
        page. However, you can choose any other skin. Make sure you
        apply the skin class to the body tag so the changes take effect. -->
  <link rel="stylesheet" href="dist/css/skins/skin-blue.min.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

  <!-- Google Font -->
  <link rel="stylesheet"
        href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>


<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

  <!-- Main Header -->
  <header class="main-header">

    <!-- Logo -->
    <a href="main.html" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>CM</b></span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><bean:message key="contact.manager" /></span>
    </a>

    <!-- Header Navbar -->
    <nav class="navbar navbar-static-top" role="navigation">
        <!-- Sidebar toggle button-->
        <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
          <span class="sr-only">Toggle navigation</span>
        </a>
        <!-- Navbar Right Menu -->
        <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
              <!-- Messages: style can be found in dropdown.less-->
              <li class="dropdown messages-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <i class="fa fa-plus"></i>
                </a>
                <ul class="dropdown-menu">
                  <li>
                    <!-- inner menu: contains the actual data -->
                    <ul class="menu">
                      <li><!-- start message -->
                        <a href="FormNewContact2.jsp">
                          <div class="pull-left">
                              <medium><i class="fa fa-user"></i></medium>
                          </div>
                          <h4>
                            <bean:message key="add.contact" />
                          </h4>
                        </a>
                      </li>
                      <!-- end message -->
                      <li>
                        <a href="addNewGroup.jsp">
                            <div class="pull-left">
                              <medium><i class="fa fa-group"></i></medium>
                            </div>
                            <h4>
                              <bean:message key="add.group" />
                            </h4>
                          </a>
                      </li>
                    </ul>
                  </li>
                </ul>
              </li>
            </ul>
        </div>
      </nav>
      <!-- Navbar Right Menu -->

    </nav>
  </header>
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">



      <!-- search form (Optional) -->
        <html:form action="SearchContactForm.do" method="post" styleClass="sidebar-form">
          <div class="input-group">
            <input type="text" name="nom" class="form-control" placeholder="Search...">
            <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
          </div>
        </html:form>
      <!-- /.search form -->


      <!-- Sidebar Menu -->
      <ul class="sidebar-menu" data-widget="tree">
        <li class="header">Menu</li>
        <!-- Optionally, you can add icons to the links -->
        <li><a href="main2.jsp"><i class="fa fa-home"></i> <span><bean:message key="main.home" /></span></a></li>
        <li class="active"><a href="ViewContactsForm.do"><i class="fa fa-user"></i> <span><bean:message key="main.contacts" /></span></a></li>
        <li><a href="ViewGroupsForm.do"><i class="fa fa-group"></i> <span><bean:message key="main.groups" /></span></a></li>
    </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>

	
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
      Update ${nom} ${prenom} 
      </h1>
    </section>

    <!-- Main content -->
     <section class="content">
        <div class="row">
            <!-- left column -->
            <div class="col-xs-6">
                <div class="box box-primary">
                    <div class="box-header with-border">
                      <h3 class="box-title">General Elements</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <!-- text input -->
                     <html:form action="EditContactForm.do" method="post">
                        <div class="form-group">
                          <label><bean:message key="first.name" /></label><html:text value="${prenom}" property="prenom" styleClass="form-control"/>
                        </div>

                        <div class="form-group">
                            <label><bean:message key="last.name" /></label><html:text value="${nom}" property="nom" styleClass="form-control"/>
                        </div>

                        <div class="form-group">
                            <label><bean:message key="mail" /></label><html:text value="${mail}" property="mail" styleClass="form-control"/>
                        </div>
                        
                        <div class="form-group">
                            <label><bean:message key="street" /></label><html:text value="${street}" property="street" styleClass="form-control"/>
                        </div>
                        
                        <div class="form-group">
                            <label><bean:message key="city" /></label><html:text value="${city}" property="city" styleClass="form-control"/>
                        </div>
                        
                        <div class="form-group">
                            <label><bean:message key="country" /></label><html:text value="${country}" property="country" styleClass="form-control"/>
                        </div>
                        

                        <div class="form-group">
                            <label><bean:message key="zip" /></label><html:text value="${zip}" property="zip" styleClass="form-control"/>
                        </div>

                        <div class="form-group">
                          <p>
	                        <table class="table table-hover">
	                            <tr>
	                              <th><label>Phone Number</label></th>
	                              <th><label>Phone Kind</label></th>
	                            </tr>
	                            <tr>
	                            	<html:hidden value="${phone1.phone_ID}" property="phoneNumber1Id" styleClass="form-control"/>
                            	  	<td><html:text value="${phone1.phoneNumber}" property="phoneNumber1" styleClass="form-control"/></td>
	                              	<td><html:text value="${phone1.phoneNumber}" property="phoneKind1" styleClass="form-control"/></td>
	                            </tr>
	                            <tr>
                           			<html:hidden value="${phone2.phone_ID}" property="phoneNumber2Id" styleClass="form-control"/>
                              		<td><html:text value="${phone2.phoneNumber}" property="phoneNumber2" styleClass="form-control"/></td>
	                              	<td><html:text value="${phone2.phoneNumber}" property="phoneKind2" styleClass="form-control"/></td>
	                            </tr>
		                    </table>
		                    <html:hidden property="adressId" value="${adressId}"/>
							<html:hidden property="contactId" value="${contactId}"/>
							<html:hidden property="versionContact" value="${versionContact}"/>
							<button type="submit" class="btn btn-success btn-xs">Update</button>
						</div>
					</html:form>
                      </div>

                    </div>
                    <!-- /.box-body -->
                  
            </div>
            <div class="col-xs-6">
              <div class="box box-primary">
                  <div class="box-header with-border">
                    <h3 class="box-title"><bean:message key="main.groups" /></h3>
                  </div>
                  <!-- /.box-header -->
                  <div class="box-body">
                      <!-- text input -->
                      <table class="table table-hover">
	                      <logic:iterate id="group" name="groups">
	                      <tr>
		                        <td><h5 class="description-header"><bean:write name="group" property="groupName"/></h5></td>
		                        <td>
		                        <div class="form-group">
		                        	<html:form action="DeleteContactFromGroupForm.do" method="post">
										<html:hidden property="group_ID" name="group" value="${group.group_ID}"/>
										<html:hidden property="contact_ID" value="${contactId}"/>
											<button type="submit" class="btn btn-danger btn-xs">Delete</button>
									</html:form>
									</div>
		                      	</td>
	                      </tr>
	                      </logic:iterate>	
                      </table>
                      
                  </div>
                  <!-- /.box-body -->
                </div>
          	</div>
          	
          	            <div class="col-xs-6">
              <div class="box box-primary">
                  <div class="box-header with-border">
                    <h3 class="box-title">Others groups</h3>
                  </div>
                  <!-- /.box-header -->
                  <div class="box-body">
                      <!-- text input -->
                      <table class="table table-hover">
                       <th>Name</th>
                       <th></th>
	                      <logic:iterate id="group" name="allGroups">
		                      <tr>
		                        <td>
		                        	<h5 class="description-header"><bean:write name="group" property="groupName"/></h5>
		                        </td>
		                        <td>
			                        <div class="form-group">
			                        	<html:form action="AddContactToGroupForm.do" method="post">
											<html:hidden property="group_ID" name="group" value="${group.group_ID}"/>
											<html:hidden property="contact_ID" value="${contactId}"/>
											<button type="submit" class="btn btn-success btn-xs">Add contact to this group</button>
										</html:form>
									</div>
		                      	</td>
		                      </tr>
	                      </logic:iterate>	
                      </table>
                      
                  </div>
                  <!-- /.box-body -->
                </div>
          	</div>
          
        </div>
    </section>    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
  <footer class="main-footer">
    <!-- To the right -->
    <div class="pull-right hidden-xs">
      Anything you want
    </div>
    <!-- Default to the left -->
    <strong><bean:message key="footer" /></strong>
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
      <li class="active"><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
      <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
      <!-- Home tab content -->
      <div class="tab-pane active" id="control-sidebar-home-tab">
        <h3 class="control-sidebar-heading">Recent Activity</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <i class="menu-icon fa fa-birthday-cake bg-red"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

                <p>Will be 23 on April 24th</p>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

        <h3 class="control-sidebar-heading">Tasks Progress</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <h4 class="control-sidebar-subheading">
                Custom Template Design
                <span class="pull-right-container">
                    <span class="label label-danger pull-right">70%</span>
                  </span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

      </div>
      <!-- /.tab-pane -->
      <!-- Stats tab content -->
      <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
      <!-- /.tab-pane -->
      <!-- Settings tab content -->
      <div class="tab-pane" id="control-sidebar-settings-tab">
        <form method="post">
          <h3 class="control-sidebar-heading">General Settings</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Report panel usage
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Some information about this general settings option
            </p>
          </div>
          <!-- /.form-group -->
        </form>
      </div>
      <!-- /.tab-pane -->
    </div>
  </aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 3 -->
<script src="bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.min.js"></script>

<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
</body>
</html>