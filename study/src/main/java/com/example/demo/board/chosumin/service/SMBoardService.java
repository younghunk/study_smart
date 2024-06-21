package com.example.demo.board.chosumin.service;

import com.example.demo.board.chosumin.dao.SMBoardDAO;
import com.example.demo.board.chosumin.vo.SMBoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.logging.Logger;

@Service
public class SMBoardService {

    Logger logger = Logger.getLogger(SMBoardDAO.class.getName());

    @Autowired
    SMBoardDAO smBoardDAO;

    public List<SMBoardVO> getBoardList(){
        return smBoardDAO.getBoardList();
    }

    public int addBoard(SMBoardVO board){ return smBoardDAO.addBoard(board);}

    public SMBoardVO getBoard(int seq){
        return smBoardDAO.getBoard(seq);
    }

    public int editBoard(SMBoardVO board){return smBoardDAO.editBoard(board);}

    public int addReply(SMBoardVO board){return smBoardDAO.addReply(board);}
}
