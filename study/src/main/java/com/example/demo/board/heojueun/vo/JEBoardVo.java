package com.example.demo.board.heojueun.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class JEBoardVo {
	
	private int seq; // 글 번호
	private String userid; // 아이디
	private String subject; // 제목
	private String content; // 본문
	private int readCount; // 조회수
	private String regDate; // 작성일
	private int status; // 삭제유무
	private int commentCount; // 댓글 수
	private String date; // 날짜
	private int groupno; // 그룹번호
	private int fkSeq; // 답변글일 경우 원글의 seq, 원글일 경우 0
	private int depthno; // 답변글이라면 부모글의 depthno +1, 원글일 경우 0
	
	public JEBoardVo() {}
}
