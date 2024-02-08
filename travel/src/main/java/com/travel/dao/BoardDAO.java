package com.travel.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.travel.dto.BoardDTO;
import com.travel.dto.CommentDTO;

public class BoardDAO extends AbstractDAO {

	public List<BoardDTO> inboardList(int page) {
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM boardview WHERE tboard_inout=0 AND tboard_del=1 ORDER BY tboard_date DESC LIMIT ?, 10";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, (page - 1) * 10);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardDTO e = new BoardDTO();
				e.setNo(rs.getInt("tboard_no"));
				e.setTitle(rs.getString("tboard_title"));
				e.setWrite(rs.getString("tboard_write"));
				e.setCount(rs.getInt("tboard_count"));
				e.setDate(rs.getString("tboard_date"));
				e.setLike(rs.getInt("tboard_like"));
				e.setInout(rs.getInt("tboard_inout"));
				e.setDel(rs.getInt("tboard_del"));
				e.setHeader(rs.getString("tboard_header"));
				e.setComment(rs.getInt("tcomment_count"));
				list.add(e);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, con);
		}
		return list;
	}

	public List<BoardDTO> outboardList(int page) {
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT tboard_no, tboard_title, tboard_write, tboard_count, tboard_date, tboard_like, tboard_inout, tboard_del, tboard_header, tcomment_count"
				+ " FROM boardview WHERE tboard_inout=1 ORDER BY tboard_date DESC LIMIT ?,10";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, (page - 1) * 10);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardDTO e = new BoardDTO();
				e.setNo(rs.getInt("tboard_no"));
				e.setTitle(rs.getString("tboard_title"));
				e.setWrite(rs.getString("tboard_write"));
				e.setCount(rs.getInt("tboard_count"));
				e.setDate(rs.getString("tboard_date"));
				e.setLike(rs.getInt("tboard_like"));
				e.setInout(rs.getInt("tboard_inout"));
				e.setDel(rs.getInt("tboard_del"));
				e.setHeader(rs.getString("tboard_header"));
				e.setComment(rs.getInt("tcomment_count"));
				list.add(e);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, con);
		}

		return list;
	}

	// 상세보기 가져오기
	public BoardDTO detail(int no) {
		BoardDTO dto = new BoardDTO();
		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT b.tboard_no, b.tboard_title, b.tboard_content, m.mname AS tboard_write, m.mid AS mid ,b.tboard_date, b.tboard_inout, b.tboard_del ,(SELECT COUNT(*) FROM tvisit WHERE tboard_no=b.tboard_no) AS tboard_count, (SELECT COUNT(*) FROM tblike l WHERE l.tboard_no = b.tboard_no) AS tboard_like "
				+ "FROM tboard b JOIN tmember m ON b.mno=m.mno " + "WHERE b.tboard_no=?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setNo(rs.getInt("tboard_no"));
				dto.setTitle(rs.getString("tboard_title"));
				dto.setContent(rs.getString("tboard_content"));
				dto.setInout(rs.getInt("tboard_inout"));
				dto.setInout(rs.getInt("tboard_del"));
				dto.setWrite(rs.getString("tboard_write"));
				dto.setDate(rs.getString("tboard_date"));
				dto.setCount(rs.getInt("tboard_count"));
				dto.setMid(rs.getString("mid"));
				dto.setLike(rs.getInt("tboard_like"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, con);
		}
		return dto;
	}

	// 디테일에 댓글목록 가져오기
	public List<CommentDTO> commentList(int no) {
		List<CommentDTO> list = new ArrayList<CommentDTO>();
		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM tcommentview WHERE board_no=?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				CommentDTO dto = new CommentDTO();
				dto.setCno(rs.getInt("cno"));
				dto.setTboard_no(rs.getInt("board_no"));
				dto.setCcomment(rs.getString("ccomment"));
				dto.setCdate(rs.getString("cdate"));
				dto.setClike(rs.getInt("clike"));
				dto.setMno(rs.getInt("mno"));
				dto.setMid(rs.getString("mid"));
				dto.setMname(rs.getString("mname"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, con);
		}

		return list;
	}

	// 게시판 글 작성하기
	public int write(BoardDTO dto) {
		int result = 0;
		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO tboard (tboard_title, tboard_content,tboard_inout, mno, tboard_write, tboard_header) "
				+ "VALUES (?, ?, ?, (SELECT mno FROM tmember WHERE mid=?),(SELECT mname FROM tmember WHERE mid=?),?)";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getInout());
			pstmt.setString(4, dto.getMid());
			pstmt.setString(5, dto.getMid());
			pstmt.setString(6, dto.getHeader());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(null, pstmt, con);
		}
		return result;
	}

	public int writeedit(BoardDTO dto) {

		int result = 0;
		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		String sql = "UPDATE tboard SET tboard_title = ?, tboard_content= ? WHERE tboard_no=? AND mno=(SELECT mno FROM tmember WHERE mid=?)";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNo());
			pstmt.setString(4, dto.getMid());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(null, pstmt, con);
		}
		return result;
	}

	public int writeDel(BoardDTO dto) {
		int result = 0;
		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		String sql = "UPDATE tboard SET tboard_del = '0' WHERE tboard_no=? AND mno=(SELECT mno FROM tmember WHERE mid=?)";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getNo());
			pstmt.setString(2, dto.getMid());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(null, pstmt, con);
		}
		return result;
	}

	public void countup(int no, String mid) {
		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		String sql = "SELECT COUNT(*) FROM tvisit WHERE tboard_no=? AND mno=(SELECT mno FROM tmember WHERE mid=?)";
		ResultSet rs = null;

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.setString(2, mid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				int result = rs.getInt(1);
				if (result == 0) {
					realCountUp(no, mid);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, con);
		}
	}

	private void realCountUp(int no, String mid) {

		Connection con = db.getConnection();
		PreparedStatement insertpstmt = null;
		PreparedStatement updatepstmt = null;
		String insertsql = "INSERT INTO tvisit(tboard_no, mno) VALUES (? , (SELECT mno FROM tmember WHERE mid=?))";
		String updatesql = "UPDATE tboard SET tboard_count=tboard_count+1 WHERE tboard_no=?";

		try {
			insertpstmt = con.prepareStatement(insertsql);
			updatepstmt = con.prepareStatement(updatesql);
			insertpstmt.setInt(1, no);
			insertpstmt.setString(2, mid);
			updatepstmt.setInt(1, no);

			insertpstmt.executeUpdate();
			updatepstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(null, updatepstmt, con);
		}
	}

	public List<BoardDTO> inHotList() {

		List<BoardDTO> list = new ArrayList<BoardDTO>();

		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT tboard_no, tboard_title, tboard_inout, tboard_header FROM boardview WHERE tboard_inout=0 ORDER BY tboard_like DESC LIMIT 10";

		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardDTO e = new BoardDTO();
				e.setNo(rs.getInt("tboard_no"));
				e.setTitle(rs.getString("tboard_title"));
				e.setInout(rs.getInt("tboard_inout"));
				e.setHeader(rs.getString("tboard_header"));
				list.add(e);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, con);
		}
		return list;
	}

	public List<BoardDTO> outHotList() {

		List<BoardDTO> list = new ArrayList<BoardDTO>();

		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT tboard_no, tboard_title, tboard_inout, tboard_header FROM boardview WHERE tboard_inout=1 ORDER BY tboard_like DESC LIMIT 10";

		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardDTO e = new BoardDTO();
				e.setNo(rs.getInt("tboard_no"));
				e.setTitle(rs.getString("tboard_title"));
				e.setInout(rs.getInt("tboard_inout"));
				e.setHeader(rs.getString("tboard_header"));
				list.add(e);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, con);
		}
		return list;
	}
	public int boardUp(BoardDTO dto) {// 게시물 추천 중복 확인[미우]
		int result = 0;
		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		String sql = "SELECT COUNT(*) FROM tblike WHERE tboard_no=? AND mno=(SELECT mno FROM tmember WHERE mid=?)";
		ResultSet rs = null;
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getNo());
			pstmt.setString(2, dto.getMid());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getInt(1) == 0) {
					result = realUp(dto);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, con);
		}
		
		return result;
	}

	private int realUp(BoardDTO dto) {//게시물 추천 올리기[미누]
		int result = 0;
		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO tblike (mno, tboard_no) VALUES ((SELECT mno FROM tmember WHERE mid=?), ?)";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getMid());
			pstmt.setInt(2, dto.getNo());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(null, pstmt, con);
		}
		return result;
	}

	public int intotalCount() { // 국내게시판 총 게시물 수[민우]
		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) FROM boardview WHERE tboard_inout=0";
		int result = 0;
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, con);
		}
		return result;
	}

	public int outtotalCount() {
		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) FROM boardview WHERE tboard_inout=1";
		int result = 0;
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, con);
		}
		return result;
	}
}
