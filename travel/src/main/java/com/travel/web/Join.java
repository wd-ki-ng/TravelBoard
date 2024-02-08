package com.travel.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.travel.dao.MemberDAO;
import com.travel.dto.MemberDTO;

@WebServlet("/join")
public class Join extends HttpServlet {
   private static final long serialVersionUID = 1L;

    public Join() {
        super();
    }

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      RequestDispatcher rd = request.getRequestDispatcher("join.jsp");
      rd.forward(request, response);
   }

   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");
      
      if(request.getParameter("id") != null && request.getParameter("pw1") != null 
            && request.getParameter("name") != null) {
         MemberDTO dto = new MemberDTO();
         dto.setMid(request.getParameter("id"));
         dto.setMpw(request.getParameter("pw1"));
         dto.setMname(request.getParameter("name"));
         dto.setMhint(request.getParameter("mhint"));
         dto.setManswer(request.getParameter("manswer"));
         
         MemberDAO dao = new MemberDAO();
         int result = dao.join(dto);
         PrintWriter pw = response.getWriter();
 		 pw.print(result);
 		 pw.close();
      }
   }

}