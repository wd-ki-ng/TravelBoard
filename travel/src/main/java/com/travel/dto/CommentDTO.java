package com.travel.dto;

public class CommentDTO {
	private int cno, tboard_no, mno, clike, cinout, cdel;
	private String ccomment, cdate, mname, mid;
	
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
	public int getTboard_no() {
		return tboard_no;
	}
	public void setTboard_no(int tboard_no) {
		this.tboard_no = tboard_no;
	}
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	public int getClike() {
		return clike;
	}
	public void setClike(int clike) {
		this.clike = clike;
	}
	public int getCinout() {
		return cinout;
	}
	public void setCinout(int cinout) {
		this.cinout = cinout;
	}
	public int getCdel() {
		return cdel;
	}
	public void setCdel(int cdel) {
		this.cdel = cdel;
	}
	public String getCcomment() {
		return ccomment;
	}
	public void setCcomment(String ccoment) {
		this.ccomment = ccoment;
	}
	public String getCdate() {
		return cdate;
	}
	public void setCdate(String cdate) {
		this.cdate = cdate;
	}
}
