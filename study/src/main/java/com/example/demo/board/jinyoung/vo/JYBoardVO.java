package com.example.demo.board.jinyoung.vo;

public class JYBoardVO {

	// VO 생성하기
	
	private String seq;				// 글번호
	private String userid;		// 사용자ID
	private String name;			// 작성자
	private String subject;			// 제목
	private String pwd;				// 비밀번호
	private String content;			// 글내용
	private String readCount;		// 조회수
	private String regDate;			// 작성일
	private String status;			// 글삭제 여부 1: 사용가능한 글, 0: 삭제된 글
	private String commentCount;	// 댓글 수
	private String date;			// 날짜 (캘린더)
	
	// 기본 생성자
	public JYBoardVO() {}
	
	// getter setter
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReadCount() {
		return readCount;
	}
	public void setReadCount(String readCount) {
		this.readCount = readCount;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(String commentCount) {
		this.commentCount = commentCount;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
	
}
