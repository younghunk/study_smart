package com.example.demo.board.chosumin.service;
import com.example.demo.board.chosumin.dao.SMBoardDAO;
import com.example.demo.board.chosumin.vo.SMBoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class SMBoardService {

    @Autowired
    SMBoardDAO smBoardDAO;

    public List<SMBoardVO> selectBoardAll(){
        return smBoardDAO.selectBoardAll();
    }

    @Transactional
    public String updateBoardList(List<SMBoardVO> boardvo){
        for(int i = 0; i < boardvo.size() ; i++){
            SMBoardVO board = boardvo.get(i);
            String selectType = board.getSelectType();
            if(selectType.equals("write")){
                int resultInt = insertBoard(board);
                if(resultInt < 1){
                    return "문제가 생겼습니다.";
                }
            }else if(selectType.equals("edit")){
                int resultInt = updateBoard(board);
                if(resultInt < 1){
                    return "문제가 생겼습니다.";
                }
            }else if(selectType.equals("delete")){
                int resultInt = deleteBoard(board.getSeq());
                if(resultInt < 1){
                    return "문제가 생겼습니다.";
                }
            }
        }
        return "성공적으로 처리되었습니다.";
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

    public int deleteBoard(int seq){
        return smBoardDAO.deleteBoard(seq);
    }
}
