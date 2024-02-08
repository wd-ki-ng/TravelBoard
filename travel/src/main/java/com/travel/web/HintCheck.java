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

@WebServlet("/hintCheck")
public class HintCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public HintCheck() {
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
		MemberDAO dao = new MemberDAO();
		dto.setMname(name);
		dto.setManswer(hint);
		
		int result = dao.hintCheck(dto);
		//System.out.println("result 값은 ? : " + result);
		PrintWriter pwr = response.getWriter();
		pwr.print(result);
		pwr.close();
		
		
	}

}
