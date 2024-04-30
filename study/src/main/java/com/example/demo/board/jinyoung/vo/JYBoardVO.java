package com.example.demo.board.jinyoung.vo;

public class JYBoardVO {

	// VO 생성하기
	
	private int seq;				// 글번호
	private String userid;			// 사용자ID
	private String subject;			// 제목
	private String content;			// 글내용
	private int readCount;		// 조회수
	private String regDate;			// 작성일
	private int status;			// 글삭제 여부 1: 사용가능한 글, 0: 삭제된 글
	private int commentCount;	// 댓글 수
	private String date;			// 날짜 (캘린더)
	
	private int groupno;			// 그룹번호 원글과 답변글은 동일한 groupno를 가진다. 답변글이 아닌 원글의 경우 groupno 의 값은 groupno 컬럼의 최대값 (max)+1 로 한다.
	private int fk_seq;			// 답변글의 원글이 누구인지에 대한 정보값, 원글인 경우 0 을 가짐
	private int depthno;			// 답변글이라면 원글의 depthno + 1 을 가지게 되며 원글의 경우 0 을 가짐
	
	
	// 기본 생성자
	public JYBoardVO() {}
	
	// getter setter
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}

	public int getGroupno() {
		return groupno;
	}

	public void setGroupno(int groupno) {
		this.groupno = groupno;
	}
	
	public int getFk_seq() {
		return fk_seq;
	}

	public void setFk_seq(int fk_seq) {
		this.fk_seq = fk_seq;
	}

	public int getDepthno() {
		return depthno;
	}

	public void setDepthno(int depthno) {
		this.depthno = depthno;
	}
	
	
}
