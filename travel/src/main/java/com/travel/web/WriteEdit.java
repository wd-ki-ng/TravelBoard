package com.travel.web;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.travel.dao.BoardDAO;
import com.travel.dto.BoardDTO;
import com.travel.util.Util;

@WebServlet("/writeedit")
public class WriteEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public WriteEdit() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		if (session.getAttribute("mid") != null && Util.intCheck(request.getParameter("no"))) {
			int no = Util.str2Int(request.getParameter("no"));

			BoardDAO dao = new BoardDAO();
			BoardDTO dto = dao.detail(no);

			request.setAttribute("write", dto);

			RequestDispatcher rd = request.getRequestDispatcher("writeedit.jsp");
			rd.forward(request, response);

		} else {
			response.sendRedirect("./error.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		if (request.getParameter("title") != null && request.getParameter("content") != null
				&& Util.intCheck(request.getParameter("no"))) {

			BoardDTO dto = new BoardDTO();
			BoardDAO dao = new BoardDAO();

			dto.setContent(request.getParameter("content"));
			dto.setTitle(request.getParameter("title"));
			dto.setNo(Util.str2Int(request.getParameter("no")));
			dto.setMid((String) session.getAttribute("mid"));

			int result = dao.writeedit(dto);

			if (result == 1) {
				response.sendRedirect("./detail?no=" + request.getParameter("no"));
			} else {
				response.sendRedirect("./error.jsp");
			}

		} else {
			response.sendRedirect("./error.jsp");
		}
	}

}
