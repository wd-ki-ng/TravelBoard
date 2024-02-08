package com.travel.web;

import java.io.IOException;
import java.util.List;

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

@WebServlet("/outboard")
public class Outboard extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Outboard() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int page = 1;
		if (request.getParameter("page")!=null && request.getParameter("page") != "") {
			page = Util.str2Int(request.getParameter("page"));
		}
		
		BoardDAO dao = new BoardDAO();
		
		List<BoardDTO> list = dao.outboardList(page);
		
		int totalCount = dao.outtotalCount();
		
		request.setAttribute("list", list);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("page", page);
		
		RequestDispatcher rd = request.getRequestDispatcher("outboard.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		BoardDTO dto = new BoardDTO();
		if (session.getAttribute("mid") != null && session.getAttribute("mname") != null) {

		dto.setInout(Util.str2Int(request.getParameter("write")));
		RequestDispatcher rd = request.getRequestDispatcher("./write?write=" + request.getParameter("write"));
		rd.forward(request, response);
		} else 
			response.sendRedirect("./login");
	}

}
