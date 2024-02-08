package com.travel.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.travel.dao.BoardDAO;
import com.travel.dto.BoardDTO;

@WebServlet("/index")
public class Index extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Index() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// DAO 연결
		BoardDAO dao = new BoardDAO();
		List<BoardDTO> inhotlist = dao.inHotList();
		List<BoardDTO> outhotlist = dao.outHotList();
		
		// jsp에서 사용할 수 있게 만들기
		request.setAttribute("inHotList", inhotlist);
		request.setAttribute("outHotList", outhotlist);
		
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		rd.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
