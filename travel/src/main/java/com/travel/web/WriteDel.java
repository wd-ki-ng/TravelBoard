package com.travel.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.travel.dao.BoardDAO;
import com.travel.dto.BoardDTO;
import com.travel.util.Util;

@WebServlet("/writedel")
public class WriteDel extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public WriteDel() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		if (session.getAttribute("mid") != null && Util.intCheck(request.getParameter("no"))) {

			BoardDTO dto = new BoardDTO();
			BoardDAO dao = new BoardDAO();
			
			dto.setNo(Util.str2Int(request.getParameter("no")));
			dto.setDel(Util.str2Int(request.getParameter("del")));
			dto.setInout(Util.str2Int(request.getParameter("inout")));
			dto.setMid((String) session.getAttribute("mid"));
			
			int result = dao.writeDel(dto);

			request.setAttribute("detail", dto);
			
			if (result == 1) {
				if (dto.getInout() == 0) {
					response.sendRedirect("./inboard");
				} else {
					response.sendRedirect("./outboard");
				}
			} else {
				response.sendRedirect("./error.jsp");
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

}
