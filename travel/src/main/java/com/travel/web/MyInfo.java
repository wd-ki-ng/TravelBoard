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

import com.travel.dao.MemberDAO;
import com.travel.dto.BoardDTO;
import com.travel.dto.CommentDTO;
import com.travel.dto.MemberDTO;

@WebServlet("/myInfo")
public class MyInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MyInfo() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//      response.getWriter().append("Served at: ").append(request.getContextPath());

		// 세션 가져오기
		HttpSession session = request.getSession();

		if (session.getAttribute("mid") == null) {
			// 만약 mid 세션이 없으면 로그인 페이지로
			response.sendRedirect("./login");

		} else { // mid 세션 있으면 정보 가져오기

			// dto에 세션값 담기
			MemberDTO dto = new MemberDTO();
			dto.setMid((String) session.getAttribute("mid"));

			// dao에 dto 담기
			MemberDAO dao = new MemberDAO();
			dto = dao.myInfo(dto);

			// jsp에서 사용할 myInfo 만들기
			request.setAttribute("myInfo", dto);

			// 내가 쓴 글 보기
			List<BoardDTO> mylist = dao.mylist(dto);
			request.setAttribute("mylist", mylist);

			// 내가 쓴 댓글 보기
			List<CommentDTO> myclist = dao.myclist(dto);
			request.setAttribute("myclist", myclist);

			RequestDispatcher rd = request.getRequestDispatcher("myInfo.jsp");
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//      doGet(request, response);

		// 세션 만들기
		HttpSession session = request.getSession();

		// 비번 수정
		MemberDTO dto = new MemberDTO();
		dto.setMpw(request.getParameter("newPW"));

		// dto에 세션값 담기(mid 매치시켜주기)
		dto.setMid((String) session.getAttribute("mid"));

		MemberDAO dao = new MemberDAO();
		int result = dao.newpw(dto);

		if(result == 1) {
			response.sendRedirect("./myInfo");
		} else {
			response.sendRedirect("./error.jsp");
		}

	}

}