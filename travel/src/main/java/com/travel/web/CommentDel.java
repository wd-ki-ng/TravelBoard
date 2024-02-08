package com.travel.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.travel.dao.CommentDAO;
import com.travel.dto.CommentDTO;
import com.travel.util.Util;

@WebServlet("/commentDel")
public class CommentDel extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CommentDel() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int result = 0;
		HttpSession session = request.getSession();
		if (session.getAttribute("mid") != null && Util.intCheck(request.getParameter("no"))) {

			CommentDTO dto = new CommentDTO();
			dto.setMid((String) session.getAttribute("mid"));
			dto.setCno(Util.str2Int(request.getParameter("no")));

			CommentDAO dao = new CommentDAO();
			result = dao.commentDelete(dto);

			PrintWriter pw = response.getWriter();
			pw.print(result);

		}

	}

}
