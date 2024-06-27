package com.example.demo.board.chosumin.service;
import com.example.demo.board.chosumin.dao.SMBoardDAO;
import com.example.demo.board.chosumin.vo.SMBoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SMBoardService {

    @Autowired
    SMBoardDAO smBoardDAO;

    public List<SMBoardVO> selectBoardAll(){
        return smBoardDAO.selectBoardAll();
    }

    public int insertBoard(SMBoardVO board){
        return smBoardDAO.insertBoard(board);
    }

    public SMBoardVO selectBoard(int seq){
        return smBoardDAO.selectBoard(seq);
    }

    public int updateBoard(SMBoardVO board){
        return smBoardDAO.updateBoard(board);
    }

    public int insertReply(SMBoardVO board){
        return smBoardDAO.insertReply(board);
    }

    public int selectSeq(){
        return smBoardDAO.selectSeq();
    }

    public int deleteBoard(int seq){
        return smBoardDAO.deleteBoard(seq);
    }
}
