<%-- 
    Document   : index
    Created on : 9-apr-2013, 13.04.05
    Author     : Fede
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="LibraryAMuse.*" %> 
<%@page import="java.util.*"%>

<!DOCTYPE html>

<html>
    <head>
    <meta charset="ISO-8859-1">
    <link rel="shortcut icon" href="am.ico" />
    <link href='http://fonts.googleapis.com/css?family=Droid+Sans' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,300,500' rel='stylesheet' type='text/css'/>
    <title>aMuse</title>
    <link rel="stylesheet" type="text/css" href="css/layout.css" />
    <script type="text/javascript" src="scripts/jquery.js"></script>
    <script type="text/javascript" src="scripts/jquery.transit.min.js"></script>
    <script type="text/javascript" src="scripts/layout.js"></script>
    <script type="text/javascript" src="scripts/counter.js"></script>
    <script type="text/javascript" src="scripts/popup.js"></script>
    <script type="text/javascript" src="scripts/exh_manager.js"></script>
    
  </head>
  
    <body>
        <%
         String email=(String)session.getAttribute("email"); 
        if(!email.equals("root@root.it")){}else{
      
            String Ideh=request.getParameter("IDEH");
            int id_exhibition= Integer.parseInt(Ideh);
            Exhibition ex=DBconnection.SearchSingleExhibition(id_exhibition);
        %>
        
<div id="error_popup"><div class="error_message">
                <div style="width: 100%; height: 0px;"><div class="ics"></div></div>
                <p class="error_message_text">You can only select 20 or less works.</p></div></div>
        <div id="error2_popup"><div class="error_message">
                <div style="width: 100%; height: 0px;"><div class="ics"></div></div>
                <p class="error_message_text">You must choose at least one work.</p></div></div>

        <div id="email_popup">
            <div id="email_box">
                <div style="width: 100%; height: 0px;"><div class="ics"></div></div>
                <form action="confirmation_eng.jsp">
                <div id="email_box_up">
                    <br/><br/>
                  <p id="popup_email_text">Insert your email:</p>
                  <br/>
                  <input type="email" name="user_email" autocomplete="off" placeholder="email" autofocus required id="email_input">
                  <input id="selected_string" type="text" name="user_selected" value="">
                  <input class="exhibition" type="text" name="IDEH" value="<% out.println(Ideh); %>">
               </div>
               <div id="email_box_down">
                <input type="submit" id="button_email" value="SUBMIT">
               </div>
             </form>
            </div>
        </div>
               
        <div id="warning_popup">
            <div id="warning_box">
                <div style="width: 100%; height: 0px;"><div class="ics"></div></div>
                <div id="warning_box_up">
                    <br/>
                    <h2>ATTENZIONE!</h2>
                    <br/>
                    Se cambi lingua le opere verranno deselezionate.
                    <br/><br/><br/>
                    Vuoi continuare?
                </div>
                <%  
                  out.println("<a href=\"CreateBook.jsp?IDEH="+ex.getID()+"\"><div id=\"warning_box_down_left\">SI</div></a>");                
                  out.println("<a id=\"stop\" href=\"\" onclick=\"return false;\"><div id=\"warning_box_down_right\">NO</div></a>"); 
                %>                
            </div>
        </div>

        
        <div id="red_line">
            
            <div id="red_line_wrapper">
              <div class="guide_shadow"></div>
              <div class="guide_shadow"></div>
              <div class="guide_shadow"></div>
              <a href="" onclick="return false;"><img id="flag" src="images/flag_ita.jpg" style="width: 25px; height: 15px; float: right; margin-top: 5px; margin-left: 10px;"></a>

                <a id="go_back" href="exhibitions.jsp">GO BACK TO THE EXHIBITIONS</a>
                <a href="exhibitions.jsp"><img style="float:right; margin-top: 7px;" src="images/back.jpg"></a>
            </div>
        </div>
        
    <div id="top_wrapper">

      <div class="guide">
        <p class="guide_number">2</p>
        <p class="guide_text">Choose what you like: <br>
            <span class="red"><span id="counter">0</span> selected</span></p>
      </div>
        
      <a id="go_bottom" href="" onclick="return false;">
        <div class="guide" >
          <p class="guide_number">3</p>
          <p class="guide_text">Choose another<br>
              <span class="red">EXHIBITION</span></p>
        </div>
      </a>  
        
      <a id="create" href="" onclick="return false;">
        <div class="guide" >
          <p class="guide_number">4</p>
          <p class="guide_text">When you are done click: <br>
              <span class="red">CREATE BOOK</span></p>
        </div>
      </a>

      <div id="title_area"><p id="title"><% out.println(ex.getTitle_eng()); %></p></div>
      <div id="logo_area"><img src="images/logo.jpg" alt="aMuse" height="62" width="229"></div>
      <div id="separator"></div>
    </div>
                
        <% 
            if(ex != null) {  
            ArrayList<Exhibition> lsex=DBconnection.ActiveExhibition();
        %>
                
          <div id="content_wrapper"> 
              <p id="selector" title="<% out.println(ex.getID());%>"></p>
              
              <ul>
            <% 
              for(Exhibition exh : lsex){
                  out.println("<li class=\"exhibition_wrapper\" id=\""+exh.getID()+"\">");
                  out.println("<a href=\"\" onclick=\"return false\">");
                  out.println("<div class=\"exhibition_title\">");
                  out.println("<p class=\"exh_title_text\">"+exh.getTitle_eng()+"</p></div></a>");
                  out.println("<div class=\"exhibition_objects\">");
                  
                  Exhibition exh_all=DBconnection.SearchSingleExhibition(exh.getID());
                    for(Work w: exh_all.getListWorks()){
                        out.println("<div class=\"spacer\">");
                        out.println("<div class=\"object_wrapper\">");
                        out.println("<p class=\"object_id\" title=\""+w.getIdWork()+"\"></p>");
                        out.println("<div class=\"object_image\" style=\"background-image: url(imagesExhibition/"+w.getURLimg1()+");\"> </div>");
                        out.println("<div class=\"object_button\"> <p class=\"object_description\">"+ w.getTitle() +"</p></div>");
                        out.println("</div>");
                        out.println("</div>");
                    }
                  out.println("</div></li>");
              }
            %>
            </ul>
        </div>
            <% } } %>
             
    </body>
</html>
