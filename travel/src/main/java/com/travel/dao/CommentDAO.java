package com.travel.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.travel.dto.CommentDTO;

public class CommentDAO extends AbstractDAO { 
	
	// 댓글쓰기 
	public int commentWrite(CommentDTO dto) {
		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = "INSERT INTO tcomment (ccomment, tboard_no, mno) VALUES (?, ?, (SELECT mno FROM tmember WHERE MID=?))";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getCcomment());
			pstmt.setInt(2, dto.getTboard_no());
			pstmt.setString(3, dto.getMid());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(null, pstmt, con);
		}
		return result;


	
}
	// 댓글 삭제하기
	public int commentDelete(CommentDTO dto) {
		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		String sql = "UPDATE tcomment SET cdel='0' WHERE cno=? AND mno=(SELECT mno FROM tmember WHERE mid=?)";
		int result = 0;
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getCno());
			pstmt.setString(2, dto.getMid());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(null, pstmt, con);
		}
		
		return result;
	}
	
	// 댓글 좋아요 올리기
		/* public int commentLike(CommentDTO dto) {
			Connection con = db.getConnection();
			PreparedStatement pstmt = null;
			String sql = "UPDATE tcomment SET clike=clike+1 WHERE cno=?";
			
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, dto.getCno());
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close(null, pstmt, con);
				
			}
			
			return result;
		} */
	// 댓글 좋아요 확인
	public int commentLike(CommentDTO dto) {
		int result = 0;
		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) FROM tclike WHERE cno=? AND mno=(SELECT mno FROM tmember WHERE mid=?) AND clike='1'";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getCno());
			pstmt.setString(2, dto.getMid());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				if (rs.getInt(1) == 0) {
					result = realCommentLike(dto);
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, con);
		}
		return result;
		
}
	// 댓글 좋아요 진짜 좋아요
	private int realCommentLike(CommentDTO dto) {
		int result = 0;
		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO tclike (cno, mno, clike) VALUES(?, (SELECT mno FROM tmember WHERE mid=?), '1')";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getCno());
			pstmt.setString(2, dto.getMid());
			result = pstmt.executeUpdate();	
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(null, pstmt, con);
		}
		return result;
	} 
}
