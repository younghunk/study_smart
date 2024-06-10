package com.example.demo.board.hyeonsik.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.demo.board.hyeonsik.dao.PostDao;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Service
public class ExcelService {

    @Autowired
    private PostDao postDao;

    public void generateExcel(HttpServletResponse response) throws IOException {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("게시글");

        // 헤더 생성
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("제목");
        headerRow.createCell(1).setCellValue("내용");
        headerRow.createCell(2).setCellValue("작성일");
        headerRow.createCell(3).setCellValue("추천 수");

        // 데이터 채우기
        List<HashMap<String, Object>> posts = postDao.getAllPosts(null);
        int rowNum = 1;
        for (HashMap<String, Object> post : posts) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue((String) post.get("title")); // 제목
            row.createCell(1).setCellValue((String) post.get("content")); // 내용
            Date createdDate = (Date) post.get("createdDate");
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            row.createCell(2).setCellValue(dateFormat.format(createdDate)); // 작성일
            row.createCell(3).setCellValue((Integer) post.get("viewCnt")); // 추천 수
        }

        // 응답 설정
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment;filename=post.xlsx");

        // 엑셀 파일 출력
        workbook.write(response.getOutputStream());
        workbook.close();
    }
}