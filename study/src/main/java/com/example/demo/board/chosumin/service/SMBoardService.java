package com.example.demo.board.chosumin.service;

import com.example.demo.board.chosumin.dao.SMBoardDAO;
import com.example.demo.board.chosumin.dto.SMBoardDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.logging.Logger;

@Service
public class SMBoardService {

    Logger logger = Logger.getLogger(SMBoardDAO.class.getName());

    @Autowired
    SMBoardDAO smBoardDAO;

    public List<SMBoardDTO> getBoardList(){
        return smBoardDAO.getBoardList();
    }
}
