# Exchange Platform WebApp using JSP and MySQL

This is short setup guide and tips for future reference :)

### Tool List:

* [XAMPP](https://www.apachefriends.org/download.html) (Dev Server: MySQL DB Host)
* [Latest JDK ](https://adoptopenjdk.net/?variant=openjdk11&jvmVariant=hotspot)(Compile JSP and additional packages)
* [MySQL ODBC Connector](https://dev.mysql.com/downloads/connector/odbc/) (Allows DB access to java part)
* { Optional } [NetBeans with Tomcat](https://netbeans.apache.org/download/nb110/nb110.html) (Dev Server: Host jsp app)

Ofcourse the above list is not THE way to do it, but this is how I started it. For example, you could host your jsp app with XAMPP apache server as well, but I didn't do that. But you could.

---

### Setup Tips:

* #### IMPORTANT:
  * ALWAYS create a new user that is granted permission ONLY to access the userbase in your app. Here, only 1 worker and root is allowed to access exchangeplatform DB.
  * Make sure JAVA_HOME and JDK_HOME envt variables (for both linux and windows) are setup correctly to potentially prevent a LOT of IDE setup pain.

* #### NETBEANS
  * File > New Project > Java Web > Web Application
  * Server: Apache Tomcat x.x.x.x
  * File Organisation:
    * assests, scripts, css etc in web/
    * servlets, java files etc in src/java/{package_name}/

* #### ODBC
  * Setup ODBC Data Sources via Administrator
  * System DSN > Add > MySQL ODBC x.x Driver > Fill the DB details.


---

This is it more or less. I'll add anything I find interesting / worth mentioning for future me :)