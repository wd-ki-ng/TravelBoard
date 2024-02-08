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

@WebServlet("/idFind")
public class IdFind extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public IdFind() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/find.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String hint = request.getParameter("hint");
		//System.out.println(name);
		//System.out.println(hint);
		MemberDTO dto = new MemberDTO();
		dto.setMname(name);
		dto.setMhint(hint);
		
		MemberDAO dao = new MemberDAO();
		String result = dao.idFind(dto);
		if(result == null) {
			result = "";
		}
		//System.out.println("result 값은 ? : " + result);
		PrintWriter pw = response.getWriter();
		pw.print(result);
		pw.close();
	}

}
