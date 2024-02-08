package com.travel.web;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.travel.dao.MemberDAO;
import com.travel.dto.MemberDTO;

@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Login() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		if (session.getAttribute("mid") != null && session.getAttribute("mname") != null ) {
			response.sendRedirect("./error.jsp");
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MemberDTO dto = new MemberDTO();
		HttpSession session = request.getSession();
		dto.setMid(request.getParameter("id"));
		dto.setMpw(request.getParameter("pw"));

			MemberDAO dao = new MemberDAO();
			dto = dao.login(dto);

			if (dto.getCount() == 1) {
				session.setAttribute("mname", dto.getMname());
				session.setAttribute("mid", dto.getMid());
				session.setAttribute("mhint", dto.getMhint());
				session.setAttribute("manswer", dto.getManswer());
				response.sendRedirect("./index");
			} else {
				request.setAttribute("errorMSG", "로그인에 실패하였습니다. 아이디와 비밀번호를 확인해주세요.");
				RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
				rd.forward(request, response);
			}
	}
}
